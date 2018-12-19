function getblocknumber() {
    local  blocknumber=$(curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":83}' -H "Content-Type: application/json" localhost:8545)
    hexnumb="$(jq '.result' <<< $blocknumber)"
    hexnumb="${hexnumb%\"}"
    hexnumb="${hexnumb#\"}"
    echo $(("$hexnumb"))
}

function getbalance() {
    local  balance=$(curl --data '{"method":"eth_getBalance","params":["0xb9515e8dba64827c96bb7e324374ed4e24878dc1"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545)
    hexbal="$(jq '.result' <<< $balance)"
    bc <<< "scale = 8; $decbal * 0.000000000000000001"
}

getbalance=$(getbalance)
echo $getbalance