apt_package ['apache2', 'mysql-server', 'php', 'libapache2-mod-php', 'php-mysql']

cookbook_file "Copy info.php" do
  group "root"
  mode "0755"
  owner "root"
  path "/var/www/html/info.php"
  source "info.php"
end

execute "Secure MySQL installation" do
  command "mysql --user=root <<_EOF_
USE mysql;
UPDATE user SET authentication_string=password('#{node['db_root_password']}') where user='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
_EOF_"
end
