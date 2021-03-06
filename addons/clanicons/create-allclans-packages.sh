#!/bin/sh
#Using 7-Zip (A) 9.20 for Windows command line
#Compessing type=deflate, method=w/o compression, multi-threading=on,
#store creation time=off, compress files open for writing=on, recursive

echo "Creating packages of icons..."

mkdir -p archives
cd archives

datenow=`date +%Y%m%d`

#echo "Creating VN package"
#7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-vn-$datenow.zip  ../icons/VTC/res_mods/ readme.txt
echo "Creating KR package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-kr-$datenow.zip  ../icons/KR/res_mods/ readme.txt
echo "Creating SG package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-sg-$datenow.zip ../icons/SG/res_mods/ readme.txt
echo "Creating NA package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-na-$datenow.zip  ../icons/NA/res_mods/ readme.txt
echo "Creating EU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-eu-$datenow.zip  ../icons/EU/res_mods/ readme.txt
echo "Creating RU package"
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru-$datenow-part1.zip  @part1.txt readme.txt
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru-$datenow-part2.zip  @part2.txt readme.txt
7za a -tzip -mm=deflate -mx0 -mmt=on -mtc=off -ssw -r clanicons-full-ru-$datenow-part3.zip  @part3.txt readme.txt

cd ..
echo "Packages are created"
