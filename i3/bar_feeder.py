#!/usr/bin/env python3

import os
import sys
import time
import subprocess
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
        self.add_volume()
        self.add_time()
        self.write_output()

    def run_script(self, name):
        proc = subprocess.Popen(name, shell=True, stdout=subprocess.PIPE)
        out = proc.stdout.read()
        out_str = out.decode("utf-8").strip()
        return "{}".format(out_str)

    def add_volume(self):
        self.output += self.run_script('./get_volume.sh')

    def add_time(self):
        time.ctime()
        timeString  = time.strftime('%l:%M%p %a %d/%m/%y')
        self.output += "{}".format(timeString)

bar = Bar()

while True:
    bar.update()
    # time.sleep(.5)
