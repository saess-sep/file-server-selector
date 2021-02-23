# file-server-selector
File Server Selector lets you pick which SMB share on a server you want from a list, since Big Sur won't allow you to do that.
# usernames
By default, Finder will ask you to put in a username and password to access the share.  You can put one in and save the credential to Keychain, which will automatically use that credential going forward.  You can also supply your username as an argument to the script (when running interactively).
# run as user
Since this script is meant to be run in Jamf, it will detect who the logged in user is and run the AppleScript and open commands as something other than root.  This won't have any effect if you run the script yourself.
# why can't I connect?
Make sure you set the server beforehand.  To aid in troubleshooting the script will echo the username, current logged in user, your selection, and then what the literal path it's opening is.
