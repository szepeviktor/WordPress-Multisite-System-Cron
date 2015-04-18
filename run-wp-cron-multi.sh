#!/bin/bash

# Change this variable to be the path to your WordPress installation
wp_path='/var/www/html/thelastcicada.com'

cd ${wp_path}

wp site list --field=url --allow-root | while read site
do
        curl -L -s ${site}wp-cron.php  # -s for silent, -L to follow redirect
        sleep 8  #Prevent all sites from running wp-cron at once
done
