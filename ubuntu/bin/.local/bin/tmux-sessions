#!/bin/bash
if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    exit
fi

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Should be called with a filename of a config"
    exit
fi
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORKING_DIR=$PWD
FILE_NAME=$1
FILE_PATH=$WORKING_DIR"/"$FILE_NAME
SESSION_NAME=`jq -r ".name" $FILE_PATH`
DIR_PATH=`jq -r ".path" $FILE_PATH`

pushd "$HOME$DIR_PATH"
COUNT=0
while read -r window; do
  WINDOW_NAME=$(echo $window | jq -r '.name')
  COMMAND_STR=$(echo $window | jq -r '.command')
  echo Creating window $WINDOW_NAME
  if [ "$COUNT" -eq "0" ]
  then
    tmux new-session -s $SESSION_NAME -d -n $WINDOW_NAME
    tmux send-keys -t $SESSION_NAME:$WINDOW_NAME "$COMMAND_STR" Enter
    COUNT=$((COUNT+1))
  else
    tmux new-window -t $SESSION_NAME -d -n $WINDOW_NAME
    tmux send-keys -t $SESSION_NAME:$WINDOW_NAME "$COMMAND_STR" Enter
  fi
done <<< "$(cat $FILE_PATH | jq -c '.windows[]')"

tmux -u attach -t $SESSION_NAME

popd
