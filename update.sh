#!/bin/sh

# Usage:
# Pass the Fyne version in as argument to regenerate with that version.
# Example: ./update.sh v2.5.3

# Exit on error:
set -e

# File path variables:
URL="https://github.com/fyne-io/fyne/archive/refs/tags/$1.tar.gz"
TEMP_DIR=$(mktemp -d)
OUT_FILE="$TEMP_DIR/$1.tar.gz"
DEMO_PATH="$TEMP_DIR/cmd/fyne_demo"

# Download, extract, package and copy here before cleanup:
wget -O $OUT_FILE $URL
echo $OUT_FILE
tar -xzf $OUT_FILE -C $TEMP_DIR --strip-components=1
(cd $DEMO_PATH && ~/go/bin/fyne package --release --os=wasm)
cp -rvf $DEMO_PATH/wasm/* .
rm -rf $TEMP_DIR
