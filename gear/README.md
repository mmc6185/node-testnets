# <h1 align="center">Gear testnet</h1>

![image](https://user-images.githubusercontent.com/73015593/189446632-60362158-d630-40da-bf8e-73b946a3e56e.png)

# Hetzner'de 20 Euro bonus [Link](https://hetzner.cloud/?ref=vtZTtbpG2Vcn)   


# Linkler
> ## [Discord](https://www.gear-tech.io/)<br>
> ## [Gear website](https://massa.net/)
> ## [Gear explorer](https://idea.gear-tech.io/explorer)

# Sistem gereksinimleri
```
64 GB SSD
```
![image](https://user-images.githubusercontent.com/73015593/189447026-5b776f3c-b817-4840-9159-d643f20c0042.png)

# Node kurulumu

## Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```


## Kütüphane kurulumu yapıyoruz.
```
sudo apt install make clang curl pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```

## Binary dosyayı yüklüyoruz.
```
cd
wget https://builds.gear.rs/gear-nightly-linux-x86_64.tar.xz && \
tar xvf gear-nightly-linux-x86_64.tar.xz && \
rm gear-nightly-linux-x86_64.tar.xz && \
chmod +x gear-node
cp ~/gear-node /usr/bin
```

## gear-node versiyon kontrolü yapıyoruz.
```
./gear-node --version
```
![image](https://user-images.githubusercontent.com/73015593/189448136-fe7fb9b8-e624-4bec-97a9-b3f6f1ca9937.png)

## Servis dosyası oluşturuyoruz. NodeName kısmına node ismimizi giriyoruz.
```
sudo tee /etc/systemd/system/gear.service > /dev/null <<EOF
[Unit]
Description=Gear Node
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/
ExecStart=/usr/bin/gear-node --name 'NodeName' --telemetry-url 'ws://telemetry-backend-shard.gear-tech.io:32001/submit 0'
Restart=always
RestartSec=3
LimitNOFILE=10000

[Install]
WantedBy=multi-user.target
EOF
```

## Servis oluşturuyoruz.
```
sudo systemctl daemon-reload
sudo systemctl enable gear
sudo systemctl restart gear
```
## Log Kontrol
```
journalctl -u gear -f -o cat
```
![image](https://user-images.githubusercontent.com/73015593/189450105-87e38ecc-c7e7-41e0-b5eb-b5ee81def7ae.png)






