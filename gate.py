import config

package = 'currencies.' + config.NODE
Node = getattr(__import__(package, fromlist=['Node']), 'Node')

node = Node()
print('Balance:', node.balance(), 'BTC')
print('Blockcount:', node.blockcount())
# print('GetTransaction:', node.gettransaction('624f894301f2be2b4ab09dc0b42891550a1ea0dbb651a4c3287f4e5332446571'))
# print('Get new address:', node.newaddress())
# print('Send:', node.sendto('2N5fJkfCv4cF6vsa5QQJnsazBKWNXynn9zp', '0.00000540'))