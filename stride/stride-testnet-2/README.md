# <h1 align="center">Stride Testnet 2</h1>

![stride](https://user-images.githubusercontent.com/73015593/180210525-c011f584-ccd8-464f-8bc3-48b97dade2b4.jpg)


## Minimum Sistem gereksinimleri (Genel cosmos sistem gereksinimi)
```
8GB RAM
200 GB SSD
4 vCPU
```
# A- Script ile kurulum

## Scriptimiz çalıştırıyoruz.
```
wget -q -O stride.sh https://api.rues.info/stride.sh && chmod +x stride.sh && sudo /bin/bash stride.sh
```

## Cüzdan oluşturuyoruz.key-name kısmına kendi cüzdan ismimizi giriyoruz. (Tüm bilgileri kaydetmeyi unutmayın)
```
strided keys add key-name
```

## token-faucet kanalından "$faucet:cüzdanadresi" biçiminde token istiyoruz. (cüzdanadresi kısmına cüzdan adresinizi yazın)
![image](https://user-images.githubusercontent.com/73015593/180241741-f58095ec-a202-4587-9484-7c64af426c39.png) 

## sync işlemi tamamlandıktan sonra validator oluşturuyoruz.ValidatorName kısmına validator ismimizi giriyoruz. WalletName kısmına cüzdan adresimizi yazıyoruz.
```
strided tx staking create-validator \
--amount=9800000ustrd \
--pubkey=$(strided tendermint show-validator) \
--moniker=ValidatorName \
--chain-id=STRIDE-TESTNET-2 \
--commission-rate="0.10" \
--commission-max-rate="0.20" \
--commission-max-change-rate="0.1" \
--min-self-delegation="1" \
--fees=250ustrd \
--gas=500000 \
--from=WalletName \
-y
```


# B- Manuel Node kurulumu

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

## stride'ın github dosyasını stride repository'den sunucumuza klonluyoruz.
```
git clone https://github.com/Stride-Labs/stride.git
```
![image](https://user-images.githubusercontent.com/73015593/180214410-ae44e2a4-1c36-4424-a62f-de8c7ff4518c.png)

## Binary kurulumunu yapıyoruz.
```
cd stride
git checkout 3cb77a79f74e0b797df5611674c3fbd000dfeaa1
make build
sudo cp $HOME/stride/build/strided /usr/local/bin
```
![image](https://user-images.githubusercontent.com/73015593/180217544-a200d561-8826-436d-a61a-048a18b34c00.png)

## initialize (başlatma) işlemi yapıyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
strided init NodeName --chain-id STRIDE-TESTNET-2
```
![image](https://user-images.githubusercontent.com/73015593/180220598-10b6ba64-b847-46cc-ae5d-e7580a35c28d.png)

## Cüzdan oluşturuyoruz.key-name kısmına kendi cüzdan ismimizi giriyoruz. (Tüm bilgileri kaydetmeyi unutmayın)
```
strided keys add key-name
```
![wallet](https://user-images.githubusercontent.com/73015593/180227470-b8e3d8cc-e876-4b40-8132-3326347e6ca6.PNG)

## Genesis dosyasını indiriyoruz.
```
cd $HOME/.stride/config
wget -O genesis.json "https://raw.githubusercontent.com/Stride-Labs/testnet/main/poolparty/genesis.json"
```
![image](https://user-images.githubusercontent.com/73015593/180229869-3521bbba-b2a9-4d80-a32c-02c5a2f71ea5.png)


## (opsiyonel) Pruning açıyoruz. (Disk kullanımını düşürür - cpu ve ram kullanımını arttırır)  
```
pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="10" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.stride/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.stride/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.stride/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.stride/config/app.toml
```

## İndexer kapatırız (Disk kullanımını düşürür)
```
indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.stride/config/config.toml
```

## minimum-gas-prices ayarlıyoruz
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0ustrd\"/;" ~/.stride/config/app.toml
```

## Peer ve seed ayarlıyoruz.
```
external_address=$(wget -qO- eth0.me) 
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/.stride/config/config.toml

peers=""
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.stride/config/config.toml

seeds="baee9ccc2496c2e3bebd54d369c3b788f9473be9@seedv1.poolparty.stridenet.co:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.stride/config/config.toml

sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 100/g' $HOME/.stride/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 100/g' $HOME/.stride/config/config.toml
```

## Addrbook.json dosyasını indiriyoruz.
```
wget -O $HOME/.stride/config/addrbook.json "https://github.com/mmc6185/node-testnets/blob/main/stride/addrbook.json?raw=true"
```
![image](https://user-images.githubusercontent.com/73015593/180236623-57e5bbf8-1041-46b7-a4b6-0ec1e29e76bc.png)

## Servis dosyası oluşturuyoruz.
```
sudo tee /etc/systemd/system/strided.service > /dev/null <<EOF
[Unit]
Description=strided
After=network-online.target

[Service]
User=$USER
ExecStart=$(which strided) start
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## Servisimizi başlatıyoruz.
```
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable strided
sudo systemctl restart strided
```
![image](https://user-images.githubusercontent.com/73015593/180237107-cd42af13-efb4-4575-9c83-68380ae89925.png)

## Logları kontrol ediyoruz. 
```
journalctl -u strided -f -o cat
```

[sync başlamadan önce gözüken]
![image](https://user-images.githubusercontent.com/73015593/180238625-1d9f02d9-ffda-4ee4-a38f-e7971ea476bd.png)

[sync başladıktan sonra gözüken]
![image](https://user-images.githubusercontent.com/73015593/180243931-bc15a3d6-1168-49f4-ac3e-43b183268dd2.png)

## Discord kanalına giriyoruz.
https://discord.gg/HBjpbcsB

## token-faucet kanalından "$faucet:cüzdanadresi" biçiminde token istiyoruz. (cüzdanadresi kısmına cüzdan adresinizi yazın)
![image](https://user-images.githubusercontent.com/73015593/180241741-f58095ec-a202-4587-9484-7c64af426c39.png)

## Sync durumunu kontrol ediyoruz. false çıktısı almamız lazım. (26657 port değiştirdiyseniz değiştirdiğiniz portu yazmanız lazım)
```
curl -s localhost:26657/status | jq .result.sync_info
```
![image](https://user-images.githubusercontent.com/73015593/180244834-437d4985-fde9-42d9-a6ac-e10ba4cdfcea.png)


## sync işlemi tamamlandıktan sonra validator oluşturuyoruz.ValidatorName kısmına validator ismimizi giriyoruz. WalletName kısmına cüzdan adresimizi yazıyoruz.
```
strided tx staking create-validator \
--amount=9800000ustrd \
--pubkey=$(strided tendermint show-validator) \
--moniker=ValidatorName \
--chain-id=STRIDE-TESTNET-2 \
--commission-rate="0.10" \
--commission-max-rate="0.20" \
--commission-max-change-rate="0.1" \
--min-self-delegation="1" \
--fees=250ustrd \
--gas=500000 \
--from=WalletName \
-y
```
![image](https://user-images.githubusercontent.com/73015593/180307376-f5e45e30-b3cf-4d38-a950-86d18e9cf18a.png)

## Validator oluşturduktan sonra çıkan txhash'i explorerda aratıyoruz. (Success çıktısı almamız gerekli)
https://stride.explorers.guru/validators
![image](https://user-images.githubusercontent.com/73015593/180307631-34dac205-33d2-4b07-8ef2-fb83ac61f864.png)


## Explorer'dan validatorümüzü kontrol ediyoruz.
https://stride.explorers.guru/validators
![image](https://user-images.githubusercontent.com/73015593/180308024-c08a6019-f44a-43b5-b87e-c138e58ead96.png)


# Yararlı komutlar
## Logları izlemek için:
```
journalctl -u strided -f -o cat
```
![image](https://user-images.githubusercontent.com/73015593/180308439-65ffa7b3-2432-43d1-a2ab-9b8f8d5dbffd.png)


## mnemonic ile Cüzdan recover etmek için (walletname kısmına cüzdan ismimizi yazıyoruz.):
```
strided keys add walletname --recover
```
![recover](https://user-images.githubusercontent.com/73015593/180307244-68ddb9ed-3bad-4991-9d90-0e1785039267.PNG)

## Sync durumunu kontrol etmek için (16657 kısmına port numaranızı yazın):
```
curl -s localhost:16657/status | jq .result.sync_info
```
![image](https://user-images.githubusercontent.com/73015593/180308561-79eda576-af12-45df-9139-7b0fa3999819.png)

## Servis başlatmak için:
```
sudo systemctl start strided
```

## Servis durdurmak için:
```
sudo systemctl stop strided
```

## Servis tekrardan başlatmak için:
```
sudo systemctl restart strided
```

## Node id öğrenmek için:
```
strided tendermint show-node-id
```

## Cüzdandaki token miktarını sorgulamak için (WalletAddress kısmına cüzdan adresinizi yazın):
```
strided query bank balances WalletAddress
```

## Token transfer etmek için (TOKENMIKTAR kısmına transfer etmek istediğimiz token miktarını giriyoruz):
```
strided tx bank send ilkCüzdan transferetmekistediğincüzdan TOKENMIKTARustrd
```

## Proposal'da oy vermek için (Number kısmına oy vermek istediğimiz proposal'ın numarasını, walletName kısmına cüzdan ismimizi giriyoruz):
```
strided tx gov vote number yes --from walletName --chain-id=STRIDE-TESTNET-2
```

## Token delege etmek için (validatorAddress kısmına validator adresimizi, WalletName kısmına cüzdan ismimizi yazıyoruz.):
```
strided tx staking delegate validatorAddress 10000000ustrd --from=WalletName --chain-id=STRIDE-TESTNET-2 --gas=auto
```


























