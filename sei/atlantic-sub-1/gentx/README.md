# <h1 align="center">Sei atlantic sub-1 create GENTX</h1>

# Grup 1 Olanlar atlantic-1 ağından devam ediyor.Grup 2-3 olanlar atlantic-sub-1 kurulumu yapıyor. Grup 4-5 olanlar atlantic-sub-2 kurulumu yapıyor.
* ## [GRUP LİSTESİ](https://docs.google.com/spreadsheets/d/1TEkE3EG_s8JGuFMKveyN89Pe8oB48rvsOGgmPlbNv3Q/edit#gid=959632928)
![image](https://user-images.githubusercontent.com/73015593/186838186-bda50b57-ed93-4b83-a7f3-ccd00e763497.png)

# Gentx oluşturma

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

## Genesis dosyamızda kendi hesabımızı ekliyoruz. WalletName Kısmına kendi cüzdan isminizi yazın.
```
seid add-genesis-account WalletName 10000000usei
```

## Gentx dosyamızı oluşturuyoruz. WalletName kısmına kendi cüzdan ismimizi giriyoruz.NodeName kısmına kendi validator ismimizi giriyoruz.
```
 seid gentx WalletName 10000000usei \
 --moniker=NodeName \
 --pubkey $(seid tendermint show-validator) \
 --commission-rate=0.05 \
 --commission-max-rate=0.2 \
 --commission-max-change-rate=0.05 \
 --chain-id=atlantic-sub-1 \
 --security-contact="" \
 --website="" \
 --details="" \
 --identity=""
```
![image](https://user-images.githubusercontent.com/73015593/186821553-9ef04c80-5267-4e83-8ce7-f3ccb00e4f68.png)

## Winscp vb SFTP yazılımı kullanarak sunucumuza bağlanıyoruz. "/root/.sei/config/gentx" dizinine gidiyoruz.gentx dosyamızı ana makinemiz yüklüyoruz.
![image](https://user-images.githubusercontent.com/73015593/186821924-5138228c-25a7-448b-af1d-59590b0e9238.png)

## [Sei testnet github](https://github.com/sei-protocol/testnet) adresine giderek forkluyoruz.
![image](https://user-images.githubusercontent.com/73015593/186822403-b7b24c47-5d9f-48e6-ad53-a72033b85645.png)

## Forkladığımız repository'de "testnet/tree/main/atlantic-subchains/atlantic-sub-1/gentx" adresine gidiyoruz.
![image](https://user-images.githubusercontent.com/73015593/186823066-8cc211d5-e6c4-4ae8-83b8-e63097d130d2.png)

## Add file ardından Upload files seçerek gentx dosyamızı "gentx-YOUR_VALIDATOR_NAME.json" şeklinde yüklüyoruz.(YOUR_VALIDATOR_NAME kısmına kendi validator isminiz yazıyorsunuz.)
![image](https://user-images.githubusercontent.com/73015593/186823206-2f5c2142-0bad-46b8-b687-9cd082479b77.png)

## Upload işleminden sonra sol üstten pull request seçeneğini seçiyoruz.
![image](https://user-images.githubusercontent.com/73015593/186823482-8c37f3b3-7f2e-4276-a1d3-caadda17c0d7.png)

## Ardından new pull request seçeneğini seçtikten sonra create pull request seçeneğini seçiyoruz ve PR gönderiyoruz.
![image](https://user-images.githubusercontent.com/73015593/186836085-32d90dfa-8a75-4a67-86e9-4bc1c0e150ac.png)

















