#!/bin/bash

echo ">>> Creating output directory ${OUT_DIR}..."
mkdir --parent ${OUT_DIR}

#for fileName in *.tex *.cls
#do
#    [ -f "${fileName}" ] || break

#    echo "Substituting version number ${GITHUB_SHA::7} in file ${fileName}..."
#    sed -i -e "s/verSubstitution/${GITHUB_SHA::7}/" ${fileName}
#done

dirName=${1}
fileName=${2}

(
    cd ${dirName}
    rerunNeeded=true
    iteration=0

    while ${rerunNeeded}
    do
	(( iteration++ ))
        echo ">>> [Iteration #${iteration}] Building PDF document for file ${dirName}/${fileName}..."
        lualatex -synctex=1 -interaction=nonstopmode -file-line-error ${fileName}

        if grep -q Rerun ${fileName}.log
        then
            echo ">>> Some hashes have changed. Rerun needed."
        else
            rerunNeeded=false
        fi
    done
)

echo ">>> Copying file ${dirName}/${fileName}.pdf to ${OUT_DIR}"
cp ${dirName}/${fileName}.pdf ${OUT_DIR}/${dirName}-${fileName}.pdf
