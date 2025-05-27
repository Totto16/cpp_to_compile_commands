#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

uv run datamodel-codegen --input "$SCRIPT_DIR/c_cpp_properties.schema.json" --input-file-type jsonschema --output "$SCRIPT_DIR/schema.py"
