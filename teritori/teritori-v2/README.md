# <h1 align="center">Teritori v2 testnet</h1>
![teritori](https://user-images.githubusercontent.com/73015593/180592936-26a5d226-3dd3-4f17-b104-e784a7a8c07c.jpg)


# Sistem gereksinimleri
```
2vcpu
2 gb ram
80GB ssd 
```

# Node kurulumu

## root dizinine gidiyoruz.
```
cd /root
```

## Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```
![image](https://user-images.githubusercontent.com/73015593/180597449-5bd0bdaf-cd90-4e88-8d76-5cfa679f64ec.png)


## Kütüphane kurulumu yapıyoruz.
```
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```
![image](https://user-images.githubusercontent.com/73015593/180597786-f66a6dae-9e48-4025-b8d3-71ab371cdf6a.png)

## Go kurulumu yapıyoruz.
```
cd $HOME
wget -O go1.18.2.linux-amd64.tar.gz https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz && rm go1.18.2.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export GO111MODULE=on' >> $HOME/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bashrc && . $HOME/.bashrc
```
![image](https://user-images.githubusercontent.com/73015593/180597852-2c525935-c364-43a0-929a-4211116ea90c.png)


## Go sürümünü kontrol ediyoruz.
```
go version
```
![image](https://user-images.githubusercontent.com/73015593/180597861-6b97f723-d38c-4680-9838-e99eb537728a.png)

## Teritori'nin github dosyasını teritori repository'den sunucumuza klonluyoruz.
```
git clone https://github.com/TERITORI/teritori-chain
```
![image](https://user-images.githubusercontent.com/73015593/180597875-45143e81-da94-4eb3-b3e1-2aa30cbc4307.png)

## Binary kurulumunu yapıyoruz.
```
cd teritori-chain
git checkout teritori-testnet-v2
make install
```
![image](https://user-images.githubusercontent.com/73015593/180597892-78900cf9-e42f-4320-993a-107a032916b8.png)


## Kurulumu versiyon kontrolü yaparak doğruluyoruz.
```
teritorid version
```
![image](https://user-images.githubusercontent.com/73015593/180597972-5c909f7e-40db-4937-a9eb-ee111d7f7eae.png)

## initialize (başlatma) işlemi yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
teritorid init NodeName --chain-id teritori-testnet-v2
```
![image](https://user-images.githubusercontent.com/73015593/180597999-5e7635a8-67b9-4be7-ad34-4b99e07e4891.png)

## Peer ekliyoruz.
```
sed -i.bak 's/persistent_peers =.*/persistent_peers = "0b42fd287d3bb0a20230e30d54b4b8facc412c53@176.9.149.15:26656,2371b28f366a61637ac76c2577264f79f0965447@176.9.19.162:26656,2f394edda96be07bf92b0b503d8be13d1b9cc39f@5.9.40.222:26656"/' $HOME/.teritorid/config/config.toml
```

## Genesis.json dosyasını indiriyoruz.
```
wget -O ~/.teritorid/config/genesis.json https://raw.githubusercontent.com/TERITORI/teritori-chain/main/testnet/teritori-testnet-v2/genesis.json
```
![image](https://user-images.githubusercontent.com/73015593/180598021-c31d6e5a-a266-48c5-bcbb-10b516778e08.png)

# Cosmovisor kuruyoruz. (Cosmovisor, zincir yükseltmeleri için önceden binary dosyaları indirmemize izin verir, Böylece sıfır (veya sıfıra yakın) kesinti zinciri yükseltmeleri yapabileceğiniz anlamına gelir.)

## cosmovisor'ın github dosyasını cosmos-sdk repository'den sunucumuza klonluyoruz.
```
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@latest
```

## Dizinleri belirtiyoruz.
```
export DAEMON_NAME=teritorid
export DAEMON_HOME=$HOME/.teritori
source ~/.profile
```

## Dizinleri oluşturuyoruz.
```
mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades
```

## teritorid binary dosyasını başka bir dizine kopyalıyoruz.
```
cp $HOME/go/bin/teritorid $DAEMON_HOME/cosmovisor/genesis/bin
```

## Servis dosyası oluşturuyoruz.
```
tee <<EOF >/dev/null /etc/systemd/system/teritorid.service
[Unit]
Description=Teritori Daemon (cosmovisor)

After=network-online.target

[Service]
User=$USER
ExecStart=$HOME/go/bin/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=4096
Environment="DAEMON_NAME=teritorid"
Environment="DAEMON_HOME=$HOME/.teritori"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"

[Install]
WantedBy=multi-user.target
EOF
```

## Servisi başlatıyoruz.
```
systemctl enable teritorid
systemctl daemon-reload
systemctl restart teritorid
```

## Loglarımıza bakıyoruz.
```
journalctl -u teritorid.service -f -n 100
```

## Sync durumuna bakıyoruz. (false çıktısı almamız gerekiyor)
```
teritorid status 2>&1 | jq .SyncInfo
```

## Cüzdan oluşturuyoruz. WalletName kısmına kendi cüzdan isminizi yazın (Cüzdan bilgilerinizi kaydetmeyi unutmayın)
```
teritorid keys add WalletName
```






























