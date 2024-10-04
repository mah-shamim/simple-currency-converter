```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
sudo chmod 600 /home/ubuntu/.minikube/profiles/minikube/client.crt /home/ubuntu/.minikube/profiles/minikube/client.key ~/.minikube/ca.crt
sudo chown -R jenkins:jenkins /home/ubuntu/.kube/config
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
sudo -u jenkins minikube status
minikube profile list
sudo chown -R ubuntu:ubuntu /home/ubuntu/.minikube
sudo chmod -R 755 /home/ubuntu/.minikube
minikube delete
sudo chown $USER $HOME/.kube/config && chmod 600 $HOME/.kube/config
minikube start --driver=docker
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube
sudo chmod -R 755 /home/ubuntu/.minikube
sudo chown -R ubuntu:ubuntu /home/ubuntu/.minikube/profiles/minikube
sudo chmod 600 /home/ubuntu/.minikube/profiles/minikube/client.crt /home/ubuntu/.minikube/profiles/minikube/client.key ~/.minikube/ca.crt
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
sudo chmod 600 /home/ubuntu/.minikube/profiles/minikube/client.crt /home/ubuntu/.minikube/profiles/minikube/client.key ~/.minikube/ca.crt
sudo chown -R jenkins:jenkins /home/ubuntu/.kube/config
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
minikube status
minikube update-context
sudo chown $USER $HOME/.kube/config && chmod 600 $HOME/.kube/config
sudo chown -R ubuntu:ubuntu /home/ubuntu/.minikube

ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chmod o+rx /home/ubuntu
sudo chmod o+rx /home/ubuntu/.minikube
sudo chmod o+rx /home/ubuntu/.minikube/profiles
sudo chmod o+rx /home/ubuntu/.minikube/profiles/minikube

ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chmod 644 /home/ubuntu/.minikube/profiles/minikube/client.crt
sudo chmod 644 /home/ubuntu/.minikube/profiles/minikube/client.key
sudo chmod 644 /home/ubuntu/.minikube/ca.crt

ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chown jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube/client.crt
sudo chown jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube/client.key
sudo chown jenkins:jenkins /home/ubuntu/.minikube/ca.crt

ls -l /home/ubuntu/.minikube/profiles/minikube/
```



## When Install was complete then check
```
ls -l /home/ubuntu/.minikube/profiles/minikube/
```

Then Output was (There Type)
Type 1: wrong
```
-rwxr-xr-x 1 ubuntu ubuntu 1411 Oct  4 01:56 apiserver.crt
-rwxr-xr-x 1 ubuntu ubuntu 1411 Oct  4 01:56 apiserver.crt.7fb57e3c
-rwxr-xr-x 1 ubuntu ubuntu 1675 Oct  4 01:56 apiserver.key
-rwxr-xr-x 1 ubuntu ubuntu 1675 Oct  4 01:56 apiserver.key.7fb57e3c
-rw------- 1 ubuntu ubuntu 1147 Oct  4 01:56 client.crt
-rw------- 1 ubuntu ubuntu 1679 Oct  4 01:56 client.key
-rwxr-xr-x 1 ubuntu ubuntu 2766 Oct  4 01:57 config.json
-rwxr-xr-x 1 ubuntu ubuntu 2873 Oct  4 01:57 events.json
-rwxr-xr-x 1 ubuntu ubuntu 1147 Oct  4 01:56 proxy-client.crt
-rwxr-xr-x 1 ubuntu ubuntu 1679 Oct  4 01:56 proxy-client.key
```

Type 2: wrong
```
-rwxr-xr-x 1 ubuntu ubuntu 1411 Oct  4 01:56 apiserver.crt
-rwxr-xr-x 1 ubuntu ubuntu 1411 Oct  4 01:56 apiserver.crt.7fb57e3c
-rwxr-xr-x 1 ubuntu ubuntu 1675 Oct  4 01:56 apiserver.key
-rwxr-xr-x 1 ubuntu ubuntu 1675 Oct  4 01:56 apiserver.key.7fb57e3c
-rw-r--r-- 1 ubuntu ubuntu 1147 Oct  4 01:56 client.crt
-rw-r--r-- 1 ubuntu ubuntu 1679 Oct  4 01:56 client.key
-rwxr-xr-x 1 ubuntu ubuntu 2766 Oct  4 01:57 config.json
-rwxr-xr-x 1 ubuntu ubuntu 2873 Oct  4 01:57 events.json
-rwxr-xr-x 1 ubuntu ubuntu 1147 Oct  4 01:56 proxy-client.crt
-rwxr-xr-x 1 ubuntu ubuntu 1679 Oct  4 01:56 proxy-client.key
```

Type 3: (correct)
```
-rwxr-xr-x 1 ubuntu  ubuntu  1411 Oct  4 01:56 apiserver.crt
-rwxr-xr-x 1 ubuntu  ubuntu  1411 Oct  4 01:56 apiserver.crt.7fb57e3c
-rwxr-xr-x 1 ubuntu  ubuntu  1675 Oct  4 01:56 apiserver.key
-rwxr-xr-x 1 ubuntu  ubuntu  1675 Oct  4 01:56 apiserver.key.7fb57e3c
-rw-r--r-- 1 jenkins jenkins 1147 Oct  4 01:56 client.crt
-rw-r--r-- 1 jenkins jenkins 1679 Oct  4 01:56 client.key
-rwxr-xr-x 1 ubuntu  ubuntu  2766 Oct  4 01:57 config.json
-rwxr-xr-x 1 ubuntu  ubuntu  2873 Oct  4 01:57 events.json
-rwxr-xr-x 1 ubuntu  ubuntu  1147 Oct  4 01:56 proxy-client.crt
-rwxr-xr-x 1 ubuntu  ubuntu  1679 Oct  4 01:56 proxy-client.key
```
