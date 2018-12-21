function getblocknumber() {
    local  blocknumber=$(curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":83}' -H "Content-Type: application/json" localhost:8545)
    hexnumb="$(jq '.result' <<< $blocknumber)"
    hexnumb="${hexnumb%\"}"
    hexnumb="${hexnumb#\"}"
    echo $(("$hexnumb"))
}

function getbalance() {
    local  balance=$(curl --data '{"method":"eth_getBalance","params":["0xf4d9ac9b0363e0ef8a8b78f16fc35a0da044c0c9"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545)
    hexbal="$(jq '.result' <<< $balance)"
    bc <<< "scale = 8; $decbal * 0.000000000000000001"
}

getbalance=$(getbalance)
echo $getbalance

function getStoragePercent() { # in GB
    df --output=pcent / | tr -dc '0-9'
}
function getStorageUsed() {
    df -h --output=used / | tr -dc '0-9'
}
function getStorageAvail() {
    df -h --output=avail / | tr -dc '0-9'
}
function getStorageSize() {
    df -h --output=size / | tr -dc '0-9'
}