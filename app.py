from flask import Flask, jsonify, render_template, request
import pymongo
from pymongo import MongoClient
from bson.objectid import ObjectId
from random import choice
import bson
from bson import ObjectId
from bson.errors import InvalidId
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)
metrics= PrometheusMetrics(app, group_by='endpoint')

def get_db():
    client = MongoClient(host='test_mongodb',
                         port=27017, 
                         username='root', 
                         password='pass',
                        authSource="admin")
    db = client["animal_db"]
    return db

@app.route('/')
def ping_server():
     return render_template("home.html")

@app.route("/animals", methods=["GET"])
def get_stored_animals():
    try:
        db = get_db()
        col= db["animal_tb"]
        _animals = col.find()
        animals = [{ "name": animal["name"], "type": animal["type"]} for animal in _animals]
        return jsonify({"animals": animals})
    except Exception as e:
        return jsonify({"error": f"Error while fetching animals: {str(e)}"}), 500
    finally:
        if type(db) == MongoClient:
            db.close()
    
            
# Handle GET request to get a specific animal
@app.route("/animals/<animal_id>", methods=["GET"])
def get_animal(animal_id):
    db = get_db()
    col= db["animal_tb"]
    animal = col.find_one({"_id": animal_id})
    if animal:
        return jsonify(animal)
    else:
        return jsonify({"error": "Animal not found"}), 404

@app.route("/animals", methods=["POST"])
def add_animal():
    db = get_db()
    col= db["animal_tb"]
    name = request.form.get("name")
    type = request.form.get("type")
    animal_data = {
        "name": name,
        "type": type
    }
    result = col.insert_one(animal_data)
    return jsonify({"_id": str(result.inserted_id)},{"message": "Animal added successfully"})

@app.route("/animals/<animal_id>/update", methods=["POST"])
def update_animal(animal_id):
    animal_id = request.form.get("animal_id")
    animal_id = ObjectId(animal_id)
    
    db = get_db()
    col = db["animal_tb"]
    name = request.form.get("name")
    type = request.form.get("type")
    animal_data = {"name": name, "type": type}
    col.update_one({"_id": animal_id}, {"$set": animal_data})
    return jsonify({"message": "Animal updated successfully"})

@app.route("/animals/<animal_id>/delete", methods=["POST"])
def delete_animal(animal_id):
    animal_id = request.form.get("animal_id")
    animal_id = ObjectId(animal_id)
    
    db = get_db()
    col = db["animal_tb"]

    try:
        animal_id = ObjectId(animal_id)
    except bson.errors.InvalidId:
        return jsonify({"error": "Invalid ObjectId"}), 400

    animal = col.find_one({"_id": animal_id})
    if animal is None:
        return jsonify({"error": "Animal not found"}), 404

    result = col.delete_one({"_id": animal_id})
    if result.deleted_count == 0:
        return jsonify({"error": "Failed to delete animal"}), 500

    return jsonify({"message": "Animal deleted successfully"})

@app.route("/id_for_testing")
def id_for_testing():
    db = get_db()
    col= db["animal_tb"]
    result = list(col.find({}, {"_id": 1}))
    random_id = choice(result)["_id"]
    return str(random_id)


if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5000)