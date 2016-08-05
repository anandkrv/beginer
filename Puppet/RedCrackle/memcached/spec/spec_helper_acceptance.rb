require 'beaker-rspec'

unless ENV["BEAKER_provision"] == "no"
  foss_opts = { :default_action => 'gem_install' }

  install_puppet(foss_opts)
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(:source => proj_root, :module_name => 'memcached')

    hosts.each do |host|
    end
  end
end
