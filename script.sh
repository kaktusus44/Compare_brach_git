#!/bin/bash
while read line; do 
git clone ssh://git@stash.****.ru:7999/rtd/$line.git >/dev/null 2>&1
if [ $? -eq 128 ]
then
echo "=================================================================" $'\n'$line $'\n'"Do Fetch."
cd $line
git fetch ssh://git@stash.****.ru:7999/rtd/$line.git >/dev/null 2>&1
git log origin/master..develop | grep -o RTD-'[0-9][0-9][0-9][0-9][0-9]' | awk '{ for (i=1;i<=NF;i++ ) printf $i ", " }' | rev | cut -c 3- | rev
git describe origin/develop --tags
cd ..
else
echo "=================================================================" $'\n'$line
cd $line 
git log origin/master..develop | grep -o RTD-'[0-9][0-9][0-9][0-9][0-9]' | awk '{ for (i=1;i<=NF;i++ ) printf $i ", " }' | rev | cut -c 3- | rev
git describe origin/develop --tags 
cd .. 
fi
done < config.txt

