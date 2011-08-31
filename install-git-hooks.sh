#!/bin/sh
GIT_PRE_COMMIT=".git/hooks/commit-msg"
RUNNING_FROM=`dirname $0`
echo "#!/bin/sh" 				> $GIT_PRE_COMMIT
echo "/bin/sh $RUNNING_FROM/upload-git.sh"	>> $GIT_PRE_COMMIT
echo "if [ $? -eq 0 ]; then"			>> $GIT_PRE_COMMIT
echo "	echo 'Submitted code review request!'"	>> $GIT_PRE_COMMIT
echo "else"					>> $GIT_PRE_COMMIT
echo "	echo 'Skipping code review request!'"	>> $GIT_PRE_COMMIT
echo "fi"					>> $GIT_PRE_COMMIT
chmod a+x $GIT_PRE_COMMIT
