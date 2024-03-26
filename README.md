# dev-env
---
a portable development environment

### installation

clone:
```
git clone git@github.com:0xdead8ead-randori/dev-env.git ~/.dev-env
```

build container:
```
(cd $HOME/.dev-env/ && ./build.sh)
```

set and alias in your `~/.zshrc` or `~/.bashrc`:
```
alias dev-env="$HOME/.dev-env/launch-dev-env.sh"
```

add a `Host` entry to your `~/.ssh/config`:
```
Host dev-env.local
    Hostname 127.0.0.1
    Port 2222
    User dead8ead
    StrictHostKeyChecking no
    IdentityFile "~/.ssh/1p_dev-env.local.pub"
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    ForwardAgent yes
```
note: your identy agent path and pub key path may be different, adjust accordingly

### running `dev-env`

if you set an alias, as above, simply run
```
dev-env
```

then, ssh into the machine:
```
ssh dev-env.local
```




