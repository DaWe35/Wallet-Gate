#!/bin/bash
echo "Starting..."
source conf.sh
rm -f .blocknotif_running
while true
  do
    #withdraw every 10 min
    echo "Get blockcount, balance"
    BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
    while [ -z "$BLOCKCOUNT" ]; do
	echo "Blockcount is empty, waiting for wallet"
	sleep 10;
	BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
    done
    BALANCE="$($COMMAND getbalance)"
    echo "Running CURL"
    jsoncurl=$(curl -s --data "coin=$COINID&sreughralg=$sreughralg&blockcount=$BLOCKCOUNT&balance=$BALANCE" $DOMAIN/withdraw)
if jq -e .[] >/dev/null 2>&1 <<<"$jsoncurl"; then
  counter=0
  for row in $(echo "${jsoncurl}" | jq -r '.[] | @base64');
    do
      _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
      }
      JSONAMOUNT="$(_jq '.amount')"
      JSONADDRESS="$(_jq '.address')"
      JSONID="$(_jq '.id')"
      echo "Sending $JSONAMOUNT coin to $JSONADDRESS (id: $JSONID)";
      TXID=$($COMMAND sendtoaddress $JSONADDRESS $JSONAMOUNT)
      UPTXDB=$(curl -s --data "coin=$COINID&sreughralg=$sreughralg&txid=$TXID&id=$JSONID" $DOMAIN/txid)
      echo "$UPTXDB"
      (( counter++ ))
    done

        echo "$counter transactions sent"
    else
        echo "Curl recived: $jsoncurl"
    fi        
    for i in {1..10}
      do
        #generate new addresses every minute
        echo "Get blockcount, balance"
        BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
    	while [ -z "$BLOCKCOUNT" ]; do
		echo "Blockcount is empty, waiting for wallet"
		sleep 10;
		BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
    	done
        BALANCE="$($COMMAND getbalance)"
        gencurl=$(curl -s --data "coin=$COINID&sreughralg=$sreughralg&blockcount=$BLOCKCOUNT&balance=$BALANCE" $DOMAIN/getnewaddress)
        if [ "$gencurl" == "0" ]; then
            echo "Address pool full, didn't generated new"
        elif [  "$gencurl" != "1" ]; then
            echo "Address generating error: $gencurl"
        fi
        while [ "$gencurl" == "1" ]
          do
	    echo "Get blockcount, balance, new address"
	    BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
	    while [ -z "$BLOCKCOUNT" ]; do
		echo "Blockcount is empty, waiting for wallet"
		sleep 10;
		BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
	    done
	    BALANCE="$($COMMAND getbalance)"
            NEWADDRESS="$($COMMAND getnewaddress)"
            gencurl=$(curl -s --data "coin=$COINID&sreughralg=$sreughralg&blockcount=$BLOCKCOUNT&balance=$BALANCE&newaddress=$NEWADDRESS" $DOMAIN/getnewaddress)
            if [ "$gencurl" == "0" ]; then
                echo "Address pool full, didn't generated new"
            elif [  "$gencurl" != "1" ]; then
                echo "Address generating error: $gencurl"
            fi
        done

	if [ -f tx.txt ]; then #IF tx.txt found, 
	    echo "Updating cached tx-es (tx.txt)"
	    cntr=0
	    contr=0
	    while read LINE; do
		contr=$((contr+1))
	    	if (( cntr > 10 )); then
		    BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
		    while [ -z "$BLOCKCOUNT" ]; do
			echo "Blockcount is empty, waiting for wallet"
			sleep 10;
			BLOCKCOUNT="$($COMMAND getblockcount 2> /dev/null)"
		    done
	    	    BALANCE="$($COMMAND getbalance)"
		    cntr=0 
		fi
		cntr=$((cntr+1))
		TRANSACTIONDATAPR="$($COMMAND gettransaction $LINE)"
		TRANSACTIONDATA="$(jq 'del(.vin, .vout)' <<< $TRANSACTIONDATAPR)"
    		curl -s --data "coin=$COINID&sreughralg=$sreughralg&blockcount=$BLOCKCOUNT&balance=$BALANCE&txdata=$TRANSACTIONDATA" $DOMAIN/notif
	    done < tx.txt
	    echo "$contr cached (tx.txt) record updated"
	    rm -f tx.txt
	fi
        sleep 60
    done
done
