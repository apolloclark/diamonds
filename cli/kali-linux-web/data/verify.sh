#!/bin/bash

assertVersion()
{
    
    # retrieve input values
    local cmd="$1";
    local assert="$2";
    
    # run the command
    returnVal="$(eval $cmd)";
    
    # verify the results
    if [ "$returnVal" != "$assert" ];
    then
        echo -e "ERROR: Incorrect value, for: '${cmd}'\n";
        echo -e "EXPECTED:\n'${assertVal}'\n";
        echo -e "FOUND:\n'${returnVal}'\n";
        exit 1;
    fi
    
    return 0;
};





assertCmd="/usr/sbin/apache2ctl -v";
assertVal=$(cat <<'EOF'
Server version: Apache/2.4.10 (Debian)
Server built:   Aug 28 2015 16:28:08
EOF
);
assertVersion "$assertCmd" "$assertVal";



# assertCmd="automater 127.0.0.1 | grep 'Results'";
# assertVal="____________________     Results found for: 127.0.0.1     ____________________";
# assertVersion "$assertCmd" "$assertVal";



assertCmd="arachni -v";
assertVal=$(cat <<'EOF'
Arachni - Web Application Security Scanner Framework v1.2.1
   Author: Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>

           (With the support of the community and the Arachni Team.)

   Website:       http://arachni-scanner.com
   Documentation: http://arachni-scanner.com/wiki


Arachni 1.2.1 (ruby 2.1.5p273) [x86_64-linux-gnu]
EOF
);
assertVersion "$assertCmd" "$assertVal";



# bbqsql, does something odd with STDOUT...


# beef-xss



# blindelephant



assertCmd="cadaver --version";
assertVal=$(cat <<'EOF'
cadaver 0.23.3
neon 0.30.1: Library build, IPv6, libxml 2.9.1, zlib 1.2.8, GNU TLS 3.3.8.
readline 6.3
EOF
);
assertVersion "$assertCmd" "$assertVal";



# clusterd, includes color codes... remove with sed???



assertCmd="cookie-cadger -version";
assertVal=$(cat <<'EOF'
No graphical environment found. Dropping to headless mode.


Cookie Cadger (v1.06, https://cookiecadger.com)
Created by Matthew Sullivan - mattslifebytes.com
This software is freely distributed under the terms of the FreeBSD license.

Fatal error: headless mode requires the use of an external database. Invoke with '--help' for database options.
EOF
);
assertVersion "$assertCmd" "$assertVal";



# cutycapt



# davtest, no clue...



# dirb, no clue...



# dirbuster -v, requires DISPLAY



# dnmap, cannot find...



assertCmd="dotdotpwn --version 2>&1";
assertVal=$(cat <<'EOF'
mlocate 0.26
Copyright (C) 2007 Red Hat, Inc. All rights reserved.
This software is distributed under the GPL v.2.

This program is provided with NO WARRANTY, to the extent permitted by law.
EOF
);
assertVersion "$assertCmd" "$assertVal";



# eyewitness, weird STDOUT...



# ftester, cannot find...



# funkload, cannot find...


assertCmd="golismero --version";
assertVal=$(cat <<'EOF'

/-------------------------------------------\
| GoLismero 2.0.0b6, The Web Knife          |
| Copyright (C) 2011-2014 GoLismero Project |
|                                           |
| Contact: contact@golismero-project.com    |
\-------------------------------------------/

usage: golismero.py [-h] [--help] [-f FILE] [--config FILE] [--user-config FILE] [-p NAME] [--ui-mode MODE] [-v] [-q]
                    [--color] [--no-color] [--audit-name NAME] [-db DATABASE] [-nd] [-i FILENAME] [-ni] [-o FILENAME]
                    [-no] [--full] [--brief] [--allow-subdomains] [--forbid-subdomains] [--parent] [-np] [-r DEPTH]
                    [--follow-redirects] [--no-follow-redirects] [--follow-first] [--no-follow-first]
                    [--max-connections MAX_CONNECTIONS] [-l MAX_LINKS] [-pu USER] [-pp PASS] [-pa ADDRESS] [-pn PORT]
                    [--cookie COOKIE] [--user-agent USER_AGENT] [--cookie-file FILE] [--persistent-cache]
                    [--volatile-cache] [-a PLUGIN:KEY=VALUE] [-e PLUGIN] [-d PLUGIN] [--max-concurrent N]
                    [--plugin-timeout N] [--plugins-folder PATH]
                    COMMAND [TARGET [TARGET ...]]
golismero.py: error: too few arguments

Use -h to see the quick help, or --help to show the full help text.

EOF
);
assertVersion "$assertCmd" "$assertVal";



# grabber, expected X Display???



assertCmd="halberd --version";
assertVal=$(cat <<'EOF'
halberd 0.2.4 (14-Aug-2010)

Copyright (C) 2004, 2005, 2006, 2010  Juan M. Bello Rivas <jmbr@superadditive.com>

This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

EOF
);
assertVersion "$assertCmd" "$assertVal";



# hexorbase, requires X Display server...



assertCmd="httptunnel_client -version";
assertVal=$(cat <<'EOF'
HTTPTunnel Client 1.2.1 (c) 2010 Sebastian Weber <webersebastian@yahoo.de>
usage: httptunnel_client.pl [<configfile>] [--debug] [--<param>=<value> ...]
EOF
);
assertVersion "$assertCmd" "$assertVal";



assertCmd="/usr/sbin/apache2ctl -v";
assertVal=$(cat <<'EOF'
Server version: Apache/2.4.10 (Debian)
Server built:   Aug 28 2015 16:28:08
EOF
);
assertVersion "$assertCmd" "$assertVal";













assertCmd="/usr/sbin/apache2ctl -v";
assertVal=$(cat <<'EOF'
Server version: Apache/2.4.10 (Debian)
Server built:   Aug 28 2015 16:28:08
EOF
);
assertVersion "$assertCmd" "$assertVal";