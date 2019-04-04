execute "mysql -u root -p#{node['db_root_password']} <<_EOF_
CREATE USER '#{node['wordpress_db_user']}'@'localhost' IDENTIFIED BY '#{node['wordpress_db_password']}';
CREATE DATABASE #{node['wordpress_db_name']};
GRANT ALL PRIVILEGES ON #{node['wordpress_db_name']}.* TO '#{node['wordpress_db_user']}'@'localhost';
FLUSH PRIVILEGES;
_EOF_"
