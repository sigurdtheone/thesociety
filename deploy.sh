#!/bin/bash
echo "Synching to Server"
rsync -av --itemize-changes /var/www/thesociety.dk/ sigurd@5.103.134.13:thesociety.dk/

echo "Deploying to production"
ssh -t sigurd@5.103.134.13 'sudo rsync -av /home/sigurd/thesociety.dk/ /var/www/thesociety.dk/ && sudo service apache2 restart'
