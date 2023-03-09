# Install Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable

# Install Dark Reader and SwiftRead plugins
# SWIFTREAD_KEY is the purchase key for the plugin
SWIFTREAD_KEY="YOUR_SWIFTREAD_KEY_HERE"
google-chrome-stable --no-sandbox --no-first-run --disable-gpu --remote-debugging-port=9222 &
while ! curl -s http://localhost:9222/json/version > /dev/null; do sleep 1; done
wget -O darkreader.crx https://clients2.google.com/service/update2/crx?response=redirect&prodversion=89.0.4389.82&acceptformat=crx2,crx3&x=id%3Dmkbmlkkpdmfghmpacakdgfgfmflmpgaf%26installsource%3Dondemand%26uc
wget -O swiftread.crx https://clients2.google.com/service/update2/crx?response=redirect&prodversion=89.0.4389.82&acceptformat=crx2,crx3&x=id%3Djjgfnmnkniggepnhomofbhemmhbdeiih%26installsource%3Dondemand%26uc
curl -o- http://localhost:9222/json/list | jq -r '.[] | select(.type == "page") | .id' | xargs -I{} sh -c 'curl -s -X POST -H "Content-Type: application/json" http://localhost:9222/{}/extensions --data-binary @- << EOF
{
  "id": "mkbmlkkpdmfghmpacakdgfgfmflmpgaf",
  "path": "/path/to/darkreader.crx"
}
EOF
curl -s -X POST -H "Content-Type: application/json" http://localhost:9222/{}/extensions --data-binary @- << EOF
{
  "id": "jjgfnmnkniggepnhomofbhemmhbdeiih",
  "path": "/path/to/swiftread.crx",
  "update_url": "https://app.getswiftread.com/api/v1/chrome-update/",
  "key": "'${SWIFTREAD_KEY}'"
}
EOF
'

# In this script, the SWIFTREAD_KEY variable is created and assigned the value of your SwiftRead key.
# Then, in the curl command that installs the SwiftRead plugin, the update_url and key options are added and SWIFTREAD_KEY is used to replace the value of the key option.

# Note that you will still need to replace /path/to/darkreader.crx and /path/to/swiftread.crx
# with the actual paths to the plugin files you want to install.
