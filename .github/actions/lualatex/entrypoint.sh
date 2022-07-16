#!/bin/bash

set -e

base_name=${1}
layout_suffix=${2}
file_name=${base_name}-${layout_suffix}

echo ">>> Creating output directory ${OUT_DIR}..."
mkdir --parent ${OUT_DIR}

echo ">>> Building PDF document for file ${file_name}..."
latexmk --lualatex --synctex=1 --interaction=nonstopmode --file-line-error --halt-on-error ${file_name}

echo ">>> Copying ${file_name} output files to ${OUT_DIR}"
cp ${file_name}.* ${OUT_DIR}