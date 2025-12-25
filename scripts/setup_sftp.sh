#!/bin/bash
# ==================================================
# Secure Isolated SFTP Environment Setup Script
# ==================================================

# 1. Create SFTP Group
sudo groupadd sftpgroup

# 2. Create Shared Folder
sudo mkdir -p /data/shared
sudo chown root:sftpgroup /data/shared
sudo chmod 3770 /data/shared  # setgid + sticky bit

# 3. Apply ACL Permissions
sudo setfacl -m g:sftpgroup:rwx /data/shared         # Immediate access
sudo setfacl -d -m g:sftpgroup:rwx /data/shared     # Default for new files/folders

# 4. Create Chroot Environment
sudo mkdir -p /sftp/share
sudo chown root:root /sftp /sftp/share
sudo chmod 755 /sftp /sftp/share
sudo mount --bind /data/shared /sftp/share

# 4.1 Permanent Bind Mount in /etc/fstab
echo "/data/shared   /sftp/share   none   bind   0 0" | sudo tee -a /etc/fstab
sudo mount -a

# 5. Configure SSH for SFTP-Only
sudo bash -c 'cat >> /etc/ssh/sshd_config << EOF
Subsystem sftp internal-sftp

Match Group sftpgroup
    ChrootDirectory /sftp
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
    PermitTTY no
EOF'

# Restart SSH to apply changes
sudo systemctl restart ssh

echo "✅ Secure Isolated SFTP Environment setup complete!"
echo "Shared folder: /data/shared"
echo "Chroot directory: /sftp/share"
echo "SFTP users should be added to group: sftpgroup"
