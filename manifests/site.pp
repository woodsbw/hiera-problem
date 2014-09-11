node 'puppetproblems' {
  class { '::mysql::server':
    package_ensure => 'present',
    root_password  => 'testpassword',
    package_name   => 'mariadb-server',
  }

  mysql_user { 'admin@localhost':
    ensure        => 'present',
    password_hash => '*1EF93BB5FBDDDDDDDDDDDDDDDDDDDD6D585C6A33',
  }

  mysql_user { 'test@localhost':
    ensure        => 'present',
    password_hash => '*AB83E109EFDFddddddddddddddddddd0614798E0',
  }

  mysql_grant { 'admin@localhost/*.*':
    ensure         => 'present',
    options        => ['GRANT'],
    privileges     => ['ALL'],
    table          => '*.*',
    user           => 'admin@localhost',
  }

  mysql_grant{ 'test@localhost/test.*':
    ensure         => 'present',
    options        => ['GRANT'],
    privileges     => ['ALL'],
    table          => 'test.*',
    user           => 'test@localhost',
  }

  mysql_database{ 'test':
        ensure     => 'present',
        charset    => 'utf8',
  }
}
