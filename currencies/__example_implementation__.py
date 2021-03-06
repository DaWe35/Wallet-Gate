from currencies.__interface__ import nodeInterface
from model.rpc import RPC

class Node(nodeInterface):
    
    def __init__(self):
        #test node
        if int(self.blockcount()) < 1:
            raise Exception('Could not talk to node')

    def blockcount(self):
        return 12

    def balance(self):
        return 284

    def transaction(self):
        return 'gettransaction'

    def newaddress(self):
        return '1testaddress'
        
    def sendto(self):
        return 'txid'