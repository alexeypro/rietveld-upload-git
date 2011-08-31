#!/bin/sh

###
### This block you should update with your settings
###
GIT_ACCOUNT_NAME="qwe3"
USERNAME_TO_USE="-e me@alexeypro.com"					# leave empty if want to get prompt instead
REVIEWERS_EMAILS="me@alexeypro.com,alexey@prohorenko.com"		# emails of reviewers
SERVER="codereview.alexeypro.com"					# server to upload to
RUNNING_FROM=`dirname $0`						# path where the script is
UPLOAD_PY="$RUNNING_FROM/upload-082511.py"				# path to upload.py
SERVER_TYPE="HOSTED"							# can be HOSTED or GOOGLE

###
### You should not update down below unless you want to break stuff
### For full list of options refer to: http://code.google.com/p/rietveld/wiki/UploadPyUsage
###
MESSAGE_ISSUE=`cat .git/COMMIT_EDITMSG`
PYTHON_BIN=`which python`
GIT_BIN=`which git`
GIT_PROJECT=`git config --get remote.origin.url | cut -f 2 -d ":" | cut -f 1 -d "/"`
GIT_BRANCH=`$GIT_BIN name-rev --name-only HEAD`
#GIT_BRANCH=`$GIT_BIN branch --no-color 2> /dev/null | sed -e '/^[^*]/d' | cut -f 2 -d' '`
#GIT_PROJECT=`cat .git/FETCH_HEAD | cut -f 2 -d"/"`
BASE_URL="https://github.com/$GIT_ACCOUNT_NAME/$GIT_PROJECT/tree/$GIT_BRANCH"
$PYTHON_BIN $UPLOAD_PY --rev=$GIT_BRANCH -s $SERVER $USERNAME_TO_USE --account_type=$SERVER_TYPE -r $REVIEWERS_EMAILS --send_mail --base_url=$BASE_URL --assume_yes -m "$MESSAGE_ISSUE"
