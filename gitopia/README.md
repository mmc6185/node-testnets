# <h1 align="center">Gitopia testnet</h1>

![gitopia](https://user-images.githubusercontent.com/73015593/178433708-b32a2f72-8de3-451b-ad6f-52d70b8b924d.jpg)

# Node kurulumu

## root yetkisi kazanıyoruz.
```
sudo su
```

## root dizinine gidiyoruz.
```
cd /root
```

## Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```

## Kütüphane kurulumu yapıyoruz.
```
sudo apt install make clang pkg-config libssl-dev libclang-dev build-essential git curl ntp jq llvm tmux htop screen gcc
```

## Go kurulumu yapıyoruz.
```
ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
```

## Go versiyonunu kontrol ediyoruz.
```
go version
```
![image](https://user-images.githubusercontent.com/73015593/178597973-a9c1d3b6-c0d8-4eeb-8685-20ac0cf91e8a.png)


## gitopia'nın github dosyasını gitopia repository'den sunucumuza klonluyoruz.
```
curl https://get.gitopia.com | bash 
git clone -b v0.13.0 gitopia://gitopia1dlpc7ps63kj5v0kn5v8eq9sn2n8v8r5z9jmwff/gitopia
```



















