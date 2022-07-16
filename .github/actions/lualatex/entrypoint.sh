#!/bin/bash

set -e

dirName=${1}
fileName=${2}

echo ">>> Creating output directory ${OUT_DIR}..."
mkdir --parent ${OUT_DIR}

echo ">>> Building PDF document for file ${dirName}/${fileName}..."
latexmk --lualatex --synctex=1 --interaction=nonstopmode --file-line-error --halt-on-error ${dirName}/${fileName}

echo ">>> Copying ${fileName} output files to ${OUT_DIR}"
cp ${fileName}.* ${OUT_DIR}