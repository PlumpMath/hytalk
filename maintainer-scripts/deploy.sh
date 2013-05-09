#!/bin/bash

echo "Pulling repo."
ssh metatron.pault.ag "cd /srv/www/uwsgi/app/hytalk; git pull origin master"
ssh -l www metatron.pault.ag "kill-apps; start-apps"
