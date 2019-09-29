#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="unzip ffmpeg"
php_version="7.3"
php_extensions="php$php_version-curl php$php_version-imagick php$php_version-intl php$php_version-mbstring php$php_version-sqlite3 php$php_version-xml"

#=================================================
# PERSONAL HELPERS
#=================================================


#=================================================
# EXPERIMENTAL HELPERS
#=================================================

source ynh_add_extra_apt_repos__3
source ynh_install_php__3
source ynh_composer__2

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
