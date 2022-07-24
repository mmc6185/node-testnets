# <h1 align="center">Stratos tropos 4</h1>

![stratos](https://user-images.githubusercontent.com/73015593/177883166-54990a2a-2b9d-4e27-9559-0aed1c36f3f8.jpg)

## Sistem gereksinimleri
```
8GB RAM
160 GB SSD
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

## Binary dosya kurulumu yapıyoruz
```
cd $HOME
wget https://github.com/stratosnet/stratos-chain/releases/download/v0.8.0/stchaincli
wget https://github.com/stratosnet/stratos-chain/releases/download/v0.8.0/stchaind
```

## granularity kontrol edelim
```
md5sum stchain*
```
[Beklenen çıktı]

![md5](https://user-images.githubusercontent.com/73015593/177885177-738279f4-5c8b-457e-969b-8ffee2674839.png)


## Binary dosyalarına execute yetkisi verelim
```
chmod +x stchaincli
chmod +x stchaind
```
![stratos](https://user-images.githubusercontent.com/73015593/178150395-1f478902-f202-499b-a6ee-f39729d1d0f6.png)


## Go kurulumu yapıyoruz (1.16+ üstü sürüm olmalı)
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
![go](https://user-images.githubusercontent.com/73015593/178150466-30977fc1-7b48-425d-9a5d-55aa217bda8a.png)


## Source code ile binary dosyayı derliyoruz.
```
git clone https://github.com/stratosnet/stratos-chain.git
cd stratos-chain
git checkout v0.8.0
make build
```
![make](https://user-images.githubusercontent.com/73015593/178150499-22f97f97-341e-4b66-b7fb-f9e3d2b642e2.png)

## stchainli ve stchaind binary dosyalarını $HOME Dizinine taşıyoruz.
```
mv $HOME/stratos-chain/build/stchaincli ./
mv $HOME/stratos-chain/build/stchaind ./
```

## Binary dosyalarını $GOPATH/bin dizinine yüklüyoruz.
```
make install
```
![install](https://user-images.githubusercontent.com/73015593/178150615-3dee85dd-4faf-4e72-9d94-ce8390175d9e.png)

## initialize (başlatma) işlemi yapıyoruz. NodeName kısmına validator ismimizi yazıyoruz.
```
./stchaind init NodeName
```
![init](https://user-images.githubusercontent.com/73015593/178150764-ae31d7de-3efc-4043-a427-238ed7060563.png)

## genesis.json ve config.toml dosyalarını indiriyoruz.
```
wget https://raw.githubusercontent.com/stratosnet/stratos-chain-testnet/main/genesis.json
wget https://raw.githubusercontent.com/stratosnet/stratos-chain-testnet/main/config.toml
```

## genesis.json ve config.toml dosyalarını .stchaind/config/ dizini altına taşırız.
```
mv config.toml $HOME/.stchaind/config/
mv genesis.json  $HOME/.stchaind/config/
```

## servis dosyası oluşturuyoruz.
```
echo "[Unit]
Description=Stratos Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which stchaind) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/stratosd.service
sudo mv $HOME/stratosd.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
```

## servisimizi aktifleştiriyoruz.
```
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable stratosd
sudo systemctl restart stratosd
```

## Node'umuzun loglarına bakıyoruz.
```
journalctl -u stratosd -f
```
![stratos](https://user-images.githubusercontent.com/73015593/178208117-cb60b72d-69f8-4ba1-8d6b-8f2e0dab432c.png)


## cüzdan oluşturuyoruz. WalletName kısmında kendi cüzdan adımızı yazıyoruz.
```
./stchaincli keys add --hd-path "m/44'/606'/0'/0/0" --keyring-backend test  WalletName
```
![key](https://user-images.githubusercontent.com/73015593/178202751-59ac87a6-fa9e-447a-9c15-b0eaf948559d.png)


## Faucetten token alıyoruz. <your wallet address> kısmına cüzdan adresimizi yazıyoruz.
```
curl -X POST https://faucet-tropos.thestratos.org/faucet/<your wallet address>
```
![FAUCET](https://user-images.githubusercontent.com/73015593/178208491-0bc5292c-bba1-4107-8aa6-b1f6329c2492.PNG)

## Cüzdanımızın bakiyesini sorguluyoruz.
![queey](https://user-images.githubusercontent.com/73015593/178360928-5854a73b-662d-46d9-9a19-e008c13dfaf1.jpg)

## validator oluşturuyoruz. NodeName kısmına validator ismimizi giriyoruz. WalletName kısmına cüzdan ismimizi giriyoruz.
```
./stchaincli tx staking create-validator \
--amount=100000000000ustos \
--pubkey=$(stchaind tendermint show-validator) \
--moniker="NodeName" \
--chain-id=test-chain \
--keyring-backend=test \
--commission-rate=0.10 \
--commission-max-rate=0.20 \ 
--commission-max-change-rate=0.01 \ 
--min-self-delegation=1 \
--from=WalletName \ 
--gas=auto 
```























