# Linkler
> ## [Discord](https://discord.gg/Dku9mezt)<br>
> ## [Gitopia website](https://gitopia.com/)
> ## [Gitopia explorer](https://explorer.gitopia.com/)

![image](https://user-images.githubusercontent.com/73015593/201476922-0274635a-fc68-4628-aea3-7aa6002612a9.png)

### İngilizce flood için : 
https://gitopia.com/CryptoSailors/gitopia-node-installation/tree/master/

## Sistem gereksinimleri
```
4 CPU
16 GB RAM
200-1000 GB SSD
```

## Sistem güncellemesi yapıyoruz.

```
sudo apt update && sudo apt upgrade -y
```

## Gerekli kütüphaneleri kuruyoruz.
```
sudo apt install make clang pkg-config libssl-dev libclang-dev build-essential git curl ntp jq llvm tmux htop screen unzip cmake -y
```

## Go kurulumu yapıyoruz
```
wget https://golang.org/dl/go1.19.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
cat <<EOF >> ~/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF
source ~/.profile
go version
rm -rf go1.19.3.linux-amd64.tar.gz
```

## Node kurulumu yapıyoruz.
```
curl https://get.gitopia.com | bash
```

## Gitopia Github repository'den sunucumuza kopyalıyoruz.
```
git clone -b v1.2.0 gitopia://gitopia/gitopia
```

## Gitopia klasörüne giriyoruz ve binary kurulumunu yapıyoruz.
```
cd gitopia && make install
```

## Versiyon kontrolü yapıyoruz. (v0.1.2) çıktısı almanız lazım.
```
gitopiad version
```

## Init (başlatma) işlemini gerçekleştiriyoruz. 
* NodeName kısmına kendi node ismimizi giriyoruz.
```
gitopiad init --chain-id gitopia-janus-testnet-2 NodeName
```

## Minimum gas price ayarlıyoruz.
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.001utlore\"/" ~/.gitopia/config/app.toml
```

## Indexer devre dışı bırakıyoruz.
```
sed -i.bak -e "s/^indexer *=.*/indexer = \"null\"/" ~/.gitopia/config/config.toml
```

## Seed node giriyoruz.
```
sed -i 's#seeds = ""#seeds = "399d4e19186577b04c23296c4f7ecc53e61080cb@seed.gitopia.com:26656"#' $HOME/.gitopia/config/config.toml
```
## Pruning açıyoruz. (Daha düşük disk kullanımı sağlar ancak cpu ve ram kullanımı artar)
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.gitopia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.gitopia/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.gitopia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.gitopia/config/app.toml
```

## Genesis dosyasını indiriyoruz.
```
wget https://server.gitopia.com/raw/gitopia/testnets/master/gitopia-janus-testnet-2/genesis.json.gz
gunzip genesis.json.gz
mv genesis.json $HOME/.gitopia/config/genesis.json
```
## Binary dosyasını `/usr/bin` altına taşıyoruz.
```
mv $HOME/go/bin/gitopiad /usr/bin/
```

## Servis dosyasını oluşturuyoruz.
```
tee /etc/systemd/system/gitopiad.service > /dev/null <<EOF
[Unit]
Description=Gitopia
After=network-online.target
[Service]
User=root
ExecStart=$(which gitopiad) start
Restart=always
RestartSec=3
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```

##  Node'u başlatıyoruz.
```
sudo systemctl daemon-reload
sudo systemctl start gitopiad
sudo systemctl enable gitopiad
sudo journalctl -u gitopiad -f -o cat
```

## Cüzdan oluşturuyoruz. 
* wallet kısmına cüzdan ismimizi giriyoruz.
* Mnemonic'leri kaydetmeyi unutmayın bir daha ulaşamazsınız !!!!
```
gitopiad keys add wallet
```

## [Gitopia](https://gitopia.com/home) sitesine giderek keplr cüzdanımızı bağlıyoruz. Get TLORE diyerek faucetten 10 adet token alıyoruz. 
![image](https://user-images.githubusercontent.com/73015593/201479305-76f07308-d924-429d-9fde-772bf46b65e9.png)

## Sync olup olmadığımızı kontrol ediyoruz.
* False çıktısı almadan validator kurmuyoruz.
```
gitopiad status 2>&1 | jq .SyncInfo
```

## Validator oluşturuyoruz.

* NodeName kısmına kendi validator ismimizi giriyoruz.
* WalletName kısmına yukarda oluşturduğumuz cüzdan ismimizi giriyoruz.
```
gitopiad tx staking create-validator \
--amount="5000000utlore" \
--pubkey=$(gitopiad tendermint show-validator) \
--moniker="NodeName" \
--chain-id=gitopia-janus-testnet-2 \
--from="WalletName" \
--commission-rate="0.1" \
--commission-max-rate=0.15 \
--commission-max-change-rate=0.1 \
--min-self-delegation=1 \
--gas-prices="0.001utlore" \
-y
```

# Yardımcı komutlar ([Kj Nodes](https://github.com/kj89/testnet_manuals/blob/main/gitopia/)'ten alıntı)


## Logları görüntüleme 
```
journalctl -fu gitopiad -o cat
```

## Servis başlatma
```
sudo systemctl start gitopiad
```

## Servis durdurma
```
sudo systemctl stop gitopiad
```

## Servis tekrar başlatma
```
sudo systemctl restart gitopiad
```

## sync bilgisi görmek için
```
gitopiad status 2>&1 | jq .SyncInfo
```

## Validator bilgisi görmek için
```
gitopiad status 2>&1 | jq .ValidatorInfo
```

## Node bilgisi görmek için
```
gitopiad status 2>&1 | jq .NodeInfo
```

## Node id görmek için
```
gitopiad tendermint show-node-id
```

## Cüzdanları listelemek için
```
gitopiad keys list
```

## Cüzdan recover etmek için
* WalletName kısmına kendi cüzdan isminizi giriyorsunuz.
```
gitopiad keys add WalletName --recover
```

## Cüzdan silmek için
* WalletName kısmına kendi cüzdan isminizi giriyorsunuz.
```
gitopiad keys delete WalletName
```

## Token bakiyesini görmek için
* WalletAddress kısmına kendi cüzdan adresinizi giriyorsunuz.
```
gitopiad query bank balances WalletAddress
```

## Token transfer etmek için
* WalletAddress kısmına kendi cüzdan adresinizi giriyorsunuz. 
* to_WalletAddress kısmına hedef cüzdan adresinizi giriyorsunuz.
* TOKENAMOUNT kısmına kaç token girmek istiyorsak onu 1 milyon ile çarparak giriyoruz. Örneğin bir tlore => 1000000utlore
```
gitopiad tx bank send WalletAddress to_WalletAddress TOKENAMOUNTutlore
```

## Aktif bir Proposalda oy vermek için
```
gitopiad tx gov vote 1 yes --from WalletName --chain-id=gitopia-janus-testnet-2
```

## Herhangi bir Validatore token Delegate etmek için 
* ValopeAddress kısmına validator adresinizi giriyorsunuz
* TOKENAMOUNT kısmına kaç token girmek istiyorsak onu 1 milyon ile çarparak giriyoruz. Örneğin bir tlore => 1000000utlore
```
gitopiad tx staking delegate ValoperAddress TOKENAMOUNTutlore --from=WalletName --chain-id=gitopia-janus-testnet-2 --gas=auto
```

## Herhangi bir validatore token redelege etmek için
* WalletName kısmına kendi cüzdan isminizi giriyorsunuz
* TOKENAMOUNT kısmına kaç token girmek istiyorsak onu 1 milyon ile çarparak giriyoruz. Örneğin bir tlore => 1000000utlore
```
gitopiad tx staking redelegate srcValidatorAddress destValidatorAddress TOKENAMOUNTutlore --from=WalletName --chain-id=gitopia-janus-testnet-2 --gas=auto
```

## Stake ödüllerini withdraw etmek için
* WalletName kısmına kendi cüzdan isminizi giriyorsunuz
```
gitopiad tx distribution withdraw-all-rewards --from=WalletName --chain-id=gitopia-janus-testnet-2 --gas=auto
```

## Ödülleri withdraw etmek için
* ValopeAddress kısmına validator adresinizi giriyorsunuz
* WalletName kısmına kendi cüzdan isminizi giriyorsunuz
```
gitopiad tx distribution withdraw-rewards ValoperAddress --from=WalletName --commission --chain-id=gitopia-janus-testnet-2 
```

## Node silmek için

```
sudo systemctl stop gitopiad
sudo systemctl disable gitopiad
sudo rm /etc/systemd/system/gitopia* -rf
sudo rm $(which gitopiad) -rf
sudo rm $HOME/.gitopia* -rf
sudo rm $HOME/gitopia -rf
sed -i '/GITOPIA_/d' ~/.bash_profile
```
