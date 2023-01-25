db = db.getSiblingDB("animal_db");
db.animal_tb.drop();

db.animal_tb.insertMany([
    {
       
        "name": "Lion",
        "type": "wild"
    },
    {
       
        "name": "Cow",
        "type": "domestic"
    },
    {
        
        "name": "Tiger",
        "type": "wild"
    },
    {
       
        "name": "Fox",
        "type": "wild"
    },
    {
       
        "name": "Bear",
        "type": "omnivore"
    },
    {
        
        "name": "Monkey",
        "type": "carnivore"
    },
]);