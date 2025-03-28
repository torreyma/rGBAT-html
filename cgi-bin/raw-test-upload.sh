#!/bin/bash
# The idea is that this file can be dropped in place of upload.sh in /var/www/cgi-bin/ so you can get the raw output to check against R in process.r
# But it is not working.

echo "Content-Type: text/plain"
echo

# read body into file:
#cat > /tmp/raw_post_body.txt
cat > /tmp/raw_post_bodt.txt

# confirmation:
echo "Saved raw POST body to /tmp/raw_post_body.txt"
