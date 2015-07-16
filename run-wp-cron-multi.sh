#!/bin/bash
#
# WordPress-Multisite-System-Cron
#
# Change this variable to be the path to your WordPress installation
WP_PATH="/var/www/html/thelastcicada.com"
DELAY="8"

[ -d "$WP_PATH" ] || exit 1
cd "$WP_PATH"
THIS_OWNER="$(stat . -c %U)"

wp --allow-root site list --field=url | while read SITE_URL; do
    wp --allow-root --url="$SITE_URL" cron event list --fields=hook | while read HOOK; do
        # Run as the the directory's owner
        nice sudo -u "$THIS_OWNER" -- timeout 300 wp --url="$SITE_URL" cron event run "$HOOK" \
            || echo "${SITE} / ${HOOK} error." >&2
        # Prevent all sites from running wp-cron at once
        sleep "$DELAY"
    done
done
