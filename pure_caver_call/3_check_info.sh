#!/bin/bash

source ./env.sh

BOX_ID1=$1
BOX_ID2=$1

echo "Finding member staking amount..."
echo $USER1
$NODE_PATH savebox/index.js stakeAmount $USER1
echo $USER2
$NODE_PATH savebox/index.js stakeAmount $USER2
echo $USER3
$NODE_PATH savebox/index.js stakeAmount $USER3

echo "Finding member's space staking amount..."
echo "###################################################"
echo "Space: $BOX_ID1"
echo "###################################################"
echo $USER1
$NODE_PATH savebox/index.js stakeAmount $USER1 $BOX_ID1
echo $USER2
$NODE_PATH savebox/index.js stakeAmount $USER2 $BOX_ID1
echo $USER3
$NODE_PATH savebox/index.js stakeAmount $USER3 $BOX_ID1

echo "Finding member's space staking amount..."
echo "###################################################"
echo "Space: $BOX_ID2"
echo "###################################################"
echo $USER1
$NODE_PATH savebox/index.js stakeAmount $USER1 $BOX_ID2
echo $USER2
$NODE_PATH savebox/index.js stakeAmount $USER2 $BOX_ID2
echo $USER3
$NODE_PATH savebox/index.js stakeAmount $USER3 $BOX_ID2
