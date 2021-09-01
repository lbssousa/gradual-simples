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

        if [[ ${?} != 0 ]]
        then
            echo ">>> LuaLaTeX build failed!"
            exit 1
        fi

        if [ -f "${fileName}.log" ]
        then
            if grep -q "Rerun to" ${fileName}.log
            then
                echo ">>> Some hashes have changed. Rerun needed."
            else
                rerunNeeded=false
            fi
        else
            echo ">>> ${fileName}.log not found! Something went wrong!"
            exit 1
        fi
    done
)

echo ">>> Copying file ${dirName}/${fileName}.pdf to ${OUT_DIR}"
cp ${dirName}/${fileName}.pdf ${OUT_DIR}/${dirName}-${fileName}.pdf
