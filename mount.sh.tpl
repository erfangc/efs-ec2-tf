#! /bin/bash
echo "Mounting NFS via command: sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${dns_name}:/ /sharedrive"
sudo mkdir /sharedrive
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${dns_name}:/ /sharedrive