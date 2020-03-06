class Filedb():

    def __init__(self, filename):
        self.file = 'filedb/' + filename + '.txt'
        open(self.file, 'a').close() # create file id not exist

    def lastModify(self):
        return os.path.getmtime(self.file)

    def push(self, string):
        with open(self.file, 'a') as f:
            f.write(string + '\n')

    def pop(self):
        with open(self.file, 'r+') as f: # open in read / write mode
            firstLine = f.readline() # read the first line and throw it out
            data = f.read() # read the rest
            f.seek(0) # set the cursor to the top of the file
            f.write(data) # write the data back
            f.truncate() # set the file size to the current size
            return firstLine

    def overwrite(self, string):
        with open(self.file, 'w') as f: # open in write mode
            f.write(string + '\n') # write the data back
            return True