#!/bin/bash
API_BASE_URL="18.130.189.49"
touch score.txt

# check if the API is up
api_status=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE_URL/)
if [[ $api_status != "200" ]]; then
  echo "API is not running. Exit."
  exit 1
fi

response=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE_URL/)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "GET Request to / was successful." >> score.txt
else
  echo "GET Request to / failed." >> score.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "quote=quoteForTesting" $API_BASE_URL/animals)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "POST Request to /animals was successful." >> score.txt
else
  echo "POST Request to /animals failed." >> score.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT -H "Content-Type: application/x-www-form-urlencoded" -d "quote=quoteForTesting" $API_BASE_URL/animals/<animal_id>)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "PUT Request to /animals was successful." >> score.txt
else
  echo "PUT Request to /animals failed." >> score.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE $API_BASE_URL/animals/<animal_id>)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "DELETE Request to /animals was successful." >> score.txt
else
  echo "DELETE Request to /animals failed." >> score.txt
fi

for item in "${RESPONSES[@]}"; do
  if [[ $item == "200" ]]; then
    continue
  else
    echo "Test Failed"
    exit 1
  fi
done