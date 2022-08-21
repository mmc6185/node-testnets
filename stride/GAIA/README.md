<h1 align="center">Gaia testnet</h1>

<img width="300" height="200"  alt="stride" src="https://user-images.githubusercontent.com/73015593/185782593-a32e1014-4c8f-4880-9996-2a4e11712e77.svg">  


# Minimum Sistem gereksinimleri
```
8GB RAM
200 GB SSD
4 vCPU
```

# Linkler
> ## [Discord](https://discord.gg/m62exje6)<br>
> ## [Stride website](https://stride.zone/)

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
![image](https://user-images.githubusercontent.com/73015593/180210944-05db38d1-2ae0-481d-bf67-ca37fd66e6ad.png)


## Kütüphane kurulumu yapıyoruz:
```
sudo apt install curl tar wget clang pkg-config libssl-dev libleveldb-dev jq build-essential bsdmainutils git make ncdu htop screen unzip bc fail2ban htop -y
```
![image](https://user-images.githubusercontent.com/73015593/180211995-0aab628b-4aa8-4b72-86f4-984e82124754.png)

## Go kurulumu yapıyoruz.
```
wget https://golang.org/dl/go1.18.1.linux-amd64.tar.gz; \
rm -rv /usr/local/go; \
tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz && \
rm -v go1.18.1.linux-amd64.tar.gz && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile && \
source ~/.bash_profile
```
![image](https://user-images.githubusercontent.com/73015593/180212350-73872b03-c465-4c07-9674-fdc008df2782.png)

## Go sürümünü kontrol ediyoruz.
```
go version
```
![image](https://user-images.githubusercontent.com/73015593/180212446-024cc343-b406-49e3-8922-9f647259289c.png)
  
## Binary kurulumunu yapıyoruz.
```
cd $HOME
git clone https://github.com/Stride-Labs/gaia.git
cd gaia
git checkout 5b47714dd5607993a1a91f2b06a6d92cbb504721
make build
sudo cp $HOME/gaia/build/gaiad /usr/local/bin
```

## initialize (başlatma) işlemi yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
gaiad init NodeName --chain-id GAIA
```

## genesis.json ve addrbook.json dosyalarını indiriyoruz.
```
wget -qO $HOME/.gaia/config/genesis.json "https://raw.githubusercontent.com/mmc6185/node-testnets/main/stride/GAIA/genesis.json"
wget -qO $HOME/.gaia/config/addrbook.json "https://raw.githubusercontent.com/mmc6185/node-testnets/main/stride/GAIA/addrbook.json"
```

## (opsiyonel) Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır)
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.gaia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.gaia/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.gaia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.gaia/config/app.toml
```

## Mininumum gas price ayarlıyoruz.
```
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0uatom\"/" $HOME/.gaia/config/app.toml
```

## Servis dosyası oluşturuyoruz ve servisimizi başlatıyoruz.
```
sudo tee /etc/systemd/system/gaiad.service > /dev/null <<EOF
[Unit]
Description=gaia
After=network-online.target
[Service]
User=$USER
ExecStart=$(which gaiad) start --home $HOME/.gaia
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable gaiad
sudo systemctl restart gaiad
```

## Cüzdan oluşturuyoruz. WalletName kısmına kendi cüzdan adımızı yazıyoruz.
```
gaiad keys add WalletName
```

## Cüzdan oluşturduktan sonra [Stride discord](https://discord.gg/m62exje6) kanalına giderek #token-faucet kanalından aşağıdaki gibi token talep ediyoruz. 
![image](https://user-images.githubusercontent.com/73015593/185785973-dbad5b92-9952-47aa-80d6-31f8c67b89cd.png)

## sync işlemi tamamlandıktan sonra validator oluşturuyoruz.NodeName kısmına validator ismimizi giriyoruz. WalletName kısmına cüzdan adresimizi yazıyoruz.
```
gaiad tx staking create-validator \
  --moniker NodeName \
  --amount 1000000uatom \
  --pubkey $(gaiad tendermint show-validator) \ 
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --chain-id GAIA \
  --from WalletName \
```  

## [Explorer](https://poolparty.stride.zone/GAIA/staking) giderek kendimizi kontrol ediyoruz.
![image](https://user-images.githubusercontent.com/73015593/185787079-d0cff98b-534f-4111-8665-3d24883933ba.png)

# Yararlı komutlar
## mnemonic ile Cüzdan recover etmek için (walletname kısmına cüzdan ismimizi yazıyoruz.):
```
gaiad keys add walletname --recover
```

## Sync durumunu kontrol etmek için (PORTNUMBER kısmına port numaranızı yazın):
```
curl -s localhost:PORTNUMBER/status | jq .result.sync_info
```

## Servis başlatmak için:
```
sudo systemctl start gaiad
```

## Servis durdurmak için:
```
sudo systemctl stop gaiad
```

## Servis tekrardan başlatmak için:
```
sudo systemctl restart gaiad
```

## Node id öğrenmek için:
```
gaiad tendermint show-node-id
```

## Cüzdandaki token miktarını sorgulamak için (WalletAddress kısmına cüzdan adresinizi yazın):
```
gaiad query bank balances WalletAddress
```

## Token transfer etmek için (TOKENMIKTAR kısmına transfer etmek istediğimiz token miktarını giriyoruz):
```
gaiad tx bank send ilkCüzdan transferetmekistediğincüzdan TOKENMIKTARuatom
```

## Proposal'da oy vermek için (Number kısmına oy vermek istediğimiz proposal'ın numarasını, walletName kısmına cüzdan ismimizi giriyoruz):
```
strided tx gov vote number yes --from walletName --chain-id=GAIA
```

## Token delege etmek için (validatorAddress kısmına validator adresimizi, WalletName kısmına cüzdan ismimizi yazıyoruz.):
```
strided tx staking delegate validatorAddress 10000000ustrd --from=WalletName --chain-id=GAIA --gas=auto
```






















  
  
  
  
