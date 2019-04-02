apt_package ['apache2', 'mysql-server', 'php', 'libapache2-mod-php', 'php-mysql']

cookbook_file "Copy info.php" do
  group "root"
  mode "0755"
  owner "ec2-user"
  path "/var/www/html/info.php"
  source "info.php"
end
