# <h1 align="center">Ollo testnet 0</h1>
![image](https://user-images.githubusercontent.com/73015593/192774410-4ec47e6f-6b78-4cbb-9d5f-6494d0c2b309.png)

# [KJNODES](https://github.com/kj89/testnet_manuals/tree/main/ollo)'DEN ÇEVRİLMİŞTİR

# Linkler
> ## [Discord](https://discord.gg/9hKbCb87)<br>
> ## [Ollo network website](https://station8.zone/)
> ## [Ollo testnet 0 explorer](https://explorer.kjnodes.com/ollo)

## Sistem gereksinimleri
```
8GB RAM
200 GB SSD
4 vCPU
```

# Node kurulumu

## Sistem güncellemesi yapıyoruz:
```
sudo apt update && sudo apt upgrade -y
```

## Kütüphane kurulumu yapıyoruz:
```
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```

## Go kurulumu yapıyoruz:
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

## OLLO'nun github dosyasını OLLO repository'den sunucumuza klonluyoruz
```
git clone https://github.com/OllO-Station/ollo.git
```

## Binary kurulumunu yapıyoruz.
```
cd $HOME/ollo
git checkout 1.1.2beta-internal
make install
```

## initialize (başlatma) işlemini yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
ollod init NodeName --chain-id ollo-testnet-0
```

## Eski cüzdanımızı recover ediyoruz.
```
ollod keys add WalletName --recover
```

## Genesis dosyasını indiriyoruz:
```
wget -O $HOME/.ollo/config/genesis.json "https://raw.githubusercontent.com/OllO-Station/ollo/master/networks/ollo-testnet-0/genesis.json"
```

## Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır) 
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.ollo/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.ollo/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.ollo/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.ollo/config/app.toml
```

## İndexer kapatırız (Disk kullanımını düşürür) 
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.ollo/config/config.toml
```

## Servis dosyası oluşturup node'umuzu başlatıyoruz
```
echo "[Unit]
Description=Ollod Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which ollod) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/ollod.service
sudo mv $HOME/seid.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable ollod
sudo systemctl restart ollod
```

## Sync kontrolü için aşağıdaki komutu gireriz. sync olmak için catching_up : false çıktısı almamız lazım.
```
ollod status 2>&1 | jq .SyncInfo
```

## Cüzdan oluşturmak için walletName kısmına kendi cüzdan isminizi yazın (Yeni cüzdan oluşturacaklar için)
```
ollod keys add walletName
```

## Validator oluşturuyoruz. 
* NodeName kısmına kendi node ismimizi.
* WalletName kısmına ise cüzdan ismimizi giriyoruz 

```
ollod tx staking create-validator \
--moniker="NodeName" \
--amount=1000000utollo \
--gas auto \
--fees=5000utollo \
--pubkey=$(ollod tendermint show-validator) \
--chain-id=ollo-testnet-0 \
--commission-max-change-rate=0.01 \
--commission-max-rate=0.20 \
--commission-rate=0.10 \
--min-self-delegation=1 \
--from=WalletName \
--yes
```

# Yararlı komutlar

## Logları izlemek için
```
journalctl -u ollod -f -o cat
```
## Servis başlatmak için
```
systemctl start ollod
```
## Servis durdurmak için
```
systemctl stop ollod
```
## Servis tekrar başlatmak için
```
systemctl restart ollod
```
## Sync durumuna bakmak için
```
ollod status 2>&1 | jq .SyncInfo
```
## Cüzdandaki token miktarını sorgulama komutu
```
ollod query bank balances walletAddress
```
## Cüzdandaki token miktarı sorgulama komutu
```
ollod query bank balances walletname
```

## Token transfer etmek için (FIRST_WALLET_ADDRESS kısmına gönderen cüzdanı,SECOND_WALLET_ADDRESS kısmına alıcı cüzdanı, TOKENAMOUNT kısmına göndermek istediğiniz token miktarını giriyoruz.)
```
ollod tx bank send FIRST_WALLET_ADDRESS SECOND_WALLET_ADDRESS TOKENAMOUNTutollo
```

## Delegate komutu 
* ValoperAddress kısmına validator adresimizi.
* TOKENAMOUNT kısmına delege etmek istediğimiz token miktarını giriyoruz.)
```
ollod tx staking delegate ValoperAddress TOKENAMOUNTusei --from=WalletName --chain-id=ollo-testnet-0 --gas=auto
```

## Proposal'da oy vermek için 

* PROPOSALNUMBER proposal numarasını giriyoruz.
* "yes/no" kısmına Oylamadaki fikrimizi giriyoruz.
```
ollod tx gov vote PROPOSALNUMBER yes/no --from WalletName --chain-id=ollo-testnet-0 --gas auto --gas-prices 0.025utollo --gas-adjustment 1.5
```


