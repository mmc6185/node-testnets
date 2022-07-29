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
wget https://github.com/stratosnet/stratos-chain/releases/download/v0.8.0/stchaind
```

## stchaind'nin hash'ini kontrol edelim. (Görseldeki gibi çıktı almamız lazım)
```
md5sum stchain*
```
[Beklenen çıktı]

![image](https://user-images.githubusercontent.com/73015593/180650764-8a17cdeb-1a2c-4829-9ae3-243b9b3a765d.png)


## Binary dosyalarına execute yetkisi verelim
```
chmod +x stchaind
```
![stratos](https://user-images.githubusercontent.com/73015593/178150395-1f478902-f202-499b-a6ee-f39729d1d0f6.png)


## Go kurulumu yapıyoruz (1.16+ üstü sürüm olmalı)
```
wget -O go1.18.2.linux-amd64.tar.gz https://golang.org/dl/go1.18.2.linux-amd64.tar.gz 
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz && rm go1.18.2.linux-amd64.tar.gz 
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile 
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile 
echo 'export GO111MODULE=on' >> $HOME/.bash_profile 
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile 
go version 
go mod tidy
```
![go](https://user-images.githubusercontent.com/73015593/178150466-30977fc1-7b48-425d-9a5d-55aa217bda8a.png)

## Go sürümü hatası alırsanız ! 
```
snap remove go
apt purge golang*

snap install go --classic
```

## Source code ile binary dosyayı derliyoruz. 
(Hata alırsanız) 
1- go mod tidy
2- sudo apt update
3- make build
```
git clone https://github.com/stratosnet/stratos-chain.git
cd stratos-chain
git checkout v0.8.0
make build
```
![make](https://user-images.githubusercontent.com/73015593/178150499-22f97f97-341e-4b66-b7fb-f9e3d2b642e2.png)

## Binary dosyalarını $GOPATH/bin dizinine yüklüyoruz.
```
cd ~/stratos-chain
make install
```
![install](https://user-images.githubusercontent.com/73015593/178150615-3dee85dd-4faf-4e72-9d94-ce8390175d9e.png)

## initialize (başlatma) işlemi yapıyoruz. NodeName kısmına validator ismimizi yazıyoruz.
```
cd $HOME
./stchaind init NodeName
```
![init](https://user-images.githubusercontent.com/73015593/178150764-ae31d7de-3efc-4043-a427-238ed7060563.png)

## genesis.json ve config.toml dosyalarını indiriyoruz.
```
wget https://raw.githubusercontent.com/stratosnet/stratos-chain-testnet/main/genesis.json
wget https://raw.githubusercontent.com/stratosnet/stratos-chain-testnet/main/config.toml
```

## addrbook.json dosyasını indiriyoruz.
```
wget -O $HOME/.stchaind/config/addrbook.json "https://github.com/mmc6185/node-testnets/blob/main/stratos/stratos-tropos-4/addrbook.json?raw=true"
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

## sync durumunu kontrol ediyoruz. (false çıktısı almamız gerekiyor)
```
stchaind  status 2>&1 | jq .SyncInfo
```

## cüzdan oluşturuyoruz. WalletName kısmında kendi cüzdan adımızı yazıyoruz.
```
stchaind keys add --hd-path "m/44'/606'/0'/0/0" --keyring-backend test  WalletName
```
![key](https://user-images.githubusercontent.com/73015593/178202751-59ac87a6-fa9e-447a-9c15-b0eaf948559d.png)

## Eski cüzdan kullanmak isteyenler için:
```
stchaind keys add WalletName --recover
```

## Faucetten token alıyoruz. walletAddress kısmına cüzdan adresimizi yazıyoruz.
```
curl --header "Content-Type: application/json" --request POST --data '{"denom":"ustos","address":"walletAddress"} ' https://faucet-tropos.thestratos.org/credit
```
![FAUCET](https://user-images.githubusercontent.com/73015593/178208491-0bc5292c-bba1-4107-8aa6-b1f6329c2492.PNG)

## Cüzdanımızın bakiyesini sorguluyoruz. (walletAddress kısmına kendi cüzdan adresimizi yazıyoruz.)
```
stchaind query bank balances walletAddress
```
![queey](https://user-images.githubusercontent.com/73015593/178360928-5854a73b-662d-46d9-9a19-e008c13dfaf1.jpg)

## validator oluşturuyoruz. NodeName kısmına validator ismimizi giriyoruz. WalletAddres kısmına cüzdan adresimizi giriyoruz.
```
stchaind tx staking create-validator \
--amount=100000000ustos \
--pubkey=$(stchaind tendermint show-validator) \
--moniker="NodeName" \
--chain-id=tropos-4  --keyring-backend=test --gas=auto -y \
--commission-rate=0.10 \
--commission-max-rate=0.20 \
--commission-max-change-rate=0.01 \
--min-self-delegation=1 \
--from=walletAddress \
--gas=auto -y
```

## explorer'dan kendimizi kontrol ediyoruz.
https://big-dipper-tropos.thestratos.org/
![image](https://user-images.githubusercontent.com/73015593/180935989-4db5fe4e-fb10-410d-92b3-2bc0f1370273.png)




















