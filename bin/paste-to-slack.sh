#!/bin/bash

#Slack user token (JF)
TOKEN="$(cat ~/.slack)"

#The Slack channel name
CHANNEL="@adagios"

#The Slack message user
USER="bot"

#Wrap the message in ```
WRAP="true"

#An URL for the Slack message user image
#ICON="http://www.itjobs.pt/empresa/reditus-business-solutions/logo/facebook";

while getopts "c:u:w" optname
do
    case "$optname" in
        "c")
            CHANNEL="$OPTARG"
            ;;
        "u")
            USER="$OPTARG"
            ;;
        "w")
            WRAP="false"
            ;;
        "?")
            echo "Unknown option $OPTARG"
            ;;
        ":")
            echo "No argument value for option $OPTARG"
            ;;
        *)
            # Should not occur
            echo "Unknown error while processing options"
            ;;
    esac
done


########################################
# Build the message
########################################
errors=''
if [[ $WRAP == "true" ]]; then
   errors+=$'```\n'
fi
while read -r line; do
    errors+=$line
    errors+=$'\n'
done
[[ $WRAP == "true" ]] && errors+='```'

echo "$errors"

########################################
## SEND THE MESSAGE TO SLACK
## The -G option makes the -d and --data-urlencode options be added as query parameters instead of form parameters
########################################
result=$(curl -s -G "https://slack.com/api/chat.postMessage"\
    -d "token=$TOKEN"\
    -d "username=$USER"\
    -d "mrkdwn=true"\
    --data-urlencode "channel=$CHANNEL"\
    --data-urlencode "text=$errors")


if [[ $result == *"\"ok\":false"* || $result == *"Request-URI Too Large"* || $result == *"Bad request"* ]]; then
    echo "$result"

    curl -s -G "https://slack.com/api/chat.postMessage"\
        -d "token=$TOKEN"\
        -d "username=$USER"\
        -d "mrkdwn=true"\
        --data-urlencode "channel=$CHANNEL"\
        --data-urlencode "text=<!channel>:Failed to paste message, normally this means it was *too big** :rat: :rat: :rat:"
fi

# vim: filetype=sh sw=4 ts=4 et
