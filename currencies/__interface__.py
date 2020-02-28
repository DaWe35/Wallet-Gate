from abc import ABC, abstractmethod

class nodeInterface(ABC):

    @abstractmethod
    def __init__(self):
        pass

    @abstractmethod
    def getbalance(self):
        pass

    @abstractmethod
    def getblockcount(self):
        pass

    @abstractmethod
    def gettransaction(self):
        pass

    @abstractmethod
    def getnewaddress(self):
        pass
        
    @abstractmethod
    def sendto(self):
        pass