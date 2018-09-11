#!/bin/bash

#Slack user token (JF)
TOKEN="$(cat ~/.slack)"

#The Slack channel name
CHANNEL="@adagios"

#The Slack message user
USER="bot"

#The type of content
MEDIA="post"

#The title
TITLE="Untitled"

#An URL for the Slack message user image
#ICON="http://www.itjobs.pt/empresa/reditus-business-solutions/logo/facebook";

while getopts "c:u:m:t:" optname
do
    case "$optname" in
        "c")
            CHANNEL="$OPTARG"
            ;;
        "u")
            USER="$OPTARG"
            ;;
        "m")
            MEDIA="$OPTARG"
            ;;
        "t")
            TITLE="$OPTARG"
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
content=''
while read line; do
    content+=$line
    content+=$'\n'
done

########################################
## SEND THE MESSAGE TO SLACK
## The -G option makes the -d and --data-urlencode options be added as query parameters instead of form parameters
########################################
result=$(curl -s "https://slack.com/api/files.upload"\
    -d "token=$TOKEN"\
    -d "username=$USER"\
    -d "mrkdwn=true"\
    -d "filetype=$MEDIA"\
    -d "title=$TITLE"\
    --data-urlencode "channels=$CHANNEL"\
    --data-urlencode "content=$content")


if [[ $result == *"\"ok\":false"* || $result == *"Request-URI Too Large"* || $result == *"Bad request"* ]]; then
    curl -s -G "https://slack.com/api/chat.postMessage"\
        -d "token=$TOKEN"\
        -d "username=$USER"\
        -d "mrkdwn=true"\
        --data-urlencode "channel=$CHANNEL"\
        --data-urlencode "text=<!channel>:Failed to create post :rat: :rat: :rat:"
fi



# vim: filetype=sh sw=4 ts=4 et
