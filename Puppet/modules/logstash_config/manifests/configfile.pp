define logstash_config::configfile (
  $source = undef,
  $config_dir = '/etc/logstash/conf.d',
  $type = undef 
)
{
 file {"${config_dir}/${name}_${type}.conf":
                source => "$source",
                owner => 'root',
                group => 'root',
                mode => '644',
 }
}

