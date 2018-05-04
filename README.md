To get 100% pagespeed on Google Speedtool I need to host my analytics.js and googletagmanager js file locally on my VPS.
It is easy when you download it the first time, but to be sure it is up-to-date I created that bash script (the script is formed to fit my needs). 
The script downloads the new versions, checks if it is different and replace it in case.

# google-analytics
Bash script to get the newest version of analytics.js / gtags.js to get 100% pagespeed for your wordpress page
