execute 'Prepare LAMP server' do
  command 'sudo yum update -y'
  command 'sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2'
end

yum_package ['httpd', 'mariadb-server', 'php-mysqlnd']

execute 'Start Apache web server' do
  command 'sudo systemctl start httpd'
  command 'sudo systemctl enable httpd'
end

execute 'Set file permissions' do
  command 'sudo usermod -a -G apache ec2-user'
  command 'sudo chown -R ec2-user:apache /var/www'
  command 'sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;'
  command 'find /var/www -type f -exec sudo chmod 0664 {} \;'
end

cookbook_file 'Copy info.php' do
  group 'apache'
  mode '0755'
  owner 'ec2-user'
  path '/var/www/html/info.php'
  source 'info.php'
end

execute 'Start MariaDB server' do
  command 'sudo systemctl start mariadb'
  command 'sudo systemctl enable mariadb'
end

execute 'Secure MySQL installation' do
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
