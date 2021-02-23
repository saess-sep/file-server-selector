#!/bin/zsh
#file server selector v0.3
echo "File Server Selector"
#jamf argument shift
if [[ $1 == "/" ]]; then
    # jamf uses sends '/' as the first argument
    echo "shifting arguments for Jamf"
    shift 2
fi

#config
DirectoryList='' #list your directories as an AppleScript list in between single quotes '{"Share", "Share2"}'
UserName="$1"
if [[ $UserName != "" ]] ; then
    UserName="$1@"
fi
echo "$UserName"
ConnectionType='smb://' #how you're connecting
ServerPath='server.domain.com' #your file server
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
echo $currentUser

#functions
runAsUser() {
    if [[ $currentUser != "loginwindow" ]]; then
        uid=$(id -u "$currentUser")
        launchctl asuser $uid sudo -u $currentUser "$@"
    fi
}

#code
ListSelection=$( runAsUser osascript -e "choose from list $DirectoryList with prompt \"Which directory would you like to connect to?\"" )
echo $ListSelection
#Choice=$( displayList $DirectoryList )
if [[ $ListSelection != "false" ]] && [[ $ListSelection ]] ; then
    echo "opening $ConnectionType$UserName$ServerPath$ListSelection"
    runAsUser open $ConnectionType$UserName$ServerPath$ListSelection
else
    echo "no selection"
    exit 10
fi