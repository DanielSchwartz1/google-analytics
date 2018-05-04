#!/bin/bash
#Daniel Schwartz
#Version: 1.0.0
#04.05.2018
#Script to get the newest version of analytics.js + gtag js file to host it local for your wordpress page
#Change the script according to your needs. In my case as example i used the name gtag.js. I've also replaced it in the php files of my wordpress theme.
TIME=$(date)

#Define source and content folder 
SOURCE_FOLDER=/data/google_scripts/
CONTENT_FOLDER_ANALYTICS=/var/www/html/the-small-things-in-life.com/wp-content/google-analytics/
CONTENT_FOLDER_GTAG=/var/www/html/the-small-things-in-life.com/wp-content/googletagmanager/

#Download new version of analytics.js
/usr/bin/wget https://www.google-analytics.com/analytics.js -q

#Download new version of gtag js file
/usr/bin/wget https://www.googletagmanager.com/gtag/js -q

#Rename gtag js file to gtag.js
#Renamed to a .js file to get recognized as javascript type by deflate module
/usr/bin/mv js gtag.js

#Change URL of analytics.js file to the local hosted URL in gtag.js file
/usr/bin/sed -i 's/www.google-analytics.com/the-small-things-in-life.com\/wp-content\/google-analytics/g' gtag.js

#Compare current hosted versions with new downloaded versions - gtag.js
if /usr/bin/diff $SOURCE_FOLDER/gtag.js $CONTENT_FOLDER_GTAG/gtag.js >/dev/null; then
   echo "$TIME: Files are the same" >> $SOURCE_FOLDER/gtag.log
else 
   echo "$TIME: Files are not the same, replacing with new file" >> $SOURCE_FOLDER/gtag.log
   \/usr/bin/cp $SOURCE_FOLDER/gtag.js $CONTENT_FOLDER_GTAG/
fi

#Compare current hosted versions with new downloaded versions - analytics.js
if /usr/bin/diff $SOURCE_FOLDER/analytics.js $CONTENT_FOLDER_ANALYTICS/analytics.js >/dev/null; then
   echo "$TIME: Files are the same" >> $SOURCE_FOLDER/analytics.log
else
   echo "$TIME: Files are not the same, replacing with new file" >> $SOURCE_FOLDER/analytics.log
   \/usr/bin/cp $SOURCE_FOLDER/analytics.js $CONTENT_FOLDER_ANALYTICS/
fi

#Remove gtag.js + analytics.js from source folder
/usr/bin/rm -rf $SOURCE_FOLDER/gtag.js $SOURCE_FOLDER/analytics.js

