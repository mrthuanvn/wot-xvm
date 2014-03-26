#!/bin/bash

rm -rf ../../release/l10n/*
mkdir -p ../../release/l10n/
cp -r ../../temp/* ../../release/l10n/

files=$(find ../../release/l10n/ -type f -name *.po -o -name *.pot)

for file in $files
do
        if [[ "$file" == *".po" ]];
        then
                po2csv --progress=none --columnorder=location,target $file $file.xc
        else
                cp $file $file.po
                po2csv --progress=none --columnorder=location,source $file.po $file.xc
                rm $file.po
        fi

        #del first line
        sed -i '1d' $file.xc

        #change field delimiter        
        sed -i 's|","|": "|g' $file.xc

        #add trailing ,
        sed -i 's/.$/,/' $file.xc
        sed -i '$s/,$//' $file.xc
        
        # unescape \n
        sed -i 's/\\\\/\\/g' $file.xc   

        #add file header
        ed -s $file.xc << 'EOF'
0a
{
  "locale": {
.
$a
  }
}
.
w
EOF

        filepath=$(dirname $file)
        filename=$(basename $filepath)
        mv $file.xc ../../release/l10n/"$filename".xc
        rm $file
        rm -rf $filepath
done
