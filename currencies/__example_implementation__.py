from currencies.__interface__ import nodeInterface

class Node(nodeInterface):
    def getbalance(self):
        return 284

    def getblockcount(self):
        return 12

    def __init__(self):
        if self.getblockcount() < 1:
            raise Exception("Could not talk to node")
        
    def sendto(self):
        return ''

    def gettransaction(self):
        return 'gettransaction'

    def getnewaddress(self):
        return '1testaddress'