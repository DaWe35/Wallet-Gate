#!/bin/bash
if [ -f .blocknotif_running ]; then #IF .blocknotif_running found, 
    exit 0
fi
touch .blocknotif_running
source conf.sh
echo "Get blockcount, balance"
BLOCKCOUNT="$($COMMAND getblockcount)"
BALANCE="$($COMMAND getbalance)"
echo "Running CURL"
jsoncurl=$(curl -s --data "coin=$COINID&sreughralg=$sreughralg&blockcount=$BLOCKCOUNT&balance=$BALANCE" $DOMAIN/needconfirm)
if jq -e .[] >/dev/null 2>&1 <<<"$jsoncurl"; then
  counter=0
  for row in $(echo "${jsoncurl}" | jq -r '.[] | @base64');
    do
      _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
      }
      JSONW="$(_jq '.txid')"
      echo "Updating $JSONW";
      TRANSACTIONDATAPR="$($COMMAND gettransaction $JSONW)"
      TRANSACTIONDATA="$(jq 'del(.vin, .vout)' <<< $TRANSACTIONDATAPR)"
      curl -s --data "coin=$COINID&sreughralg=$sreughralg&txdata=$TRANSACTIONDATA" $DOMAIN/confirmupdate
      (( counter++ ))
    done
  printf "\n--> $counter confirm record updated <---\n"
else
  echo "Curl recived: $jsoncurl"
fi
rm -f .blocknotif_running
