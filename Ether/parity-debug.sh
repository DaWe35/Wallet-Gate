balance=$(curl -s --data '{"method":"eth_getBalance","params":["0x9de7e5d5066b2b06beebbf9e379e9d0a6a232041"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545)
balance=$(echo "$balance" | jq '.result')
echo -n "Balance: "
echo "${balance//\"}"

nexnon=$(curl -s --data '{"method":"parity_nextNonce","params":["0x9de7e5d5066b2b06beebbf9e379e9d0a6a232041"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545)
nexnon=$(echo "$nexnon" | jq '.result')
echo -n "parity_nextNonce: "
echo "${nexnon//\"}"

hash=$(curl -s --data '{"method":"personal_sendTransaction","params": [{ "from": "0x9de7e5d5066b2b06beebbf9e379e9d0a6a232041", "to": "0x34A6E41B8B23853a4A44e0e9D49D13BE6FFb33Cf", "gas": "0xBB80", "value": "0x16345785D8A0000"}, "pass"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545)
hash=$(echo "$hash" | jq '.result')
hash=$(echo "${hash//\"}")
echo -n "TX hash: "
echo $hash
txdata=$(curl -s --data '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["'"$hash"'"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8545)
echo -n "Used nonce: "
nonce=$(echo $txdata | jq '.result.nonce')
echo "${nonce//\"}"