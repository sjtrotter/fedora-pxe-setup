# fedora-pxe-setup
Setup repository for a Fedora PXE server.

Loosely based on [Fedora PXE Setup](https://docs.fedoraproject.org/en-US/fedora/latest/install-guide/advanced/Network_based_Installations/#pxe-overview).

Files: 
- Initial Server SOP (word doc detailing requirements for server and step-by-step instructions for initial setup)
- pxe-setup.yml (ansible script that configures the server)
- dhcpd.conf (template for ansible script to setup dhcp server)
- default (template for ansible script for bios menu)
- grub.cfg (template for ansible script for uefi menu)
- License

# flow of pxe-setup.yml

the ansible script will download needed components for the server (httpd, dhcp-server, tftp-server) and then syslinux and grub-x64. It copies the relavant files from the latter two packages into /var/lib/tftpboot, the pxe server directory. it then downloads the kernel and initrd. afterward it writes a new repo file for the Everything branch of the fedora mirror, which will allow installations local not requiring internet; it then syncs the repo. ** this takes a long time, it is about 85 GB ** after syncing the repo, it writes the template config files to the relevant locations and then opens the firewall to allow the services to be accessible, and starts/restarts and enables the services.
