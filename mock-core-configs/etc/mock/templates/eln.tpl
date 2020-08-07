config_opts['root'] = 'eln-{{ target_arch }}'

config_opts['chroot_setup_cmd'] = 'groupinstall build'

config_opts['dist'] = 'eln'  # only useful for --resultdir variable subst
config_opts['extra_chroot_dirs'] = [ '/run/lock', ]
# config_opts['releasever'] = 'eln'
config_opts['package_manager'] = 'dnf'

config_opts['macros']['%dist'] = '%{!?distprefix0:%{?distprefix}}%{expand:%{lua:for i=0,9999 do print("%{?distprefix" .. i .."}") end}}.eln%{eln}%{?with_bootstrap:~bootstrap}'
config_opts['macros']['%eln'] = '100'
config_opts['macros']['%fedora'] = '%{nil}'
config_opts['macros']['%rhel'] = '9'

config_opts['yum.conf'] = """
[main]
keepcache=1
debuglevel=2
reposdir=/dev/null
logfile=/var/log/yum.log
retries=20
obsoletes=1
gpgcheck=0
assumeyes=1
syslog_ident=mock
syslog_device=
install_weak_deps=0
metadata_expire=0
best=1
protected_packages=

# repos

[eln]
name=ELN
baseurl=https://kojipkgs.fedoraproject.org/repos/eln-build/latest/$basearch
enabled=1
skip_if_unavailable=False
"""
