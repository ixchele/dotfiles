#!/bin/bash

for file in $(find . -type f \( -name "*.c" -o -name "*.h" \)); do
    echo "$file"
    nvim -n -es --headless "$file" \
        -u NONE \
        -c "source ~/.config/nvim/lua/config/stdheader.vim" \
        -c "silent! StdheaderRemoveIfExists" \
        -c "silent! Stdheader" \
        -c "wq"
done
