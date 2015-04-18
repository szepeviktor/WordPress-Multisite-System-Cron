#!/bin/bash

wp_path='/var/www/html/thelastcicada.com'

cd ${wp_path}

wp site list --field=url --allow-root | while read site
do
        curl -L -s ${site}wp-cron.php
        sleep 8
done
