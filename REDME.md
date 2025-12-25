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
