#!/bin/bash

echo "Validating if we have a correct OpenAPI"
inso lint spec petstore-with-keyauth.yaml

echo "Executing all tests"
echo "NOTE: you must have an .insomnia folder with the relevant tests in the same directory where this repo is run"
inso run test "Sample Specification" --env "OpenAPI env"

echo "Generating Kong decK YAML from OpenAPI"
inso generate config ./petstore-with-keyauth.yaml -o petstore-deck-import.yaml

echo "Importing the generated YAML into Kong"
deck sync -s petstore-deck-import.yaml --select-tag  OAS3file_petstore-with-keyauth.yaml
