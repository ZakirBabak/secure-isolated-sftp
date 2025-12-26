# Secure Isolated SFTP Environment with Shared Folder and Automatic Group-Based Access

## Overview
This project demonstrates a secure, isolated SFTP environment where multiple users share a single folder.
Adding new users is simple and automatic, with no shell access outside the shared resource.

## Key Features
- Users can only access a single shared folder (`/data/shared`)
- SFTP-only access (no shell)
- Automatic permission assignment via group membership
- Uses ACL, setgid, and sticky bit for secure collaboration

## Intended Use
This setup is designed for real-world environments where:
- Users must not access the full system
- A shared resource is required
- New users are added frequently with minimal administrative effort

📄 For full setup instructions, see:  
`docs/Secure_Isolated_SFTP_Environment.md`


## Optional Automation Script

A ready-to-use script is available to quickly set up the secure SFTP environment:

`Secure-Isolated-SFTP/scripts/setup_sftp.sh`

> ⚠️ Note: To run this script on your system, download it and make it executable:
> 
> ```bash
> chmod +x Secure-Isolated-SFTP/scripts/setup_sftp.sh
> ./Secure-Isolated-SFTP/scripts/setup_sftp.sh
> ```
## What the script does:
Sets up the SFTP infrastructure, not users. It automatically:
Creates an SFTP group: sftpgroup
Creates a secure shared directory:
/data/shared
Owned by root: sftpgroup
Proper permissions and ACLs applied
Creates a chrooted SFTP environment:
/ sftp
/ sftp/share
Bind-mounts /data/ shared to / sftp/share
Adds a persistent mount entry to /etc/fstab
Configures sshd for SFTP-only access using internal-sftp
Restricts users in sftpgroup :
No SSH shell
No port forwarding
No XII
No TTY
Restarts the SSH service
## What the script does NOT do:
For security and flexibility reasons, the script does not:
Create system users
Set user passwords
Grant admin or full SSH access
## Required manual steps (after running the script)
Create SFTP-onIy users manually:
sudo useradd -m -G sftpgroup -s /usr/sbin/nologin sftpuser
sudo passwd sftpuser
## Test access:
sftp sftpuser@SERVER_IP
## Expected:
SFTP access works
SSH shell access is denied
