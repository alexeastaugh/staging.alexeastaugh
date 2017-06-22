# staging.alexeastaugh.com

Testing environment and still a work in progress.

Requirements

- Vagrant
- Virtulbox

How To

- Install the requirements
- Clone repo
- Update `/etc/hosts file` with `127.0.0.1  staging.alexeastaugh.com`
- Add database password to `db_bootstrap.sh` and `config.js`
- Place ghost.dump in root of repo
- Run `vagrant up` from inside the repo dir
- Connect to `staging.alexeastaugh.com:8080` in your browser

