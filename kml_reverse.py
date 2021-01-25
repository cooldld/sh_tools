#!/usr/bin/python3

import sys

org_file = sys.argv[1]
dst_file = org_file.replace('.kml', '_reverse.kml')

need_revert = False

rf = open(org_file, 'r')
wf = open(dst_file, 'w')

while True:
    line = rf.readline()
    if not line: break
    if line.strip() == '<coordinates>':
        need_revert = True
    elif need_revert:
        need_revert = False
        l = line.strip().split()
        #检查每个经纬度的有效性
        for i in l:
            if i[-2:] != ',0':
                print('error, i =', i)
                sys.exit()
        l.reverse()
        line = ' '.join(l)
        line += '\n'
    wf.write(line)

rf.close()
wf.close()
