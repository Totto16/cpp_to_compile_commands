#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

uv run datamodel-codegen --input "$SCRIPT_DIR/c_cpp_properties.schema.json" --input-file-type jsonschema --output "$SCRIPT_DIR/c_cpp_properties.schema.py" --use-annotated --output-model-type=pydantic_v2.BaseModel

uv run datamodel-codegen --input "$SCRIPT_DIR/compilation_database.schema.json" --input-file-type jsonschema --output "$SCRIPT_DIR/compilation_database.schema.py" --use-annotated --output-model-type=pydantic_v2.BaseModel
