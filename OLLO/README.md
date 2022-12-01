# <h1 align="center">Ollo testnet 0</h1>
![image](https://user-images.githubusercontent.com/73015593/192774410-4ec47e6f-6b78-4cbb-9d5f-6494d0c2b309.png)

# Hetzner'de 20 Euro bonus [Link](https://hetzner.cloud/?ref=vtZTtbpG2Vcn)   

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
![image](https://user-images.githubusercontent.com/73015593/192775373-bd156902-f709-4beb-9393-37ab4cac5b9c.png)


## OLLO'nun github dosyasını OLLO repository'den sunucumuza klonluyoruz
```
git clone https://github.com/OllO-Station/ollo.git
```

## Binary kurulumunu yapıyoruz.
```
cd $HOME/ollo
make install
```
![image](https://user-images.githubusercontent.com/73015593/192775577-8aa8be14-41dc-4897-a82f-951550d886e4.png)


## initialize (başlatma) işlemini yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
ollod init NodeName --chain-id ollo-testnet-0
```

## Genesis dosyasını indiriyoruz:
```
curl https://raw.githubusercontent.com/OllO-Station/ollo/master/networks/ollo-testnet-0/genesis.json | jq .result.genesis > $HOME/.ollo/config/genesis.json
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

## Peer ekliyoruz
```
SEEDS=""
PEERS="2a8f0fada8b8b71b8154cf30ce44aebea1b5fe3d@145.239.31.245:26656,1173fe561814f1ecb8b8f19d1769b87cd576897f@185.173.157.251:26656,489daf96446f104d822fae34cd4aa7a9b5cebf65@65.21.131.215:26626,f43435894d3ae6382c9cf95c63fec523a2686345@167.235.145.255:26656,2eeb90b696ba9a62a8ad9561f39c1b75473515eb@77.37.176.99:26656,9a3e2725e02d1c420a5d500fa17ce0ef45ddc9e8@65.109.30.117:29656,91f1889f22975294cfbfa0c1661c63150d2b9355@65.108.140.222:30656,d38fcf79871189c2c430473a7e04bd69aeb812c2@78.107.234.44:16656,f795505ac42f18e55e65c02bb7107b08d83ad837@65.109.17.86:37656,6368702dd71e69035dff6f7830eb45b2bae92d53@65.109.57.161:15656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.ollo/config/config.toml
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
sudo mv $HOME/ollod.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable ollod
sudo systemctl restart ollod
journalctl -u ollod -f -o cat
```
![image](https://user-images.githubusercontent.com/73015593/192783155-a9a2209e-0058-4435-86a7-7da9aa55f89f.png)

## Sync kontrolü için aşağıdaki komutu gireriz. sync olmak için catching_up : false çıktısı almamız lazım.
```
ollod status 2>&1 | jq .SyncInfo
```

## Cüzdan oluşturmak için walletName kısmına kendi cüzdan isminizi yazın. Sonrasında çıkan mnemonic(24 kelime) bilgisini kaydedin (Yeni cüzdan oluşturacaklar için)
```
ollod keys add walletName
```
![tempsnip](https://user-images.githubusercontent.com/73015593/192776519-0ae7bfd9-a030-4422-8a17-0d2b53c46b77.png)

## Token almak için [Disord](https://discord.gg/9hKbCb87) kanalına gidiyoruz.
* Roles kanalından Testnet Explorers rolünü alıyoruz.
* testnet-faucet kanalından `!request TARGET-ADDRESS-HERE` Biçiminde token talep ediyoruz.
![image](https://user-images.githubusercontent.com/73015593/192783010-ecf5d35a-ef91-412f-b2f5-7b25754d30e1.png)
![image](https://user-images.githubusercontent.com/73015593/192783083-1e08730b-d2f7-473a-a6b4-5aa6aa7034ea.png)

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

# STATE - SYNC Kurmak isteyenler için [LINK](https://www.theamsolutions.info/ollo)

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


