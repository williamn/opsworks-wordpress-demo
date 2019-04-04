execute 'Download and unzip WordPress package' do
  command ['wget https://wordpress.org/latest.tar.gz', 'tar -xzf latest.tar.gz']
end
