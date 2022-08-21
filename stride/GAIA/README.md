<h1 align="center">Gaia testnet</h1>

<img width="300" height="200"  alt="stride" src="https://user-images.githubusercontent.com/73015593/185782593-a32e1014-4c8f-4880-9996-2a4e11712e77.svg">  


## Minimum Sistem gereksinimleri
```
8GB RAM
200 GB SSD
4 vCPU
```

# Node kurulumu

## root yetkisi kazanıyoruz:
```
sudo su
```

## root dizinine gidiyoruz:
```
cd /root
```

## Sistem güncellemesi yapıyoruz:
```
sudo apt update && sudo apt upgrade -y
```
![image](https://user-images.githubusercontent.com/73015593/180210944-05db38d1-2ae0-481d-bf67-ca37fd66e6ad.png)


## Kütüphane kurulumu yapıyoruz:
```
sudo apt install curl tar wget clang pkg-config libssl-dev libleveldb-dev jq build-essential bsdmainutils git make ncdu htop screen unzip bc fail2ban htop -y
```
![image](https://user-images.githubusercontent.com/73015593/180211995-0aab628b-4aa8-4b72-86f4-984e82124754.png)

## Go kurulumu yapıyoruz.
```
wget https://golang.org/dl/go1.18.1.linux-amd64.tar.gz; \
rm -rv /usr/local/go; \
tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz && \
rm -v go1.18.1.linux-amd64.tar.gz && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile && \
source ~/.bash_profile
```
![image](https://user-images.githubusercontent.com/73015593/180212350-73872b03-c465-4c07-9674-fdc008df2782.png)

## Go sürümünü kontrol ediyoruz.
```
go version
```
![image](https://user-images.githubusercontent.com/73015593/180212446-024cc343-b406-49e3-8922-9f647259289c.png)
  
## Binary kurulumunu yapıyoruz.
```
cd $HOME
git clone https://github.com/Stride-Labs/gaia.git
cd gaia
git checkout 5b47714dd5607993a1a91f2b06a6d92cbb504721
make build
sudo cp $HOME/gaia/build/gaiad /usr/local/bin
```

## initialize (başlatma) işlemi yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
gaiad init NodeName --chain-id GAIA
```

## genesis.json ve addrbook.json dosyalarını indiriyoruz.























  
  
  
  
