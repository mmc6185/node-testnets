# <h1 align="center">Bundlr Testnet</h1>

![bundlr](https://user-images.githubusercontent.com/73015593/180402615-3b816a9e-1978-4e0b-8b16-ae172fc715ab.jpg)

## Sistem gereksinimleri
```
8GB RAM
250 GB GB SSD
4 vCPU
1 Gbps for Download/100 Mbps for Upload
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
![image](https://user-images.githubusercontent.com/73015593/180403122-f067c92b-ec50-47ef-81ef-4549639668bc.png)

## Kütüphane kurulumu yapıyoruz.
```
apt-get install git wget snapd curl jq libpq-dev libssl-dev build-essential pkg-config openssl ocl-icd-opencl-dev libopencl-clang-dev libgomp1 -y 2>/dev/null
```
![image](https://user-images.githubusercontent.com/73015593/180403285-107688bb-d141-4694-b7ce-69cc4a595792.png)

## Docker kurulumu yapıyoruz.
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
![image](https://user-images.githubusercontent.com/73015593/180603095-47428bbd-6864-4ab6-b397-e83124273650.png)


## Docker compose kurulumu yapıyoruz.
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```
![image](https://user-images.githubusercontent.com/73015593/180603107-0276548d-4657-473d-a7b3-838a63b8a285.png)

## Bundlr'ın github dosyasını Bundlr repository'den sunucumuza klonluyoruz.
```
git clone --recurse-submodules https://github.com/Bundlr-Network/validator-rust.git
```
![image](https://user-images.githubusercontent.com/73015593/180603145-52f46685-82cc-4dac-b21b-3fd023f9a053.png)

## arweave sitesine giderek cüzdan oluşturuyoruz. (sol alttan + işaretine tıklıyoruz.)
https://arweave.app/welcome
![image](https://user-images.githubusercontent.com/73015593/180603207-1138b97a-5328-4121-aadd-4a29f3f84059.png)

## Create new file'a tıklıyoruz. (kurtarma ifadelerini kaydediyoruz.)
![image](https://user-images.githubusercontent.com/73015593/180603238-df8433d8-86a5-4bec-907c-b94055799c35.png)

## download tıklayarak json dosyasını indiriyoruz. (Ayrıca cüzdan adresimizi kaydediyoruz)
![image](https://user-images.githubusercontent.com/73015593/180610627-39a07ba0-e0d3-4729-ad14-5fffa97a80c1.png)

## winscp ile sunucumuza bağlanıyoruz.
![image](https://user-images.githubusercontent.com/73015593/180603443-43402c59-6c59-4eb9-86f1-d2381423aaba.png)

## Bilgisayarımızdan sunucumuza indirdiğimiz json dosyasını taşıyoruz.
![image](https://user-images.githubusercontent.com/73015593/180603518-b166868a-eade-4405-98cf-5163af842e67.png)

## sunucumuzdaki json dosyasının ismini wallet.json olarak değiştirelim. (JsonDosyanız kısmına kendi json dosyanızın ismini girin)
```
cp JsonDosyanız wallet.json
```
![image](https://user-images.githubusercontent.com/73015593/180603550-fb120c2e-e90a-4c14-896a-096e9f31acfd.png)

## wallet.json dosyasını validator-rust dizine kopyalıyoruz.
```
cp ~/wallet.json ~/validator-rust
```
![image](https://user-images.githubusercontent.com/73015593/180603628-57fd240d-a09f-4c70-9094-5f436a0249e8.png)

## validator-rust dizini altında .env dosyası oluşturuyoruz.
```
sudo tee <<EOF >/dev/null $HOME/validator-rust/.env
PORT="4444"
VALIDATOR_KEY="~/validator-rust/wallet.json"
BUNDLER_URL="https://testnet1.bundlr.network" 
GW_CONTRACT="RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA"  
GW_WALLET="~/validator-rust/wallet.json"
GW_ARWEAVE="https://arweave.testnet1.bundlr.network"
EOF
```
![image](https://user-images.githubusercontent.com/73015593/180605484-5db5287b-bb2f-4648-bdfd-dcd06279410d.png)

## Validator oluşturup çalıştırıyoruz.
```
cd ~/validator-rust
docker-compose up -d
```
![image](https://user-images.githubusercontent.com/73015593/180608039-2ee14516-f6d8-49e2-8b72-93fbfcf26227.png)

## Repository güncelliyoruz.
```
git pull origin master
```
![image](https://user-images.githubusercontent.com/73015593/180608064-55aa1505-9ece-48ae-a3fd-87e4e9c3326c.png)

## Güncellenmiş validator'ü oluşturuyoruz.
```
docker-compose build
```
![image](https://user-images.githubusercontent.com/73015593/180608120-4f4bdcc4-a12d-4a78-8bcd-c656488c30ed.png)

## Validator'ü tekrar çalıştırıyoruz.
```
cd ~/validator-rust
docker-compose up -d
```

## Node.js kurulumu yapıyoruz.
```
source ~/.bashrc
sudo apt-get install snapd
sudo snap install node --channel=16/stable --classic
```

## npm güncel sürümünü kuruyoruz.
```
npm install -g npm@8.15.0
```
![image](https://user-images.githubusercontent.com/73015593/180609229-ffea7d6b-c53f-4862-9869-777653ad1992.png)


## Testnet cli indiriyoruz.
```
npm i -g @bundlr-network/testnet-cli
source $HOME/.profile
```

## Faucet sitesine gidiyoruz.Görseldeki gibi cüzdan adresimizi giriyoruz.
https://bundlr.network/faucet
![image](https://user-images.githubusercontent.com/73015593/180610746-ce33da60-7a47-4830-bfd0-d06d38779b95.png)

## Twitter'da token isteğimizi paylaştıktan sonra url'i yapıştırıyoruz. ve aşağıdaki gibi bir çıktı alıyoruz.
![image](https://user-images.githubusercontent.com/73015593/180610713-e362ad2d-c347-4b03-a23d-c8c967005c5c.png)

## Cüzdanımızda bakiye sorgusı yapıyoruz. walletAddress kısmına cüzdan adresimizi yazıyoruz.
```
testnet-cli balance walletAddress
```
![image](https://user-images.githubusercontent.com/73015593/180610977-ee74ca81-a542-4b10-bb9b-c127dff5cb3b.png)

## Testnete katılıyoruz. bu işlem uzun sürebilir.
```
testnet-cli join RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA -w ~/validator-rust/wallet.json ~/ -u  "http://$(curl icanhazip.com):4444" -s 25000000000000
```
![image](https://user-images.githubusercontent.com/73015593/180611584-764b2363-0e76-4a49-a4ef-0cb2a35de5a1.png)

## Explorer'da kendimizi kontrol ediyoruz.
https://bundlr.network/explorer/

## Loglara bakmak için: 
```
docker-compose -f $HOME/validator-rust/docker-compose.yml logs -f --tail 10
```




































