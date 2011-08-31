#!/bin/sh

###
### This block you should update with your settings
###
SERVER="cr.alexeypro.com"						# server to upload to
SERVER_TYPE="HOSTED"							# can be HOSTED or GOOGLE
RUNNING_FROM=`dirname $0`						# path where the script is
UPLOAD_PY="$RUNNING_FROM/upload-082511.py"				# path to upload.py
USERNAME_EMAIL_FROM_FILE=`cat $RUNNING_FROM/username.txt`
REVIEWERS_EMAILS_FROM_FILE=`cat $RUNNING_FROM/reviewers.txt`
USERNAME_TO_USE=${USERNAME_EMAIL_FROM_FILE:="nobody@alexeypro.com"}
REVIEWERS_EMAILS=${REVIEWERS_EMAILS_FROM_FILE:="coders@alexeypro.com"}

###
### You should not update down below unless you want to break stuff
### For full list of options refer to: http://code.google.com/p/rietveld/wiki/UploadPyUsage
###
DESCR=`cat .git/COMMIT_EDITMSG | head -n1 | cut -c1-50`
echo $DESCR
PYTHON_BIN=`which python`
GIT_BIN=`which git`
GIT_COMPANY=`git config --get remote.origin.url | cut -f 2 -d ":" | cut -f 1 -d "/"`
GIT_PROJECT=`git config --get remote.origin.url | cut -f 2 -d ":" | cut -f 2 -d "/" | cut -f 1 -d "."`
GIT_BRANCH=`$GIT_BIN name-rev --name-only HEAD`
BASE_URL="https://github.com/$GIT_COMPANY/$GIT_PROJECT/tree/$GIT_BRANCH"
$PYTHON_BIN $UPLOAD_PY --rev=$GIT_BRANCH -s $SERVER -e $USERNAME_TO_USE --account_type=$SERVER_TYPE -r $REVIEWERS_EMAILS --send_mail --base_url=$BASE_URL --assume_yes -m "${DESCR:="New code review request"}"
exit 0

