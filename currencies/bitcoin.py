from currencies.__interface__ import nodeInterface
from model.rpc import RPC

class Node(nodeInterface):

    def __init__(self):
        #test node
        if int(self.blockcount()) < 1:
            raise Exception('Could not talk to node')

    def blockcount(self):
        return RPC.post('getblockcount')

    def balance(self):
        return RPC.post('getbalance')

    def transaction(self, txid):
        return RPC.post('gettransaction', [txid])

    def newaddress(self):
        return RPC.post('getnewaddress')
        
    def sendto(self, address, amount):
        return RPC.post('sendtoaddress', [address, amount])