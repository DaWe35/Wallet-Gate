import config

package = "currencies." + config.NODE
Node = getattr(__import__(package, fromlist=["Node"]), "Node")

node = Node()
print('Balance:', node.getbalance(), 'BTC')
print('Blockcount:', node.getblockcount())