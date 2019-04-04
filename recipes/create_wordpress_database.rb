execute "mysql -u root -p#{node['db_root_password']} <<_EOF_
CREATE USER '#{node['wordpress_db_user']}'@'localhost' IDENTIFIED BY '#{node['wordpress_db_password']}';
_EOF_"
execute "CREATE DATABASE '#{node['wordpress_db_name']}';"
execute "GRANT ALL PRIVILEGES ON '#{node['wordpress_db_name']}'.* TO '#{node['wordpress_db_user']}'@'localhost';"
execute 'FLUSH PRIVILEGES;'
