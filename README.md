# Possible Bug Between Hiera and puppetlabs/mysql

This is a simple expamepls of a bug I am seeing with Hiera. When pupetlabs/mysql is installed (and being used) AND the Hiera yaml backend is in use, but NOT the first backend listedin hiera.yaml, the following error is produced on the puppet run:

``` 
Error: Error from DataBinding 'hiera' while looking up 'mysql::server::config_file': undefined method `datasourcefiles' for Hiera::Backend:Module on node <nodename>
Wrapped exception:
undefined method `datasourcefiles' for Hiera::Backend:Module
Wrapped exception:
undefined method `datasourcefiles' for Hiera::Backend:Module
Error: Error from DataBinding 'hiera' while looking up 'mysql::server::config_file': undefined method `datasourcefiles' for Hiera::Backend:Module on node <nodename>
```

This error does NOT occur when running hiera from the command line, even with identical configuration (syslink'd /etc/hiera.yaml --> /etc/puppet/hiera.yaml.)

Output of "hiera -d mysql::server::config_file":

```
DEBUG: 2014-09-11 12:16:55 -0500: Hiera YAML backend starting
DEBUG: 2014-09-11 12:16:55 -0500: Looking up mysql::server::config_file in YAML backend
DEBUG: 2014-09-11 12:16:55 -0500: Looking for data source defaults
DEBUG: 2014-09-11 12:16:55 -0500: Cannot find datafile /etc/puppet/data/defaults.yaml, skipping
DEBUG: 2014-09-11 12:16:55 -0500: Looking for data source global
DEBUG: 2014-09-11 12:16:55 -0500: Hiera File backend starting
DEBUG: 2014-09-11 12:16:55 -0500: Looking up mysql::server::config_file in File backend
DEBUG: 2014-09-11 12:16:55 -0500: Hiera File_backend: looking for data source 'defaults'
DEBUG: 2014-09-11 12:16:55 -0500: Hiera File_backend: looking for data source 'global'
DEBUG: 2014-09-11 12:16:55 -0500: Cannot find datafile /etc/puppet/file-data/global.d, skipping
nil
```

Software details:
 - Ubuntu 14.04.1
 - Puppet 3.4.3 (running masterless)
 - Hiera 1.3.4

