#!/bin/bash

person=$1

function getPerson() {
curl -s -X GET "https://swapi.dev/api/people/$person/" -H "Content-Type:application/json" | jq '.' 
}

getPerson $person
