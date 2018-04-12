#!/usr/bin/env python3

import os
import sys
import time
from datetime import datetime

output = ""

class Bar():
    output = ""

    def write_output(self):
        sys.stdout.write(self.output)
        sys.stdout.write("\n")
        sys.stdout.flush()

    def update(self):
        self.output = ""
        self.add_time()
        self.write_output()

    def add_volume(self):
        self.output += os.system('./get_volume.sh')

    def add_time(self):
        time.ctime()
        timeString  = time.strftime('%l:%M%p %a %d/%m/%y')
        self.output += "{}".format(timeString)

bar = Bar()

while True:
    bar.update()
    time.sleep(.5)
