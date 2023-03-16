project('main', 'cpp')

zdep = dependency('zlib', version : '>=1.2.8')
openssldep = dependency('OpenSSL', version : '>=1.1.1')
boost_dep = dependency(
    'boost', version : '>=1.79.0',
    modules : [
        'date_time', 
        'filesystem',
        'serialization',
        'atomic', 
        'json',
        'log_setup', 
        'log', 
        'program_options',
        'system' 
    ]
)
thread_dep = dependency('threads')
executable(
    'main', 
    'main.cpp', 
    install : true, install_dir : '.',
    dependencies : [zdep, openssldep, boost_dep, thread_dep]
)