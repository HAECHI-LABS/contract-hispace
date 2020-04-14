#!/bin/bash

source ./env.sh

$NODE_PATH token/index.js approve $USER1 $USER2
$NODE_PATH token/index.js transfer $USER2

$NODE_PATH token/index.js approve $USER1 $USER3
$NODE_PATH token/index.js transfer $USER3

$NODE_PATH token/index.js approve $USER1 $SAVEBOX
$NODE_PATH savebox/index.js stake $USER1 1

$NODE_PATH token/index.js approve $USER2 $SAVEBOX
$NODE_PATH savebox/index.js stake $USER2 2

$NODE_PATH token/index.js approve $USER3 $SAVEBOX
$NODE_PATH savebox/index.js stake $USER3 3

echo "###################################################"
echo "Create Box1"
echo "###################################################"
$NODE_PATH savebox/index.js createBox $USER1

echo "###################################################"
echo "Create Box2"
echo "###################################################"
$NODE_PATH savebox/index.js createBox $USER2

