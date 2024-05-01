#!/bin/bash

while read line
do
	if [[ -z "$line" || "$line" == "#"* ]]
	then
		continue
	fi

	ORIG=$(echo $line | cut -d ';' -f1)
	DEST=$(echo $line | cut -d ';' -f2)
	NAME=${ORIG##*/}

	echo "Mirroring $NAME"

	if [ -d "$NAME" ]
	then
		cd $NAME
		git remote update
	else
		git clone --mirror $ORIG
		cd $NAME
	fi

	git push --mirror $DEST
	cd ..

	echo "Done."
done <./repo-list
