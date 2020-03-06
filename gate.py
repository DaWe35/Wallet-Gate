import schedule
import config
from filedb.filedb import Filedb

package = 'currencies.' + config.NODE
Node = getattr(__import__(package, fromlist=['Node']), 'Node')

package = 'protocols.' + config.PROTOCOL + '.rest'
Protocol = getattr(__import__(package, fromlist=['Protocol']), 'Protocol')

node = Node()
protocol = Protocol()

walletnotify_txt = Filedb('walletnotify')
walletnotify_lastcheck = 0

lastblockhash_txt = Filedb('lastblockhash')
lastblockhash_lastcheck = 0

# withdraw & generate new addresses every 10 min
def send_gen():
    fetch from exchane
    
    newaddresses = []
    while fetch.needNewAddres < newaddresses.len():
        newaddresses[] = node.newaddress()
    send new addresses

    foreach fetch.withdraw as withdraw
        filedb.push(withdraw.id)
        node.send(withdraw.address)

schedule.every(1).minute.do(send_gen)

while True:
    # if new block found
    if lastblockhash_txt.lastModify() > lastblockhash_lastcheck:
        fetch from exchane
        update required tx
    # if new transaction found
    if walletnotify_txt.lastModify() > walletnotify_lastcheck:
        send new tx

    schedule.run_pending()



print('Balance:', node.balance(), 'BTC')
print('Blockcount:', node.blockcount())
# print('GetTransaction:', node.gettransaction('624f894301f2be2b4ab09dc0b42891550a1ea0dbb651a4c3287f4e5332446571'))
# print('Get new address:', node.newaddress())
# print('Send:', node.sendto('2N5fJkfCv4cF6vsa5QQJnsazBKWNXynn9zp', '0.00000540'))