from abc import ABC, abstractmethod

class nodeInterface(ABC):

    @abstractmethod
    def __init__(self):
        pass

    @abstractmethod
    def balance(self):
        pass

    @abstractmethod
    def blockcount(self):
        pass

    @abstractmethod
    def transaction(self):
        pass

    @abstractmethod
    def newaddress(self):
        pass
        
    @abstractmethod
    def sendto(self):
        pass