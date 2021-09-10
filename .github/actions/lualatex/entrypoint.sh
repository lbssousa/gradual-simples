#!/bin/bash

set -e

rerunLimit=5

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

rerunNeeded=1

for (( i = 0; i < rerunLimit && rerunNeeded; i++ ))
do
    echo ">>> [Run #$(( i + 1 ))] Building PDF document for file ${dirName}/${fileName}..."
    lualatex \
        --synctex=1 \
        --interaction=nonstopmode \
        --file-line-error \
        --halt-on-error \
        ${dirName}/${fileName}

    if [[ $(grep -c "Rerun to" ${fileName}.log) > 0 ]]
    then
        if (( i < rerunLimit - 1 ))
        then
            echo ">>> Some hashes have changed. Rerun triggered."
        else
            echo ">>> Rerun limit reached, but there may still be changed hashes."
        fi
    else
        rerunNeeded=0
    fi
done

echo ">>> Copying ${fileName} output files to ${OUT_DIR}"
cp ${fileName}.* ${OUT_DIR}