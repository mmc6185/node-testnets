# <h1 align="center">Source protocol testnet</h1>

![source](https://user-images.githubusercontent.com/73015593/185471712-a54652ec-9421-4a60-98e4-e0db7a63ddc5.jpg)

## Sistem gereksinimleri
```
8GB RAM
200 GB SSD
4 vCPU
```

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
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```


## Go kurulumu yapıyoruz.
```
cd $HOME
wget -O go1.18.2.linux-amd64.tar.gz https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz && rm go1.18.2.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export GO111MODULE=on' >> $HOME/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bashrc && . $HOME/.bashrc
go version
```

## Source protocol'un github dosyasını Source-Protoco repository'den sunucumuza klonluyoruz
```
git clone -b testnet https://github.com/Source-Protocol-Cosmos/source.git
```

## Yazılımı kuruyoruz
```
cd ~/source
make install
```

## initialize (başlatma) işlemini yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
sourced init NodeName --chain-id SOURCECHAIN-TESTNET
```

## genesis.json dosyasını indiriyoruz.
```
curl -s  https://raw.githubusercontent.com/Source-Protocol-Cosmos/testnets/master/sourcechain-testnet/genesis.json > ~/.source/config/genesis.json
```

## Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır) 
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.source/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.source/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.source/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.source/config/app.toml
```

## İndexer kapatıyoruz (Disk kullanımını düşürür) 
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.source/config/config.toml
```

## Servis dosyası oluşturup node'umuzu başlatıyoruz
```
echo "[Unit]
Description=Source-protocol Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which sourced) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/sourced.service
sudo mv $HOME/sourced.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable sourced
sudo systemctl restart sourced
```










