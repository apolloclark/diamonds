# Diamonds

Would you like to build Kali Linux 2.0 from source? Want to run it on Amazon?
How about making it easy for your dev team to run those same tests? Want to see
it on your iPad or iPad Mini? I sure would, so I made it happen! :)

Kali Linux is an open-source Linux distribution, intended for security
penetration testing and audits. It is based on Debian Jessie 64-bit, using
Gnome 3 desktop (available in other flavors), with a wealth of security tools.
You can select from various meta-packages:

- kali-linux-top10     3.5 GB, Top 10 tools
- kali-linux-full      9 GB, default
- kali-linux-all       15 GB, kitchen sink
- kali-linux-forensic  3.1 GB
- kali-linux-gpu       4.8 GB
- kali-linux-pwtools   6.0 GB
- kali-linux-rfid      1.5 GB
- kali-linux-sdr       2.4 GB
- kali-linux-voip      1.8 GB
- kali-linux-web       4.9 GB
- kali-linux-wireless  6.6 GB



## Installation

Do the "Platform Specific Install" steps, then do the "General Install" steps.

Windows:
- update Powershell, https://www.microsoft.com/en-us/download/details.aspx?id=48729
- install puTTY
- install puTTYgen
- install TightVNCViewer
- install Cygwin

Mac / Linux:
- install vnc viewer

General Install:
- install, configure AWS-CLI
- configure your AWS default security group to allow SSH access to your IP
- install Virtualbox (optional)
- install Vagrant
- install vagrant plugins
```Shell
vagrant plugin install vagrant-aws
vagrant plugin install vagrant-vbguest
```
- add Vagrant dummy box:
```Shell
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```
- git clone this repo
```Shell
git clone https://github.com/apolloclark/diamonds
```
- choose which version of Kali you want (cli vs. gui)
- choose which meta-package you want
- update the "aws-config.yml" with your AWS credentials and settings
- on the console, cd into the folder, ex:
```Shell
cd ./vagrant-kali/gui/kali-linux-web
```
- start vagrant, for a local instance, using Virtualbox:
```Shell
vagrant up
```
- start vagrant, for a remote instance, on Amazon:
```Shell
vagrant up --provider=aws
```
- sit back (for like 30+ min sometimes...)
- Enjoy!



## Can I VNC into this?

Yes you can! It has Vino VNC server installed, but you'll need to use an SSH
tunnel. I normally would have gone with TightVNC, but Vino is the only VNC
server that supports Gnome 3.14. However, Vino only supports a new version of TLS,
which very few VNC clients support. So, I disabled Vino encryption (I know!),
but set it up to only listen to local connections on the "lo network" /
localhost / loopback interface. This means it's not exposed to the internet.
To access it, you'll need to SSH into the Kali instance. Luckily, a lot of the
better quality VNC clients support this. Security of SSH, convenience of VNC,
BOOM!

Windows:
- convert your AWS private key to a puTTY format, using puTTYgen
    https://github.com/Varying-Vagrant-Vagrants/VVV/wiki/Connect-to-Your-Vagrant-Virtual-Machine-with-PuTTY
- open puTTY, setup a port forwarding for VNC, port 5900
    http://helpdeskgeek.com/how-to/tunnel-vnc-over-ssh/
- open TightVNC
- login to the VNC instance, at 127.0.0.1:5900

Mac / Linx:
- ssh into the Kali instance, setting up an SSH tunnel, ex:
```Shell
ssh -nNT -L 5900:127.0.0.1:5900 admin@<ec2-dns> -i <aws_key_file>
```
- login to the VNC instnace, at 127.0.0.1:5900



## Dependencies ##

### Vagrant
https://www.vagrantup.com/
Vagrant is an open-source DevOps tool for deployment automation, supporting:
local deploys to Virtualbox, VMWare, vSphere, and many others; cloud services
such as AWS, Rackspace, and Azure; and Linux Containers such as Docker. It
includes support for a variety of build tools: raw Bash, Chef, Puppet, Ansible,
Salt, etc.

### Gauntlt
https://github.com/gauntlt/gauntlt

Gauntlt is a security scan automation tool. It's written in Ruby (Golang
rewrite in progress!), uses a standard Cucumber format script to let you write
QA style tests with pre-conditions, tests, and assertions. The tests call
down to the command-line. If you can run a security tool on the command line,
you can call it with Gauntlt, and do assertions against the output to verify
the results. The test results are output in Cucumber format, which can be seen
in Jenkins using a plugin.

### Jenkins
https://jenkins-ci.org/
https://wiki.jenkins-ci.org/display/JENKINS/Cucumber+Test+Result+Plugin
Jenkins is a build automation tool, originally developed for creating Java apps.
It has expanded to support many languages, and give easy reporting. Jenkins
Build Jobs can be run manually, or on a schedule, and supports a wide range of
plugins to enable: code quality checks (linting, cyclometric complexity,
unit testing, code coverage), performance testing, stress testing, alerts
(email, sms, IRC, HipChat, etc.), and reporting.

### Summary
Kali is great for running security tests (but lacks automation and reporting),
Gauntlt is great for running tests (but lacks a full tool suite and reporting),
Jenkins is great for automation and reporting (but lacks test running, and
security tools). None of them deal with deployment to centralized servers in
the cloud, making collaboration amongst a team diffcult. I originally built
this Vagrant + Kali + Gauntlt + Jenkins setup locally, but only recently was
able to deploy it to AWS (with much difficulty).



## What is this thing doing?

Under the covers, this thing is just creating a virtual machine, spinning up
a fresh Debian Jessie instance, and running some Bash scripts. In more detail:
Vagrant sets up a virtual machine with resources (CPU, memory, harddrive,
networking, fileshares, etc.), dwnloads a Debian Jessie basebox image,
runs some Bash scripts, pulls down meta-packages from the Kali repo, installs
everything, and you got a fresh Kali instance.



## FAQ

### This is awesome!

Not a question, but thanks! :)

### Yo shit broke!

Again, not a question, but let me know. Best place is here on Github, open a
ticket, and be VERY detailed with your exact setup, send me screenshots. * If I
can't reproduce your problem, I won't be able to fix it. *

- Run the Vagrant command, add "--debug" at the end, include the output
- Which VNC client are you using, version?
- How are you establishing the SSH tunnel, program, version?

Run these commands and include the results in your ticket:

All Systems:
```Shell
vagrant version
vagrant plugin list
vboxmanage --version
ssh -v localhost
aws --version
aws ec2 describe-tags
```

Windows:
```Shell
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
powershell $PSVersionTable
```

Mac:
```Shell
sw_vers
xcode-select -p
gcc --version
echo $SHELL
echo $BASH
bash --version
```

Linux:
```Shell
uname -a
echo $SHELL
echo $BASH
bash --version
```

If you do ALL of this, I may be able to help you, no guarantees. It may
take a few weeks, unless you want to hire me as a consultant.

### Can you remove the SSH tunnel for VNC?

You can, but I chose not to, because it would be insecure. You could use a
different VNC server, but would lose access to the Kali default Gnome 3.14
desktop.

### Why did you call it "Diamonds"?

I chose that name purely so I can go up to people at Defcon and ask them:
"Have you ever used Kal in the cloud with diamonds?"

### Do you work for Offensive Security?

Not yet. I'm still waiting on that owl to deliver my letter...

### Can you build this for Azure?

It's not at the top of my list, but I'll think about it.

### Do you do consulting?

Yessir! You can email me: apolloclark@gmail.com

