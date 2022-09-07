# <h1 align="center">Zeeka network bazuka testnet</h1>
![image](https://user-images.githubusercontent.com/73015593/188975421-e1d3e3f2-f3fc-4143-839d-97584dc7fca7.png)

> ## [Web Site](https://zeeka.io/)
> ## [Zeeka Explorer](http://152.228.155.120:8000/)
> ## [Zeeka Discord](https://discord.gg/vWkHJ8QU)

# Sistem gereksinimleri

# Bazuka full node kurulumu :

## Linux sistem güncellemesi yapıyoruz.
```
sudo apt-get update && apt-get upgrade -y
```

## kütüphane kurulum
```
sudo apt-get -y install libssl-dev && apt-get -y install cmake build-essential git wget jq make gcc
```
![image](https://user-images.githubusercontent.com/73015593/188980061-1e5037b8-d904-4123-9554-a78de3932542.png)

## rust toolchain kurulumu yapıyoruz.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```
![image](https://user-images.githubusercontent.com/73015593/188893633-1cf46a23-ca58-41ab-8a6d-125e26e0ac5b.png)

## rust versiyonu kontrol ediyoruz.
```
rustc --version
```

## zeeka'nin github dosyasını zeeka-network repository'den sunucumuza klonluyoruz ve binary kurulumu yapıyoruz.
```
git clone https://github.com/zeeka-network/bazuka
cd ~/bazuka
cargo install --path .
```

## initialize (başlatma) işlemini yapıyoruz. [your seed phrase] kısmına kendi ismimizi giriyoruz.
```
bazuka init --seed [your seed phrase] --network debug --node 127.0.0.1:8765
```

## Zeeka.service dosyamızı oluşturuyoruz. ExecStart kısmının sonuna kendi discord bilgimizi giriyoruz.
```
IPADDR=$(curl icanhazip.com)
sudo tee <<EOF >/dev/null /etc/systemd/system/zeeka.service
[Unit]
Description=Zeeka node
After=network.target

[Service]
User=$USER
ExecStart=/root/.cargo/bin/bazuka node --listen 0.0.0.0:8765 --external $IPADDR:8765 --network debug --db ~/.bazuka-debug --bootstrap 152.228.155.120:8765 --bootstrap 95.182.120.179:8765 --bootstrap 195.2.80.120:8765 --bootstrap 195.54.41.148:8765 --bootstrap 65.108.244.233:8765 --bootstrap 195.54.41.130:8765 --bootstrap 185.213.25.229:8765 --bootstrap 195.54.41.115:8765 --bootstrap 62.171.188.69:8765 --bootstrap 49.12.229.140:8765 --bootstrap 213.202.238.77:8765 --bootstrap 5.161.152.123:8765 --bootstrap 65.108.146.132:8765 --bootstrap 65.108.250.158:8765 --bootstrap 195.2.73.130:8765 --bootstrap 188.34.167.3:8765 --bootstrap 188.34.166.77:8765 --bootstrap 45.88.106.199:8765 --bootstrap 79.143.188.183:8765 --bootstrap 62.171.171.11:8765 --bootstrap 65.108.201.41:8765 --bootstrap 159.203.176.252:8765 --bootstrap 194.163.191.80:8765 --bootstrap 146.19.207.4:8765 --bootstrap 135.181.43.174:8765 --bootstrap 95.111.234.205:8765 --bootstrap 192.241.131.113:8765 --bootstrap 45.67.217.16:8765 --bootstrap 65.108.157.67:8765 --bootstrap 65.108.251.175:8765 --bootstrap 95.216.204.235:8765 --bootstrap 45.82.178.159:8765 --bootstrap 161.97.111.145:8765 --bootstrap 149.102.133.130:8765 --bootstrap 65.108.61.32:8765 --bootstrap 95.216.204.32:8765 --bootstrap 188.34.160.74:8765 --bootstrap 185.245.183.246:8765 --bootstrap 213.246.39.14:8765 --discord-handle "Forgotten Semicolon#4844"
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## servisimizi başlatıyoruz.
```
sudo systemctl daemon-reload
sudo systemctl enable zeeka
sudo systemctl restart zeeka
```

## Log kontrol komutu (Cüzdan bilgilerini kaydetmeyi unutmayın)

```
journalctl -u zeeka -f -o cat
```
![wtf](https://user-images.githubusercontent.com/73015593/188985151-fb45241d-d236-4476-8f61-9ae34066f159.PNG)

































