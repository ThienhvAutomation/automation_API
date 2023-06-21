#!/bin/bash

MSG=$1
#payload for lark
PAYLOAD="{\"content\":{\"text\":\"$MSG\"},\"msg_type\":\"text\"}"

#HOOK
HOOK=https://open.larksuite.com/open-apis/bot/v2/hook/ca9883a2-4e88-4d00-b6eb-4fa1e8b015a0

#curl
curl -X POST -H "Content-Type: application/json" -d "$PAYLOAD" $HOOK