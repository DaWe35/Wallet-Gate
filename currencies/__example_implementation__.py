from currencies.__interface__ import nodeInterface

class Node(nodeInterface):
    
    def __init__(self):
        #connect to node
        #___

        #test node
        if self.getblockcount() < 1:
            raise Exception("Could not talk to node")

    def getbalance(self):
        return 284

    def getblockcount(self):
        return 12

    def gettransaction(self):
        return 'gettransaction'

    def getnewaddress(self):
        return '1testaddress'
        
    def sendto(self):
        return 'txid'