#!/bin/bash

# Set the base URL of the API
API_URL="18.130.121.101"

# Test GET request to /

response=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL/")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
    echo "GET request to / was successful" >> score.txt
else
    echo "GET request to / failed" >> score.txt
    exit 1
fi

# Test GET request to /animals

response=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL/animals")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
    echo "GET request to /animals was successful" >> score.txt
else
    echo "GET request to /animals failed" >> score.txt
    exit 1
fi

# Test POST request to /animals

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d '{"name":"Lion","type":"Mammal"}' "$API_URL/animals")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
    echo "POST request to /animals was successful" >> score.txt
else
    echo "POST request to /animals failed" >> score.txt
    exit 1
fi

animal_id=$(curl -s $API_URL/id_for_testing)

# Test PUT request to /animals/<animal_id>

response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT -H "Content-Type: application/json" -d '{"name":"tiger"}' "$API_URL/animals/$animal_id")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
  echo "PUT Request to /animals/$animal_id was successful." >> score.txt
else
  echo "PUT Request to /animals/$animal_id failed." >> score.txt
fi

# Test DELETE request to /animals/<animal_id>

response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$API_URL/animals/$animal_id")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
  echo "DELETE Request to /animals/$animal_id was successful." >> score.txt
else
  echo "DELETE Request to /animals/$animal_id failed." >> score.txt

fi