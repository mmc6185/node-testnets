# <h1 align="center">Clan network</h1>

![clan](https://user-images.githubusercontent.com/73015593/178373417-1770ae94-ed25-4657-b6f8-b3efff6c340f.jpg)

# Sistem gereksinimleri
```
4GB RAM
50GB+ disk
4 vcpu
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
wget https://go.dev/dl/go1.18.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz

cat <<EOF >> ~/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF
source ~/.profile
```

## go sürümümüzü kontrol ediyoruz.
```
go version
```
![go](https://user-images.githubusercontent.com/73015593/178373838-f0597462-eeb9-4442-b9df-fcdd034a5702.PNG)

## clan network'ün github dosyasını clan network repository'den sunucumuza klonluyoruz.
```
git clone https://github.com/ClanNetwork/clan-network
```
![git](https://user-images.githubusercontent.com/73015593/178374092-e4a35646-1217-4cc9-828c-7d020004b35b.PNG)


## Binary kurulumunu yapıyoruz.
```
cd clan-network
git fetch origin --tags
git checkout v1.0.4-alpha
make install
```
![binary](https://user-images.githubusercontent.com/73015593/178374240-cd27d32d-0ed8-470e-80e7-5e1f6b20f5f8.PNG)


## Minimum gas ücreti ayarlıyoruz.
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0uclan\"/" ~/.clan/config/app.toml
```

## initialize (başlatma) işlemi yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
cland init NodeName --chain-id=playstation-2
```
![init](https://user-images.githubusercontent.com/73015593/178374881-7854f425-bfc1-4f2f-96b5-2203015c41ed.PNG)


## Genesis.json dosyasını indiriyoruz.
```
curl https://raw.githubusercontent.com/ClanNetwork/testnets/main/playstation-2/genesis.json > ~/.clan/config/genesis.json
```

## Peer ekliyoruz.
```
export PEERS = "2b215bc873edfa6bd3273e7fd0a48fd2de8186fe@188.166.249.173:26656,be8f9c8ff85674de396075434862d31230adefa4@35.231.178.87:26656,0cb936b2e3256c8d9d90362f2695688b9d3a1b9e@34.73.151.40:26656,e85dc5ec5b77e86265b5b731d4c555ef2430472a@23.88.43.130:26656,9d7ec4cb534717bfa51cdb1136875d17d10f93c3@116.203.60.243:26656,3049356ee6e6d7b2fa5eef03555a620f6ff7591b@65.108.98.218:56656,61db9dede0dff74af9309695b190b556a4266ebf@34.76.96.82:26656,d97c9ac4a8bb0744c7e7c1a17ac77e9c33dc6c34@34.116.229.135:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" ~/.clan/config/config.toml
```

## Cüzdan oluşturuyoruz.key-name kısmına kendi cüzdan ismimizi giriyoruz.
```
cland keys add key-name
```
![wallet](https://user-images.githubusercontent.com/73015593/178375230-9da290c5-0120-4634-b6c0-3ad512036b3f.PNG)


## Servis dosyası oluşturuyoruz.
```
sudo tee /etc/systemd/system/cland.service > /dev/null <<'EOF'
[Unit]
Description=Clan daemon
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/cland start
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF
```

## Servisi başlatıyoruz.
```
systemctl daemon-reload
systemctl enable cland
systemctl start cland
```

## Cüzdanımıza token almak için https://faucet-testnet.clan.network/ sitesine gidiyoruz. Oluşturduğumuz cüzdanın adresini giriyoruz.
![clan](https://user-images.githubusercontent.com/73015593/178375609-d7be60a2-636a-495e-9748-95e417c4ab03.PNG)


## Validator oluşturuyoruz.NodeName kısmına validator ismimizi giriyoruz.WalletName kısmına cüzdan ismimizi giriyoruz.
```
cland tx staking create-validator \
--moniker="NodeName" \
--amount=1000000uclan \
--gas auto \
--fees=5000uclan \
--pubkey=$(cland tendermint show-validator) \
--chain-id=playstation-2 \
--commission-max-change-rate=0.01 \
--commission-max-rate=0.20 \
--commission-rate=0.10 \
--min-self-delegation=1 \
--from=WalletName \
--yes
```





































