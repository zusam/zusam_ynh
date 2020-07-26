#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# official variable for app dependencies
pkg_dependencies="unzip ffmpeg"

#=================================================
# PERSONAL HELPERS
#=================================================

str_remove_leading() {
  [ -z "$2" ] && char='\s' || char="$2"
  echo "$1" | sed -E "s/^$char+//"
}

str_remove_trailing() {
  [ -z "$2" ] && char='\s' || char="$2"
  echo "$1" | sed -E "s/$char+$//"
}

load_app_settings() {
  ynh_script_progression --message="Loading installation settings..." --weight=1

  if [ -z "$YHN_APP_INSTANCE_NAME" ]; then
    ynh_die --message="YHN_APP_INSTANCE_NAME is not defined. ($YNH_APP_INSTANCE_NAME)"
  fi

  app="$YNH_APP_INSTANCE_NAME"

  final_path="$(ynh_app_setting_get --app="$app" --key=final_path)"
  domain="$(ynh_app_setting_get --app="$app" --key=domain)"
  is_public="$(ynh_app_setting_get --app="$app" --key=is_public)"
  language="$(ynh_app_setting_get --app="$app" --key=language)"
  phpversion="$(ynh_app_setting_get --app="$app" --key=phpversion)"

  # necessary for the official php helper
  YNH_PHP_VERSION="$phpversion"

  # php dependencies
  php_extensions="\
    php$phpversion-curl \
    php$phpversion-imagick \
    php$phpversion-intl \
    php$phpversion-mbstring \
    php$phpversion-sqlite3 \
    php$phpversion-xml \
  "

  # Normalize the URL path syntax
  path_url="$(ynh_normalize_url_path --path_url="$path_url")"

  # Remove leading "/"
  path_name="$(str_remove_leading "$path_url" '\/')"

  # Standard yunohost paths
  nginx_config_path="/etc/nginx/conf.d/$domain.d/$app.conf"
  php_fpm_config_path="/etc/php/$phpversion/fpm/pool.d/$app.conf"
  fail2ban_jail_path="/etc/fail2ban/jail.d/$app.conf"
  fail2ban_filter_path="/etc/fail2ban/filter.d/$app.conf"
}

set_app_permissions() {

  if [ -z "$final_path" ]; then
    ynh_die --message="final_path is not defined."
  fi

  # Set permissions to app files
  chown -R root: "$final_path"
  chown -R www-data: "$final_path/data"
  chown -R www-data: "$final_path/api/var"
  chown -R www-data: "$final_path/public"
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

source composer
