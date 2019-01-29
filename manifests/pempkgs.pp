class edbas::edbaspkgs (
) {

  # Prevent Puppet from installing updated/latest packages
  $pkgs = ['encfs',
           'edb-as96',
           'pgaudit11_96-1.1.1-1.rhel7.x86_64',
           'pgaudit11_96-debuginfo-1.1.1-1.rhel7.x86_64',
           'edb-pgpool36-3.6.7-1.rhel7.x86_64',
           'edb-as96-pgpool35-extensions-3.5.11-1.rhel7',
           'efm21-2.1.2-1.rhel7.x86_64',
           'edb-as96-postgis-2.3.6-2.rhel7',
           'edb-as96-postgis-2.3.6-2.rhel7.x86_64',
           'edb-as96-postgis-core-2.3.6-2.rhel7.x86_64',
           'edb-as96-postgis-docs-2.3.6-2.rhel7.x86_64',
           'edb-as96-postgis-jdbc-2.2.1-2.rhel7.x86_64',
           'edb-as96-postgis-utils-2.3.6-2.rhel7.x86_64',
          ]

  package { $pkgs:
    ensure  =>  'installed',
  }

  $pkgs_to_remove = ['postgresql96.x86_64',
                     'postgresql96-contrib.x86_64',
                     'postgresql96-libs.x86_64',
                     'postgresql96-server.x86_64',
                    ]

  package { $pkgs_to_remove:
    ensure  => 'absent',
  }
}
