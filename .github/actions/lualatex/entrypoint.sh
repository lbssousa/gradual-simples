#!/bin/bash

set -e

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

for (( i = 0; i < 5 && rerunNeeded; i++ ))
do
    echo ">>> [Run #$(( i + 1 ))] Building PDF document for file ${dirName}/${fileName}..."
    lualatex \
        --synctex=1 \
        --interaction=nonstopmode \
        --file-line-error \
        --halt-on-first-error \
        ${dirName}/${fileName}

    if [[ $(grep -c "Rerun to" ${fileName}.log) > 0 ]]
    then
        if (( i = 4 ))
        then
            echo ">>> Rerun limit reached, but there may still be changed hashes."
        else
            echo ">>> Some hashes have changed. Rerun triggered."
        fi
    else
        rerunNeeded=0
    fi
done

echo ">>> Copying file ${fileName}.pdf to ${OUT_DIR}"
cp ${fileName}.pdf ${OUT_DIR}/${dirName}-${fileName}.pdf
