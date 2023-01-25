#!/bin/bash

# Set the base URL of the API
API_URL="http://18.130.189.49:5000"

# Test GET request to /
echo "Testing GET request to /"
response=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL/")
if [[ $response == "200" ]]; then
    echo "GET request to / was successful"
else
    echo "GET request to / failed"
    exit 1
fi

# Test GET request to /animals
echo "Testing GET request to /animals"
response=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL/animals")
if [[ $response == "200" ]]; then
    echo "GET request to /animals was successful"
else
    echo "GET request to /animals failed"
    exit 1
fi

# Test POST request to /animals
echo "Testing POST request to /animals"
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d '{"name":"Lion","type":"Mammal"}' "$API_URL/animals")
if [[ $response == "200" ]]; then
    echo "POST request to /animals was successful"
else
    echo "POST request to /animals failed"
    exit 1
fi

# Test PUT request to /animals/<animal_id>
echo "Testing PUT request to /animals/$animal_id"
response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT -H "Content-Type: application/json" -d '{"name":"tiger"}' $API_BASE_URL/animals/$animal_id)
if [[ $response == "200" ]]; then
  echo "PUT Request to /animals/$animal_id was successful." >> score.txt
else
  echo "PUT Request to /animals/$animal_id failed." >> score.txt
fi

# Test DELETE request to /animals/<animal_id>
echo "Testing DELETE request to /animals/$animal_id"
response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE $API_BASE_URL/animals/$animal_id)
if [[ $response == "200" ]]; then
  echo "DELETE Request to /animals/$animal_id was successful." >> score.txt
else
  echo "DELETE Request to /animals/$animal_id failed." >> score.txt
fi