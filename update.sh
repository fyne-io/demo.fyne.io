#!/bin/sh

# Usage:
# Pass the demo version in as argument to regenerate with that version.
# Example: ./update.sh v1.6.0

# Exit on error:
set -e

# File path variables:
URL="https://github.com/fyne-io/demo/archive/refs/tags/$1.tar.gz"
TEMP_DIR=$(mktemp -d)
OUT_FILE="$TEMP_DIR/$1.tar.gz"

# Download, extract, package and copy here before cleanup:
wget -O $OUT_FILE $URL
echo $OUT_FILE
tar -xzf $OUT_FILE -C $TEMP_DIR --strip-components=1
(cd $TEMP_DIR && ~/go/bin/fyne package -release -os=wasm)
cp -rvf $TEMP_DIR/wasm/* .
rm -rf $TEMP_DIR
