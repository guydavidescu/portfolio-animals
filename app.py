from flask import Flask, jsonify, render_template, request
import pymongo
from pymongo import MongoClient
from bson.objectid import ObjectId


app = Flask(__name__)

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
    db = get_db()
    try:
        db = get_db()
        col= db["animal_tb"]
        _animals = col.find()
        animals = [{ "name": animal["name"], "type": animal["type"]} for animal in _animals]
        return jsonify({"animals": animals})
    except:
        pass
    finally:
        if type(db)==MongoClient:
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

# Handle POST request to add a new animal
@app.route("/animals", methods=["POST"])
def add_animal():
    db = get_db()
    col= db["animal_tb"]
    _animals = col.find()
    animal_data = request.get_json()
    result = col.insert_one(animal_data)
    return jsonify({"_id": str(result.inserted_id)})


# Handle PUT request to update an animal
@app.route("/animals/<animal_id>", methods=["PUT"])
def update_animal(animal_id):
    db = get_db()
    col= db["animal_tb"]
    animal_data = request.get_json(force=True)
    result = col.update_one({"_id": ObjectId(animal_id)}, {"$set": animal_data})
    if result.modified_count:
        return jsonify({"message": "Animal updated successfully"})
    else:
        return jsonify({"error": "Animals not found"}), 404    

# Handle DELETE request to delete an animal
@app.route("/animals/<animal_id>", methods=["DELETE"])
def delete_animal(animal_id):
    db = get_db()
    col= db["animal_tb"]
    result = col.delete_one({"_id": ObjectId(animal_id)})
    if result.deleted_count:
        return jsonify({"message": "Animal deleted successfully"})
    else:
        return jsonify({"error": "Animals not found"}), 404


if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5000)