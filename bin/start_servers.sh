for server in `cat servers.txt`; do ssh -i Dropbox/NetVersa2.pem ubuntu@$server 'ps auxww | grep unicorn'; done
