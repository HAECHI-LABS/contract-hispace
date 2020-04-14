#!/bin/bash

source ./env.sh

BOX_ID1=$1
BOX_ID2=$2

$NODE_PATH token/index.js approve $USER1 $SAVEBOX
$NODE_PATH token/index.js approve $USER2 $SAVEBOX
$NODE_PATH token/index.js approve $USER3 $SAVEBOX

echo "###################################################"
echo "Stake to Box1: $BOX_ID1"
echo "###################################################"
$NODE_PATH savebox/index.js stakeTo $USER1 1 $BOX_ID1
$NODE_PATH savebox/index.js stakeTo $USER2 2 $BOX_ID1
$NODE_PATH savebox/index.js stakeTo $USER3 3 $BOX_ID1

echo "###################################################"
echo "Stake to Box2: $BOX_ID2"
echo "###################################################"
$NODE_PATH savebox/index.js stakeTo $USER1 1 $BOX_ID2
$NODE_PATH savebox/index.js stakeTo $USER2 2 $BOX_ID2


