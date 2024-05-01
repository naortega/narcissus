#!/bin/bash

while read line
do
	ORIG=$(echo $line | cut -d ';' -f1)
	DEST=$(echo $line | cut -d ';' -f2)
	NAME=${ORIG##*/}

	echo "Mirroring $NAME"

	if [ -d "$NAME" ]
	then
		rm -r $NAME
	fi

	git clone --mirror $ORIG
	cd $NAME
	git push --mirror $DEST
	cd ..
	rm -r $NAME

	echo "Done."
done <./repo-list
