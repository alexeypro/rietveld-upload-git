#!/bin/sh

###
### This block you should update with your settings
###
GIT_ACCOUNT_NAME="qwe3"
USERNAME_TO_USE="-e me@alexeypro.com"					# leave empty if want to get prompt instead
REVIEWERS_EMAILS="me@alexeypro.com,alexey@prohorenko.com"		# emails of reviewers
SERVER="codereview.scopely.com"						# server to upload to
UPLOAD_PY="~/code/personal/rietveld-upload-git/upload-082511.py"	# path to upload.py
SERVER_TYPE="HOSTED"							# can be HOSTED or GOOGLE

###
### You should not update down below unless you want to break stuff
### For full list of options refer to: http://code.google.com/p/rietveld/wiki/UploadPyUsage
###
PYTHON_BIN=`which python`
GIT_BIN=`which git`
GIT_BRANCH=`$GIT_BIN name-rev --name-only HEAD`
GIT_PROJECT=`cat .git/FETCH_HEAD | cut -f 2 -d"/"`
BASE_URL="https://github.com/$GIT_ACCOUNT_NAME/$GIT_PROJECT/tree/$GIT_BRANCH"
$PYTHON_BIN $UPLOAD_PY --rev=$GIT_BRANCH -s $SERVER $USERNAME_TO_USE --account_type=$SERVER_TYPE -r $REVIEWERS_EMAILS --send_mail --base_url=$BASE_URL
