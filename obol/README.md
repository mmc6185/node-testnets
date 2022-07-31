# <h1 align="center">Obol network</h1>
![obol](https://user-images.githubusercontent.com/73015593/181934677-3ec36fc7-f2c4-45d2-a3c8-2dbd7361e562.png)

# Testnet başvuru

## root yetkisi kazanıyoruz.
```
sudo su
```

## root dizini altına gidiyoruz.
```
cd /root
```

## Sistem güncellemesi yapıyoruz.
```
apt-get update && apt-get upgrade -y
```

## Kütüphane kurulumu yapıyoruz.
```
sudo apt install make clang pkg-config libssl-dev libclang-dev build-essential git curl ntp jq llvm tmux htop screen unzip -y
```

## Docker kurulumu yapıyoruz.
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
![image](https://user-images.githubusercontent.com/73015593/181934007-7c171d4f-cf93-4e7d-bb42-f9e334f88af2.png)

## Docker compose kurulumu yapıyoruz.
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```
![image](https://user-images.githubusercontent.com/73015593/181934025-06218983-f066-4b54-b7da-776f5dc23c70.png)


## Obol'un github dosyasını obol repository'den sunucumuza klonluyoruz.
```
git clone https://github.com/ObolNetwork/charon-distributed-validator-node.git
```
![image](https://user-images.githubusercontent.com/73015593/181934031-3d1569c0-f90f-456d-adba-a66fe763e941.png)

## Dosyamıza tüm yetkileri veriyoruz.
```
chmod 777 charon-distributed-validator-node
```

## charon-distributed-validator-node dosyamızın içine giriyoruz.
```
cd ~/charon-distributed-validator-node
```


## Charon ENR private key'i oluşturuyoruz, bu .charon dizininde bir charon-enr-private-key dosyası oluşturacaktır. (Private key bilginizi kaydetmeyi unutmayın ! Testnete katılamazsınız.)
```
docker run --rm -v "$(pwd):/opt/charon" obolnetwork/charon:v0.9.0 create enr
```
![image](https://user-images.githubusercontent.com/73015593/181934511-ac355d19-483f-41fe-882b-40d8288e5584.png)

## İşlemleri tamamladıktan sonra formu dolduruyoruz. (Cüzdan kısmına enr ile başlayan public key adresinizi yollayın.)
https://obol.typeform.com/AthenaTestnet?typeform-source=blog.obol.tech
























