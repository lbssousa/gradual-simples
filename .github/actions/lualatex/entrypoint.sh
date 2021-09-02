#!/bin/bash

set -e

workDir=$(pwd)

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

cd ${dirName}

rerunNeeded=1

for (( i = 0; i < 5 && rerunNeeded; i++ ))
do
    echo ">>> [Iteration #$(( i + 1 ))] Building PDF document for file ${dirName}/${fileName}..."
    lualatex -synctex=1 -interaction=nonstopmode -file-line-error ${fileName}

    if [[ $(grep -c "Rerun to" ${fileName}.log) > 0 ]]
    then
        echo ">>> Some hashes have changed. Rerun needed."
    else
        rerunNeeded=0
    fi
done

cd ${workDir}

echo ">>> Copying file ${dirName}/${fileName}.pdf to ${OUT_DIR}"
cp ${dirName}/${fileName}.pdf ${OUT_DIR}/${dirName}-${fileName}.pdf