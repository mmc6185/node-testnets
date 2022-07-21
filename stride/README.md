# <h1 align="center">Stride Testnet</h1>

![stride](https://user-images.githubusercontent.com/73015593/180210525-c011f584-ccd8-464f-8bc3-48b97dade2b4.jpg)


## Sistem gereksinimleri
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

## stride'ın github dosyasını stride repository'den sunucumuza klonluyoruz.
```
git clone https://github.com/Stride-Labs/stride.git
```
![image](https://user-images.githubusercontent.com/73015593/180214410-ae44e2a4-1c36-4424-a62f-de8c7ff4518c.png)

## Binary kurulumunu yapıyoruz.
```
cd stride
git checkout c53f6c562d9d3e098aab5c27303f41ee055572cb
make build
sudo cp $HOME/stride/build/strided /usr/local/bin
```
![image](https://user-images.githubusercontent.com/73015593/180217544-a200d561-8826-436d-a61a-048a18b34c00.png)

## initialize (başlatma) işlemi yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
strided init NodeName --chain-id STRIDE-1
```
![image](https://user-images.githubusercontent.com/73015593/180220598-10b6ba64-b847-46cc-ae5d-e7580a35c28d.png)

## Cüzdan oluşturuyoruz.key-name kısmına kendi cüzdan ismimizi giriyoruz. (Tüm bilgileri kaydetmeyi unutmayın)
```
strided keys add key-name
```
![wallet](https://user-images.githubusercontent.com/73015593/180227470-b8e3d8cc-e876-4b40-8132-3326347e6ca6.PNG)

## Genesis dosyasını indiriyoruz.
```
cd $HOME/.stride/config
wget -O genesis.json "https://raw.githubusercontent.com/Stride-Labs/testnet/main/poolparty/genesis.json"
```
![image](https://user-images.githubusercontent.com/73015593/180229869-3521bbba-b2a9-4d80-a32c-02c5a2f71ea5.png)


## (opsiyonel) Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır)  
```
pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="10" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.stride/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.stride/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.stride/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.stride/config/app.toml
```

## İndexer kapatırız (Disk kullanımını düşürür)
```
indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.stride/config/config.toml
```

## minimum-gas-prices ayarlıyoruz
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0ustrd\"/;" ~/.stride/config/app.toml
```

## Peer ve seed ayarlıyoruz.
```
external_address=$(wget -qO- eth0.me) 
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/.stride/config/config.toml

peers=""
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.stride/config/config.toml

seeds="baee9ccc2496c2e3bebd54d369c3b788f9473be9@seedv1.poolparty.stridenet.co:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.stride/config/config.toml

sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 100/g' $HOME/.stride/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 100/g' $HOME/.stride/config/config.toml
```

## Addrbook.json dosyasını indiriyoruz.
```
wget -O $HOME/.stride/config/addrbook.json "https://raw.githubusercontent.com/obajay/nodes-Guides/main/Stride/addrbook.json"
```

##























































