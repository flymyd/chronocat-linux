#!/bin/sh
node_version=$(node --version)
echo "nameserver 114.114.114.114\nsearch lan" | tee /etc/resolv.conf > /dev/null
echo "Node.js version: $node_version"
Xvfb :1 -screen 0 ${VNC_RESOLUTION}x${VNC_COL_DEPTH} &
qq --chrono-mode=headless3
