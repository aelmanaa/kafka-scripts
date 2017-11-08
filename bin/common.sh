#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=$DIR/../config

function err {
  echo "$1" >&2
}

function fail {
  err "$1" && exit 1;
}

function get_config_name {
  while getopts ":c:" opt; do
    case $opt in
      c)
        echo $OPTARG;
        ;;
      :)
        fail "Missing argument for -$OPTARG";
        ;;
    esac
  done
}

function load_config {
  CONFIG_NAME=$1
  DEFAULT_CONFIG_NAME=$(cat $CONFIG_DIR/default_config_name.txt)

  if [[ -z $CONFIG_NAME ]]; then
	  CONFIG_NAME=$DEFAULT_CONFIG_NAME
  fi
  if [[ ! -f $CONFIG_DIR/$CONFIG_NAME ]]; then
    fail "Cound not find config [$CONFIG_DIR/$CONFIG_NAME]."
  fi

  source $CONFIG_DIR/$CONFIG_NAME
}

function print_common_usage {
  echo "	-c		Name of config to be used"
}
