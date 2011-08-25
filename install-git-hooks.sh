#!/bin/sh
GIT_PRE_COMMIT=".git/hooks/pre-commit"
RUNNING_FROM=`dirname $0`
echo "!/bin/sh" > $GIT_PRE_COMMIT
echo "/bin/sh $RUNNING_FROM/upload-git.sh" > $GIT_PRE_COMMIT
chmod a+x $GIT_PRE_COMMIT
