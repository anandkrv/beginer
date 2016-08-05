['/etc/nginx/conf.d/default.conf', '/etc/nginx/conf.d/ssl.conf', '/etc/nginx/conf.d/virtual.conf'].each do |path|
	file path do
		action :delete
	end
end

cookbook_file '/etc/nginx/conf.d/server.conf' do
  source 'server.conf'
end

cookbook_file '/usr/share/nginx/html/index.html' do
  source 'index.html'
end
