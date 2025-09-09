#!/bin/bash

cd packages/feather_ui
dart run build_runner build --delete-conflicting-outputs

echo "Copying generated files..."
#feather_registry
mkdir -p ../feather_registry/lib/_generated
cp lib/.generated/list.g.json ../feather_registry/lib/_generated/widget_list.json
#catalog_website
mkdir -p ../catalog_website/lib/_generated
cp lib/.generated/list.g.dart ../catalog_website/lib/_generated/widget_list.g.dart