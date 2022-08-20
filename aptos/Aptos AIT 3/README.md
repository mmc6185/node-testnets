# <h1 align="center">Aptos AIT 3</h1>

![aptos](https://user-images.githubusercontent.com/73015593/177651583-9bfbdf15-79ee-447e-8442-5230a47fefff.jpg)

# Testnet detayları
Aptos AIT 3 testnetine dünya genelinden 225 kişi seçilecek.Her bir katılımcı en az 500 aptos token kazanacak. Daha iyi performans gösteren bazı katılımcılar ek 200 aptos token daha kazanacak.

[Daha fazla detay için medium makalesi]

https://medium.com/aptoslabs/welcome-to-aptos-incentivized-testnet-2-af26e2fd69a7

## Sistem gereksinimleri
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
wget -qO aptos-cli.zip https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-v0.3.1/aptos-cli-0.3.1-Ubuntu-x86_64.zip
unzip -o aptos-cli.zip
chmod +x aptos
mv aptos /usr/local/bin
```

## Varsayılan kullanıcımızın ana dizininde aptoss isimli bir dizin oluşturuyoruz (Bizde root) ve içine giriyoruz.
```
mkdir -p ~/aptoss
cd ~/aptoss
```

















