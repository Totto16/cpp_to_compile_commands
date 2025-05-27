#!/usr/bin/env bash

set -ex

generate_file() {

    uv run datamodel-codegen --input "$1" --input-file-type jsonschema --output "$2" --use-annotated --output-model-type=pydantic_v2.BaseModel --formatters "ruff-format" --target-python-version "3.13" --use-schema-description --use-subclass-enum

}

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

generate_file "$SCRIPT_DIR/c_cpp_properties.schema.json" "$SCRIPT_DIR/c_cpp_properties.py"
generate_file "$SCRIPT_DIR/compilation_database.schema.json" "$SCRIPT_DIR/compilation_database.py"
