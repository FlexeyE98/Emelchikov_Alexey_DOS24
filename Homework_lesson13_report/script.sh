#!/bin/bash

person=$1

function getPerson() {
curl -s -X GET "https://swapi.dev/api/people/?search=$person/" -H "Content-Type:application/json" | jq '.' 
}

getPerson $person


///Ищем персонажа + фильмы + планеты где обитает и тд
