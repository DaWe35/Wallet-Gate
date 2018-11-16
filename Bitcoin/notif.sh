#!/bin/bash
source conf.sh
BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
if ! [ -z "$BLOCKCOUNT" ]; then
    BALANCE="$($COMMAND getbalance)"
    TRANSACTIONDATAPR="$($COMMAND gettransaction $1)"
    TRANSACTIONDATA="$(jq 'del(.vin, .vout)' <<< $TRANSACTIONDATAPR)"
    curl -s --data "coin=$COINID&sreughralg=$sreughralg&blockcount=$BLOCKCOUNT&balance=$BALANCE&txdata=$TRANSACTIONDATA" $DOMAIN/notif
  else
    touch tx.txt
    chmod 744 tx.txt
    echo "$1" >> tx.txt
  fi
