# ZJSON <sub><sup>-  <sub><sup>ZScript JSON Parser (with trailing comma and single/multi-line comment support)</sup></sub></sup></sub>

This is a JSON parsing library for [ZScript](https://zdoom.org/wiki/ZScript).

Includes a [usage example](.example/zjson-example.pk3) and a [small test suite](.example/zjson-test.pk3).

It supports, in addition to strict JSON: trailing commas, single-quote strings, and single/multi-line comments (C/C++-style).

To use in your mod, just generate the prefixes, copy over the `generated/ZJSON` folder, and add `#include "ZJSON/Include.zs"` to your main ZScript file.

## Generating Prefixes:
Run `generate.sh [your prefix]` on linux/wsl/msys/cygwin. The prefixed files will be in the `generated` folder.

## Types:
* JsonElement -  One of `JsonObject`, `JsonArray`, `JsonString`, `JsonNumber`, `JsonInt`, `JsonDouble`, `JsonBool`, `JsonNull`
* JsonObject - Represents JSON Objects as a Hash Table
* JsonArray - Just a wrapper over regular ZScript Dynamic Arrays
* JsonString/JsonNumber/JsonInt/JsonDouble/JsonBool/JsonNull - Simple Types
* JsonError - NOT a Json Element, means that the parsing process failed, error message is in `JsonError.what`, it contains line number and some extra information.


## How to Use:

Call `JSON.parse` with a string that contains JSON text, it will return either a `JsonElement` in case of success, or a `JsonError` in case of failure.
