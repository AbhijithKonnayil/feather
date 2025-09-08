#!/bin/bash

cd packages/feather_ui
dart run build_runner build --delete-conflicting-outputs

echo "Copying generated files..."
cp lib/.generated/list.g.json ../feather_cli/lib/list.json