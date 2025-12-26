- # Secure Isolated SFTP Environment with Shared Folder and Automatic Group-Based Access

- ## Overview
- This project demonstrates a secure, isolated SFTP environment where multiple users share a single folder.
- Adding new users is simple and automatic, with no shell access outside the shared resource.

- ## Key Points
- Users can only access the shared folder (`/data/shared`)
- SFTP-only access (no shell commands)
- Permissions are assigned automatically via group membership
- Setgid and sticky bit maintain file consistency


- -------------


- ## Step 1. Create SFTP Group
- ```bash
- sudo groupadd sftpgroup
- ```

- ## Step 2. Create Shared Folder
- ```bash
- sudo mkdir -p /data/shared
- sudo chown root:sftpgroup /data/shared
- sudo chmod 3770 /data/shared
- ```
- **Notes:**
- Setgid: new files inherit group ownership
- Sticky bit: users cannot delete other users’ files


- ## Step 3. Apply ACL Permissions
- ```bash

- # Immediate access for current members
- sudo setfacl -m g:sftpgroup:rwx /data/shared
- 
- # Automatic access for new files and folders
- sudo setfacl -d -m g:sftpgroup:rwx /data/shared
- ```

- ## Step 4. Create Chroot Environment
- ```bash

- sudo mkdir -p /sftp/share
- sudo chown root:root /sftp /sftp/share
- sudo chmod 755 /sftp /sftp/share
- sudo mount --bind /data/shared /sftp/share


- **Notes:**
- Users are restricted to `/sftp/share`
- Chroot directories must be owned by root
- No per-user directories are required

- ### 4.1 Permanent Bind Mount for Shared Folder
- Edit `sudo nano /etc/fstab` and add:
- /data/shared   /sftp/share   none   bind   0 0
- ```

- ## Apply immediately change with no OS reboot:

- sudo mount -a


- **Notes:**
- Ensures /data/shared is always available inside /sftp/share after reboot
- No additional configuration is needed for new users


- ## Step 5. Configure SSH for SFTP-Only
- Edit `sudo nano /etc/ssh/sshd_config`: 
 
-## add the following text to this file:

  Subsystem sftp internal-sftp
 
 
    Match Group sftpgroup
 
       ChrootDirectory /sftp
       ForceCommand internal-sftp
       AllowTcpForwarding no
       X11Forwarding no
       PermitTTY no

- # ctrl+s , ctrl+x: save & exit

- sudo sshd -t 
- sudo systemctl restart ssh
- ```

- ## Step 6. Test Access
- ```bash
- sftp user1@localhost
- sftp user2@localhost
- ```


-**Result**:
- **Users can:** `ls, get, put, mkdir, rename, rm (own files)`
- **Users cannot:** Access shell, access the rest of the filesystem


- ```-------


## These six steps fully prepare the environment for use, and additional steps can be followed later if needed.  
----------------------------------------


- ## 7. Add New Users in the Future if needed
- sudo useradd -m -s /usr/sbin/nologin newuser
- sudo passwd newuser
- sudo usermod -aG sftpgroup newuser
- ```

- ✅ Access is granted automatically via ACL. No further configuration needed.




- ### Security Notes
- Single shared resource for all SFTP users
- Group-based permission model (Permissions controlled by group membership and ACL)
- Chroot isolation (clients have only access the shared sources)
- Sticky bit & setgid prevent accidental deletion and enforce group consistency
- Adding new users is simple: just add them to sftpgroup.
