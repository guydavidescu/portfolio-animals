#!/bin/bash

# Set the base URL of the API
API_URL="18.132.41.185"

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

# Test POST request to /animals/<animal_id>/update

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d '{"animal_id":"'$animal_id'", "name":"tiger", "type":"mammal"}' "$API_URL/animals/$animal_id/update")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
  echo "POST Request to /animals/$animal_id/update was successful." >> score.txt
else
  echo "POST Request to /animals/$animal_id/update failed." >> score.txt
fi

# Test POST request to /animals/<animal_id>/delete

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -d "animal_id=$animal_id" "$API_URL/animals/$animal_id/delete")
RESPONSES+=("$response")
if [[ $response == "200" ]]; then
echo "POST Request to /animals/$animal_id/delete was successful." >> score.txt
else
echo "POST Request to /animals/$animal_id/delete failed." >> score.txt
fi