#!/usr/bin/env python3

import json
import os


def read_file(file: str) -> list[str]:
    with open(file) as f:
        return f.readlines()


def resolve_arg(arg: str) -> list[str]:
    if arg.startswith("@"):
        return read_file(arg.removeprefix("@"))
    else:
        return [arg]


def main() -> None:
    with open(".vscode/c_cpp_properties.json") as f:
        data = json.load(f)

    config = data["configurations"][0]
    include_paths = config["includePath"]
    defines = config.get("defines", [])
    compiler_path = config.get("compilerPath", "g++")
    cppStandard = config.get("cppStandard", None)
    compilerArgs = config.get("compilerArgs", [])

    additional_args: list[str] = []

    for arg in compilerArgs:
        additional_args.extend(resolve_arg(arg))

    if cppStandard is not None:
        additional_args.append(f"--std={cppStandard}")

    commands: list[dict[str, str]] = []

    for root, _dirs, files in os.walk("src"):
        for file in files:
            if file.endswith(".cpp"):
                filepath = os.path.join(root, file)
                command = {
                    "directory": os.getcwd(),
                    "command": f"{compiler_path} -c {filepath} "
                    + " ".join(additional_args)
                    + " "
                    + " ".join(f"-I{inc}" for inc in include_paths)
                    + " "
                    + " ".join(f"-D{define}" for define in defines),
                    "file": filepath,
                }
                commands.append(command)

    with open("compile_commands.json", "w") as f:
        json.dump(commands, f, indent=2)


if __name__ == "__main__":
    main()
