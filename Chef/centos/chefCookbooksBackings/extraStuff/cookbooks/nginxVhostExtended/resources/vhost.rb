actions :configure
default_action :configure

attribute :name,
  kind_of: String,
  required: true,
  name_attribute: true
attribute :port,
  kind_of: Fixnum
attribute :webroot,
  kind_of: String
attribute :servername,
  kind_of: String
attribute :conffile,
  kind_of: String
