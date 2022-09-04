# <h1 align="center">Aptos AIT 2</h1>

![aptos](https://user-images.githubusercontent.com/73015593/177651583-9bfbdf15-79ee-447e-8442-5230a47fefff.jpg)

# Testnet detayları
Aptos AIT 2 testnetine yaklaşık dünya genelinden 200 kişi seçilecek.Her bir katılımcı en az 500 aptos token kazanacak. Daha iyi performans gösteren bazı katılımcılar ek 200 aptos token daha kazanacak.

[Daha fazla detay için medium makalesi]

https://medium.com/aptoslabs/welcome-to-aptos-incentivized-testnet-2-af26e2fd69a7

# Linkler
> ## [Discord](https://discord.gg/BuCh3Trg)<br>
> ## [Aptos website](https://aptoslabs.com/)
> ## [Aptos explorer](https://aptos-node.info/)

# Sistem gereksinimleri
```
8GB RAM
300 GB SSD
4 vCPU
```
# Node kurulumu

## root yetkisi kazanırız.
```
sudo su
```

## root dizini altına gideriz.
```
cd /root
```

## Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```

## Gerekli kütüphanelerin kurulumunu yapıyoruz.
```
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony unzip liblz4-tool -y
```

## Docker kurulumu yapıyoruz.
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Docker compose kurulumu yapıyoruz.
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## Aptos'u indiriyoruz.
```
wget -qO aptos-cli.zip https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-0.2.0/aptos-cli-0.2.0-Ubuntu-x86_64.zip
unzip -o aptos-cli.zip
chmod +x aptos
mv aptos /usr/local/bin
```

## Varsayılan kullanıcımızın ana dizininde aptoss isimli bir dizin oluşturuyoruz ve içine giriyoruz.
```
mkdir -p ~/aptoss
cd ~/aptoss
```

## validator.yaml ve docker-compose.yaml config dosyalarını indiriyoruz.
```
wget -O $HOME/aptoss/docker-compose.yaml https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml
wget -O $HOME/aptoss/validator.yaml https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml
```

## Dizinimizde node owner key, consensus key ve networking key Oluşturuyoruz.
```
aptos genesis generate-keys --assume-yes --output-dir $HOME/aptoss
```

## Validator bilgilerini yapılandırıyoruz. NodeName kısmına node ismimizi giriyoruz.
```
IPADDR=$(curl icanhazip.com):6180
cd ~/aptoss
aptos genesis set-validator-configuration \
    --keys-dir ~/aptoss --local-repository-dir ~/aptoss \
    --username NodeName \
    --validator-host $IPADDR
```

## NodeName.yaml içeriğini kontrol ediyoruz.NodeName kısmına yukarda validator bilgilerini girerken kullandığımız node ismimizi giriyoruz.
```
cat $HOME/aptoss/NodeName.yaml
```
[NodeName.yaml dosyamız aşağıdaki gibi gözükmeli]
![nodenameyaml](https://user-images.githubusercontent.com/73015593/177654651-5f5aac95-a26e-41f5-8f5f-2fcc066b52f9.jpg)

## layout.yaml dosyası oluşturuyoruz. NodeName kısmına validator bilgilerini yapılandırırken girdiğimiz ismi giriyoruz.
```
echo "---
root_key: \"F22409A93D1CD12D2FC92B5F8EB84CDCD24C348E32B3E7A720F3D2E288E63394\"
users:
  - \"NodeName\"
chain_id: 40
min_stake: 0
max_stake: 100000
min_lockup_duration_secs: 0
max_lockup_duration_secs: 2592000
epoch_duration_secs: 86400
initial_lockup_timestamp: 1656615600
min_price_per_gas_unit: 1
allow_new_validators: true" >layout.yaml
```

## AptosFramework bytecode indiriyoruz.
```
wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.2.0/framework.zip
unzip framework.zip
```

## Genesis blob ve waypoint compile ediyoruz.
```
aptos genesis generate-genesis --local-repository-dir ~/aptoss --output-dir ~/aptoss
```

## Docker başlatıyoruz.
```
docker-compose down -v
docker-compose up -d
```

## Aptos validator durumunuzu kontrol etmek için.API Kısmı varsayılan 8080 portuna bakıyor. 80 olarak değiştirin.
https://aptos-node.info/

[çalışan bir node örneği]
![çalışan](https://user-images.githubusercontent.com/73015593/177657023-c4700b90-25fd-4e1a-91bb-bedb987d350d.PNG)


# KYC işlemleri için [aptoslabs](https://community.aptoslabs.com/it2) sitesine gidiyoruz.

## Public keys bilgilerini öğrenmek için komutumuzu giriyoruz. (NodeName kısmına kendi node isminizi girin. Bunlar kyc formunda doldurmamız gerekecek.)
```

cat ~/aptoss/NodeName.yaml
```


## Public keys bilgilerini yukarıda öğrendiğimiz komutla dolduruyoruz.
![publicke](https://user-images.githubusercontent.com/73015593/177657633-a81cbe23-6ff6-4919-9c44-e1757c8dd95b.jpg)

## İp ve port bilgilerimizi aşağıdaki gibi dolduruyoruz.Api port kısmını 80 olarak yazıyoruz.
![apiport](https://user-images.githubusercontent.com/73015593/177657892-c25d3dac-9313-4d19-b0c8-d4c2e44160d6.jpg)

## İşlemler tamamlandıktan sonra böyle bir mail alacaksınız.
![mail](https://user-images.githubusercontent.com/73015593/177658033-85824fd2-c4aa-4dd8-8c95-527b5edb3532.jpg)



















