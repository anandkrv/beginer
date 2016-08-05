#!/bin/bash
source /var/lib/jenkins/JobScripts/create_container_html.sh
create_container_html /var/lib/jenkins/portlookup/server_mapping /tmp/create_container.html
cp /tmp/create_container.html /var/lib/jenkins/html/index.html
