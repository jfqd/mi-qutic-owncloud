# set nexcloud data path
if mdata-get data_path 1>/dev/null 2>&1; then
  DATA_PATH=`mdata-get data_path`
  cd /var/www/htdocs/owncloud/current/
  ln -nfs "$DATA_PATH" data
fi

if mdata-get config_path 1>/dev/null 2>&1; then
  DATA_PATH=`mdata-get config_path`
  cd /var/www/htdocs/owncloud/current/
  ln -nfs "$config_path" config
fi

if mdata-get server_name 1>/dev/null 2>&1; then
  SERVER_NAME=`mdata-get server_name`
  sed -i "s:SERVER_NAME:$SERVER_NAME:g" /opt/local/etc/httpd/vhosts/01-owncloud.conf
else
  sed -i "s:ServerName SERVER_NAME::g" /opt/local/etc/httpd/vhosts/01-owncloud.conf
fi

if mdata-get server_alias 1>/dev/null 2>&1; then
  SERVER_ALIAS=`mdata-get server_alias`
  sed -i "s:SERVER_ALIAS:$SERVER_ALIAS:g" /opt/local/etc/httpd/vhosts/01-owncloud.conf
else
  sed -i "s:ServerAlias SERVER_ALIAS::g" /opt/local/etc/httpd/vhosts/01-owncloud.conf
fi

# Enable apache by default
/usr/sbin/svcadm enable svc:/pkgsrc/apache:default
