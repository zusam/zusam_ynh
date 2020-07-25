#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# official variable for packages to add
pkg_dependencies="unzip ffmpeg"

# necessary for the official php helper
YNH_PHP_VERSION=7.3

# php dependencies
php_extensions="php$YNH_PHP_VERSION-curl php$YNH_PHP_VERSION-imagick php$YNH_PHP_VERSION-intl php$YNH_PHP_VERSION-mbstring php$YNH_PHP_VERSION-sqlite3 php$YNH_PHP_VERSION-xml"

#=================================================
# PERSONAL HELPERS
#=================================================

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

source ynh_composer__2

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
