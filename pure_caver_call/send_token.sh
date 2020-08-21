#!/bin/bash

NODE_PATH=$(which node)

TOKEN_CREATOR='0x5399850AB7BFE194FA1594F8051329CcC8aCfd56'
USER1=$1
USER2=$2
USER3=$3

$NODE_PATH token/index.js approve $TOKEN_CREATOR $USER1
$NODE_PATH token/index.js transfer $USER1

$NODE_PATH token/index.js approve $TOKEN_CREATOR $USER2
$NODE_PATH token/index.js transfer $USER2

$NODE_PATH token/index.js approve $TOKEN_CREATOR $USER3
$NODE_PATH token/index.js transfer $USER3
