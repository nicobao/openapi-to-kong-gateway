#!/bin/bash

echo "Validating if we have a correct OpenAPI"
inso lint spec catstore-with-keyauth.yaml

echo "Executing all tests"
echo "NOTE: you must have an .insomnia folder with the relevant tests in the same directory where this repo is run"
inso run test "Sample Specification" --env "OpenAPI env"

echo "Generating Kong decK YAML from OpenAPI"
inso generate config ./catstore-with-keyauth.yaml -o catstore-deck-import.yaml

echo "Importing the generated YAML into Kong"
deck sync -s catstore-deck-import.yaml --select-tag OAS3file_catstore-with-keyauth.yaml
