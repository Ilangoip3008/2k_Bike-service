#!/bin/bash
tar -czf /home/ubuntu/app-backup-$(date +%F).tar.gz /var/log/app
aws s3 cp /home/ubuntu/app-backup-$(date +%F).tar.gz s3://your-bucket-name/
