## Golang App Proxy

Create and provision one Nginx proxy server and two App servers using *Vagrant* and *Chef Solo*.
Emulate Jenkins fuctionality using ssh between VMs
to update the source code and deploy the new app version.

## Requirements

* VirtualBox
* Vagrant
* Curl

## Execution

./deploy.sh

1. Create VMs.
2. Test nginx load balancing.
3. Enable ssh key based authentication.
4. Trigger post-commit hook.
5. Display updated response from the app servers.

## Testing Environment

Ubuntu 14.04 running VirtualBox 5.0.20 and Vagrant 1.8.1.

## License

Apache v2.0 
