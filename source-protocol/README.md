# <h1 align="center">Source protocol testnet</h1>

![source](https://user-images.githubusercontent.com/73015593/185471712-a54652ec-9421-4a60-98e4-e0db7a63ddc5.jpg)

## Sistem gereksinimleri
```
4GB RAM 
250GB SSD  
1.4 GHz amd64 CPU
```

# Linkler
> ## [Discord](https://discord.gg/Qv2KM2hu)<br>
> ## [Source protocol website](https://www.sourceprotocol.io/)

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
wget -O $HOME/.source/config/genesis.json "https://raw.githubusercontent.com/mmc6185/node-testnets/main/source-protocol/genesis.json"
```

## addrbook.json dosyasını indiriyoruz.
```
wget -O $HOME/.source/config/addrbook.json "https://raw.githubusercontent.com/mmc6185/node-testnets/main/source-protocol/addrbook.json"
```

## seed ekliyoruz
```
SEEDS="6ca675f9d949d5c9afc8849adf7b39bc7fccf74f@164.92.98.17:26656"
PEERS=""
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.source/config/config.toml
```

## Minimum gas prices ayarlıyoruz.
```
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.00125usource\"/" $HOME/.source/config/app.toml
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

## Peer ekliyoruz.
```
sed -i.bak 's/persistent_peers =.*/persistent_peers = "6ca675f9d949d5c9afc8849adf7b39bc7fccf74f@164.92.98.17:26656"/' $HOME/.source/config/config.toml
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

## Cüzdan oluşturuyoruz.walletName kısmına kendi cüzdan ismimizi yazıyoruz.
```
sourced keys add walletName
```
![image](https://user-images.githubusercontent.com/73015593/185483573-fd3394fc-22c7-40dd-b478-da26ad9ac420.png)

## [Source protocol discord](https://discord.gg/Qv2KM2hu)'una gidiyoruz. #faucet kanalından token talep ediyoruz. 
![image](https://user-images.githubusercontent.com/73015593/185483005-84c8f28f-c154-486c-8388-668e3f89550e.png)

## Validator oluşturuyoruz. (NodeName kısmına validator ismimizi yazıyoruz.WalletName kısmına cüzdan ismimizi yazıyoruz.)
```

sourced tx staking create-validator \
--amount=950000usource \
--pubkey=$(sourced tendermint show-validator) \
--moniker=forgottensemicolon \
--chain-id=sourcechain-testnet \
--commission-rate="0.10" \
--commission-max-rate="0.20" \
--commission-max-change-rate="0.1" \
--min-self-delegation="1" \
--from=forgottensemicolon \
--fees=5000usource \
-y
```

# Explorer [linki](https://explorer.testnet.sourceprotocol.io/)
![image](https://user-images.githubusercontent.com/73015593/185793407-01ce742c-7472-4ed7-8be2-79a142299e49.png)

# Eşleşme sorunu yaşayanlar için SAKURA#0129 hazırladığı [snapshot](https://github.com/obajay/StateSync-snapshots/blob/main/Source/README.md)

# Yararlı komutlar

## Logları izlemek için
```
journalctl -fu sourced -o cat
```
## Servis başlatmak için
```
systemctl start sourced
```
## Servis durdurmak için
```
systemctl stop sourced
```
## Servis tekrar başlatmak için
```
systemctl restart sourced
```
## Sync durumuna bakmak için
```
sourced status 2>&1 | jq .SyncInfo
```
## Cüzdandaki token miktarını sorgulama komutu
```
sourced query bank balances walletAddress
```
## Cüzdandaki token miktarı sorgulama komutu
```
sourced query bank balances walletname
```







