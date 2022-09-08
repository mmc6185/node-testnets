# <h1 align="center">StaFiHub Public Testnet 3</h1>

![stafihub](https://user-images.githubusercontent.com/73015593/177637610-b96608a2-e2b9-4baf-8b78-d6a6caf60f99.jpg)

# Sistem gereksinimleri
```
8GB RAM
300 GB SSD
4 vCPU
```

## Stafihub tesnet - 2 katılanlar öncelikle dosyalarını silmesi lazım:
```
sudo systemctl stop stafihubd && \
sudo systemctl disable stafihubd && \
rm /etc/systemd/system/stafihubd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .stafihub stafihub && \
rm -rf $(which stafihubd)
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


## Stafi'nin github dosyasını stafi repository'den sunucumuza klonluyoruz
```
git clone --branch public-testnet-v3 https://github.com/stafihub/stafihub
```


## Yazılımı kuruyoruz
```
cd $HOME/stafihub && make install
```
[Örnek bir kurulum]
![makeinstall](https://user-images.githubusercontent.com/73015593/177639669-9be70efd-6e7a-465e-98b2-05a51e2cfb7a.png)


## initialize (başlatma) işlemini yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
stafihubd init NodeName --chain-id stafihub-public-testnet-3
```
[Buradaki gibi uzun bir çıktı almanız lazım]
![init](https://user-images.githubusercontent.com/73015593/177640110-9ade0d7e-da32-49ea-a345-b5d30cbb3826.png)


## Genesis dosyasını indiriyoruz:
```
wget -O $HOME/.stafihub/config/genesis.json "https://raw.githubusercontent.com/stafihub/network/main/testnets/stafihub-public-testnet-3/genesis.json"
```
![wge](https://user-images.githubusercontent.com/73015593/177640695-e9e58600-12f0-4d14-9127-ab4d553489ef.png)


## Node için gerekli konfigurasyonları yapıyoruz.
-minimum-gas-prices ayarlıyoruz.
-peer ekliyoruz
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.01ufis\"/" $HOME/.stafihub/config/app.toml
sed -i '/\[grpc\]/{:a;n;/enabled/s/false/true/;Ta};/\[api\]/{:a;n;/enable/s/false/true/;Ta;}' $HOME/.stafihub/config/app.toml
peers="2e48b16575a278b90b605cb243a48c909de7fd03@194.60.201.136:26656,c8ba1915c78db452e56d50d3ba4d3357aeeda2d0@161.97.82.204:26656,c4509887f5eaea749bcdb5659aefbe857062d47c@142.93.170.65:26656,4e2441c0a4663141bb6b2d0ea4bc3284171994b6@46.38.241.169:26656,79ffbd983ab6d47c270444f517edd37049ae4937@23.88.114.52:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.stafihub/config/config.toml
```

## Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır) 
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.stafihub/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.stafihub/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.stafihub/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.stafihub/config/app.toml
```

## İndexer kapatırız (Disk kullanımını düşürür) 
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.stafihub/config/config.toml
```

## Servis dosyası oluşturup node'umuzu başlatıyoruz
```
echo "[Unit]
Description=StaFiHub Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which stafihubd) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/stafihubd.service
sudo mv $HOME/stafihubd.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable stafihubd
sudo systemctl restart stafihubd
```

## Sync kontrolü için aşağıdaki komutu gireriz. sync olmak için catching_up : false çıktısı almamız lazım.
```
stafihubd status 2>&1 | jq .SyncInfo
```
[Ağ "1088742" bloktan başlıyor]
![sync](https://user-images.githubusercontent.com/73015593/177642714-8f497eb8-ed3b-45f9-b2a3-9f2b533023b6.PNG)


[sync olan bir node böyle gözükür]
![height](https://user-images.githubusercontent.com/73015593/177642339-7b3dfe8b-e7e5-4968-8fc4-93bd6c4fb3cd.png)

## Cüzdan oluşturmak için walletName kısmına kendi cüzdan isminizi yazın (stafihub-testnet-2 katılmayanlar için)
```
stafihubd keys add walletName
```
[Görseldeki gibi kurtarma ifadelerinizi kaydetmeyi unutmayın. yoksa cüzdanınıza erişemezsiniz]
![cüzdan1](https://user-images.githubusercontent.com/73015593/177641324-d3723583-739c-4268-af85-33a90a950427.png)


## Eski cüzdanımızı kurtarma ifadelerini kullanarak recover ediyoruz. (stafihub-testnet-2 katılanlar için)
```
stafihubd keys add walletName --recover
```
![cüzdan](https://user-images.githubusercontent.com/73015593/177641003-3070518b-b505-44f8-80fb-127e0b6101d9.PNG)

## Sync tamamlandıktan sonra validator oluşturabilmek için discord kanalına gidiyoruz. Görselde görüldüğü gibi stafi-hub-faucet kanalından token istiyoruz.
![FAUCET](https://user-images.githubusercontent.com/73015593/177642897-6568649a-471f-4cbc-8afe-d860fd967730.PNG)

## Validator oluşturuyoruz. NodeName kısmına kendi node ismimizi.WalletName kısmına ise cüzdan ismimizi giriyoruz 
```
stafihubd tx staking create-validator \
--moniker="NodeName" \
--amount=1000000ufis \
--gas auto \
--fees=5000ufis \
--pubkey=$(stafihubd tendermint show-validator) \
--chain-id=stafihub-public-testnet-3 \
--commission-max-change-rate=0.01 \
--commission-max-rate=0.20 \
--commission-rate=0.10 \
--min-self-delegation=1 \
--from=WalletName \
--yes
```

## validator oluştuktan sonra böyle bir çıktı gelir.
![txhash](https://user-images.githubusercontent.com/73015593/177646080-e461110d-bbfa-4895-9ba9-7dcd81ce3d15.PNG)

## Validator oluşturup oluşturulmadığını explorerda txhash aratarak kontrol edebiliriz
https://testnet-explorer.stafihub.io/stafi-hub-testnet/staking
![suc](https://user-images.githubusercontent.com/73015593/177646264-e75d1681-e4e7-4493-a6c2-b6fa87f03459.PNG)

## Ayrıca explorerdan kendi ismimizi kontrol edebiliriz
https://testnet-explorer.stafihub.io/stafi-hub-testnet/staking
![explorer](https://user-images.githubusercontent.com/73015593/177646631-9a9cbac0-22ee-46ea-90a8-53702f10802f.PNG)


# Yararlı komutlar

## Logları izlemek için
```
journalctl -fu stafihubd -o cat
```
## Servis başlatmak için
```
systemctl start stafihubd
```
## Servis durdurmak için
```
systemctl stop stafihubd
```
## Servis tekrar başlatmak için
```
systemctl restart stafihubd
```
## Sync durumuna bakmak için
```
stafihubd status 2>&1 | jq .SyncInfo
```
## Cüzdandaki token miktarını sorgulama komutu
```
stafihub query bank balances walletAddress
```
## Cüzdandaki token miktarı sorgulama komutu
```
stafihubd query bank balances walletname
```
## Explorer linki: https://testnet-explorer.stafihub.io/stafi-hub-testnet
