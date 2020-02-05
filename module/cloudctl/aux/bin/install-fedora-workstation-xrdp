#!/bin/bash
#################################################################################
run_log () {
if [[ $1 == 0 ]]; then
    echo ">   STAT: $2"
elif [[ $1 != 0 ]]; then
    echo ">   ERR: $2"
    exit 1
fi
}

#################################################################################
# Install Ubuntu Minimal Desktop Environment
apt_ACCESS=$(apt-get update | echo $?)
[[ ${apt_ACCESS} != 0 ]] && run_log 1 "unable to reach ubuntu repo; exiting!"
apt-get upgrade -y
apt-get install -qq p7zip-full tasksel
tasksel install ubuntu-desktop
apt-get install -qq virt-manager
[[ $? != 0 ]] && run_log 1 "tasksel install failed!; exiting!"


#################################################################################
# Remove Non-essential Applications
# Desktop apps
apt-get purge -y \
cheese vino shotwell totem usb-creator-gtk deja-dup gnome-calendar simple-scan \
thunderbird transmission-gtk gnome-todo baobab rhythmbox

# Desktop experience
apt-get purge -y \
thunderbird-gnome-support

# Games
apt-get purge -y \
aisleriot gnome-mahjongg gnome-mines gnome-sudoku branding-ubuntu

# Libreoffice
apt-get purge -y \
libreoffice-gnome libreoffice-writer libreoffice-calc libreoffice-impress \
libreoffice-math libreoffice-ogltrans libreoffice-pdfimport libreoffice-style-breeze

# Others
apt-get purge -y \
example-content ubuntu-web-launchers ebtables liblxc-common liblxc1 libuv1 \
lxcfs lxd-client uidmap xdelta3 lxd

# Langpacks (keeping libreoffice and thunderbird installed otherwise)
apt-get purge -y \
libreoffice-l10n-zh-cn libreoffice-l10n-zh-tw libreoffice-l10n-pt \ 
libreoffice-l10n-pt-br libreoffice-l10n-de libreoffice-l10n-fr  \
libreoffice-l10n-it libreoffice-l10n-ru libreoffice-l10n-en-za \
libreoffice-help-en-gb libreoffice-help-es libreoffice-help-zh-cn \
libreoffice-help-zh-tw libreoffice-help-pt libreoffice-help-pt-br \
libreoffice-help-de libreoffice-help-fr libreoffice-help-it libreoffice-help-ru \
libreoffice-help-en-us thunderbird-locale-en thunderbird-locale-en-gb \
thunderbird-locale-en-us thunderbird-locale-es thunderbird-locale-es-ar \
thunderbird-locale-es-es thunderbird-locale-zh-cn thunderbird-locale-zh-hans \
thunderbird-locale-zh-hant thunderbird-locale-zh-tw thunderbird-locale-pt \
thunderbird-locale-pt-br thunderbird-locale-pt-pt thunderbird-locale-de \
thunderbird-locale-fr thunderbird-locale-it thunderbird-locale-ru \
libreoffice-l10n-en-gb libreoffice-l10n-es

# Unused rdepends
apt-get purge -y \
gir1.2-rb-3.0 gir1.2-totem-1.0 gir1.2-totemplparser-1.0 guile-2.0-libs \
libabw-0.1-1 libavahi-ui-gtk3-0 libdmapsharing-3.0-2 libexttextcat-2.0-0 \
libexttextcat-data libfreehand-0.1-1 libgnome-games-support-1-3 \
libgnome-games-support-common libgom-1.0-0 libgrilo-0.3-0 liblangtag-common \
liblangtag1 libmessaging-menu0 libmhash2 libminiupnpc10 libmwaw-0.3-3 \
libmythes-1.2-0 libnatpmp1 libneon27-gnutls liborcus-0.13-0 libpagemaker-0.0-0 \
librdf0 libreoffice-avmedia-backend-gstreamer libreoffice-base-core \
libreoffice-common libreoffice-core libreoffice-draw libreoffice-gtk3 \
libreoffice-style-elementary libreoffice-style-galaxy libreoffice-style-tango \
libraptor2-0 librasqal3 librevenge-0.0-0 librhythmbox-core10 \
libtotem0 libvisio-0.1-1 libwpd-0.10-10 libwpg-0.3-3 libwps-0.4-4 \
libyajl2 python3-uno rhythmbox-data rhythmbox-plugin-alternative-toolbar \
rhythmbox-plugins remmina-common remmina-plugin-rdp remmina-plugin-secret \
remmina-plugin-vnc duplicity seahorse-daemon shotwell-common totem-common \
totem-plugins transmission-common cheese-common gnome-todo-common libgnome-todo \
gnome-video-effects libcheese-gtk25 libcheese8 uno-libs3 ure zeitgeist-core \
hunspell-de-at-frami hunspell-de-ch-frami hunspell-de-de-frami hunspell-en-au  \
hunspell-en-ca hunspell-en-gb hunspell-en-za hunspell-es hunspell-fr \
hunspell-fr-classical hunspell-it hunspell-pt-br hunspell-pt-pt hunspell-ru  \
hyphen-de hyphen-en-ca hyphen-en-gb hyphen-en-us hyphen-fr hyphen-hr \
hyphen-it hyphen-pl hyphen-pt-br hyphen-pt-pt hyphen-ru mythes-de mythes-de-ch  \
mythes-en-au mythes-en-us mythes-fr mythes-it mythes-pt-pt mythes-ru  

apt-get install gnome-control-center --install-recommends -y
sudo apt-get autoremove -y && sudo apt-get clean -y

#################################################################################
# Prepare xRDP Standup Resources
mkdir ~/Downloads 2>/dev/null ; cd ~/Downloads
wget -P ~/Downloads http://www.c-nergy.be/downloads/install-xrdp-3.0.zip
7z e install-xrdp-3.0.zip && chmod +x Install-xrdp-3.0.sh 

#################################################################################
# Run xRDP Standup Script
./Install-xrdp-3.0.sh -s yes -g yes

#################################################################################
echo "    Going Down for System Halt Now: ${HOSTNAME} ... Shutting Down!"
shutdown -h now
