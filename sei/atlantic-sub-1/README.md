# <h1 align="center">Sei atlantic-1 subchain-1</h1>

![sei](https://user-images.githubusercontent.com/73015593/187335052-f2e42262-705a-4381-b90f-502d8d007f4e.png)

# Hetzner'de 20 Euro bonus [Link](https://hetzner.cloud/?ref=vtZTtbpG2Vcn)   

# Linkler
> ## [Discord](https://discord.gg/3E4MGvvr)<br>
> ## [Sei network website](https://www.seinetwork.io/)
> ## [atlantic-sub-1 explorer](https://testnet-explorer.brocha.in/sei%20atlantic-sub-1)

## Sistem gereksinimleri
```
32GB RAM
1 TB SSD
8 vCPU
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

## Sei'nin github dosyasını sei repository'den sunucumuza klonluyoruz
```
git clone https://github.com/sei-protocol/sei-chain
```

## Binary kurulumunu yapıyoruz.
```
cd $HOME/sei-chain
git checkout 1.1.2beta-internal
make install
```

## initialize (başlatma) işlemini yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
seid init NodeName --chain-id atlantic-sub-1
```

## Eski cüzdanımızı recover ediyoruz.
```
seid keys add WalletName --recover
```

## Genesis dosyasını indiriyoruz:
```
wget -O $HOME/.sei/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/atlantic-subchains/atlantic-sub-1/genesis.json"
```

## Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır) 
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei/config/app.toml
```

## İndexer kapatırız (Disk kullanımını düşürür) 
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.sei/config/config.toml
```

## Servis dosyası oluşturup node'umuzu başlatıyoruz
```
echo "[Unit]
Description=Seid Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which seid) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/seid.service
sudo mv $HOME/seid.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable seid
sudo systemctl restart seid
```

## Sync kontrolü için aşağıdaki komutu gireriz. sync olmak için catching_up : false çıktısı almamız lazım.
```
seid status 2>&1 | jq .SyncInfo
```

## Cüzdan oluşturmak için walletName kısmına kendi cüzdan isminizi yazın (Yeni cüzdan oluşturacaklar için)
```
seid keys add walletName
```

## Sync tamamlandıktan sonra validator oluşturabilmek için [Form](https://docs.google.com/spreadsheets/d/15reUshGJ4P3oS9kesCg9jO2M1zTsUE34TC8X11Sp2mA/edit#gid=0)'a gidiyoruz.Validator adresimizi ve cüzdan adresimizi giriyoruz.
![image](https://user-images.githubusercontent.com/73015593/187340619-0a5f720e-94a9-41d5-84df-22ee07cd2416.png)

## Validator oluşturuyoruz. NodeName kısmına kendi node ismimizi.WalletName kısmına ise cüzdan ismimizi giriyoruz 
```
seid tx staking create-validator \
--moniker="NodeName" \
--amount=1000000usei \
--gas auto \
--fees=5000usei \
--pubkey=$(seid tendermint show-validator) \
--chain-id=atlantic-sub-1 \
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
journalctl -fu seid -o cat
```
## Servis başlatmak için
```
systemctl start seid
```
## Servis durdurmak için
```
systemctl stop seid
```
## Servis tekrar başlatmak için
```
systemctl restart seid
```
## Sync durumuna bakmak için
```
seid status 2>&1 | jq .SyncInfo
```
## Cüzdandaki token miktarını sorgulama komutu
```
seid query bank balances walletAddress
```
## Cüzdandaki token miktarı sorgulama komutu
```
seid query bank balances walletname
```

## Token transfer etmek için (FIRST_WALLET_ADDRESS kısmına gönderen cüzdanı,SECOND_WALLET_ADDRESS kısmına alıcı cüzdanı, TOKENAMOUNT kısmına göndermek istediğiniz token miktarını giriyoruz.)
```
seid tx bank send FIRST_WALLET_ADDRESS SECOND_WALLET_ADDRESS TOKENAMOUNTusei
```

## Delegate komutu (ValoperAddress kısmına validator adresimizi.TOKENAMOUNT kısmına delege etmek istediğimiz token miktarını giriyoruz.)
```
seid tx staking delegate ValoperAddress TOKENAMOUNTusei --from=WalletName --chain-id=atlantic-sub-1 --gas=auto
```

## Proposal'da oy vermek için (PROPOSALNUMBER proposal numarasını giriyoruz."yes/no" kısmına Oylamadaki fikrimizi giriyoruz.)
```
seid tx gov vote PROPOSALNUMBER yes/no --from WalletName --chain-id=atlantic-sub-1 --gas auto --gas-prices 0.025usei --gas-adjustment 1.5
```














