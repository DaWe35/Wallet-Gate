import config
import requests

# define RPC calls
class RPC:

    def post(method, params = []):
        data = {'jsonrpc': '1.0',
            'method': method,
            'params': params }
        req = requests.post('http://127.0.0.1:' + config.RPC_PORT, auth=(config.PRC_USER, config.RPC_PASSWORD), json = data)
        data = req.json()
        if (data['error'] != None):
            raise Exception('RPC error: ' + str(data['error']))
        else:
            return data['result']