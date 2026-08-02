#!/bin/bash
find /var/log/app -type f -mtime +7 -exec rm {} \;
