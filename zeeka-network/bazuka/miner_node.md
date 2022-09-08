# <h1 align="center">Zeeka network bazuka testnet full node manuel kurulum</h1>
![image](https://user-images.githubusercontent.com/73015593/188975421-e1d3e3f2-f3fc-4143-839d-97584dc7fca7.png)

> ## [Web Site](https://zeeka.io/)
> ## [Zeeka Explorer](http://152.228.155.120:8000/)
> ## [Zeeka Discord](https://discord.gg/vWkHJ8QU)

# Sistem gereksinimleri
```
OS : Linux 
Cpu : 12-16 vcpu (AMD Ryzen 9 16-core)
Ram : 32GB ram
Disk : ?
Gpu : 2080Ti card (zk snark optimizasyonu için güzel)
```
![image](https://user-images.githubusercontent.com/73015593/189064782-b1c4390c-3d4b-41a8-8ec8-8e6ed5877655.png)
![image](https://user-images.githubusercontent.com/73015593/189064907-d8499f48-9478-4916-a7e5-07b3e92b7745.png)

# Bazuke miner kurulumu  

## Bazuke sürümünü kontrol ediyoruz. (`DifferentGenesis` hatası alırsanız genesis blok değişmiş demektir. Bu durumda `~/.bazuka-debug` klasörünü silmeniz ve yeniden başlatmanız gerekir.)
```
cd ~/bazuka
git pull origin master
cargo install --path .
```

## (DifferentGenesis hatası alanlar) `~/.bazuka-debug` klasörünü silip tekrar başlatıyoruz.
```
rm -rf ~/.bazuka-debug
sudo systemctl restart zeeka
```

## MPN Başlatıcısını yüklüyoruz. (`zoro`)
```
git clone https://github.com/zeeka-network/zoro
cd zoro
cargo install --path .
```

## Kanıtlama parametlerini yüklüyoruz.
* Payment parameters (~700MB): [Link](https://drive.google.com/file/d/1sR-dJlr4W_A0sk37NkZaZm8UncMxqM-0/view?usp=sharing)
* Update parameters (~6GB): [Link](https://drive.google.com/file/d/149tUhC0oXJxsXDnx7vODkOZtIYzC_5HO/view?usp=sharing)
### Doğrudan CLI kullanarak indirmek için : 
```
sudo apt install curl
```

## [oauthplayground](https://developers.google.com/oauthplayground/) Linkine gidiyoruz.
![image](https://user-images.githubusercontent.com/73015593/189119650-2eec3e44-5349-4ad5-90aa-b1c756990fd7.png)

## Authorize API Kısmına `https://www.googleapis.com/auth/drive.readonly` Linkini yapıştırıyoruz ve tıklıyoruz.Ardından bir hesabımız ile yetkilendirme yapıyoruz.
![image](https://user-images.githubusercontent.com/73015593/189124161-96231e24-fbc7-458e-9e0e-18a7bcd7243e.png)

## Exchange authorization code for tokens tıklıyoruz. Oluşan `access_token` kısmını kopyalıyoruz.
![1](https://user-images.githubusercontent.com/73015593/189121544-29cefe00-0432-440c-95f0-7e2f079839b2.png)

##  access_token kısmına kopyaladığımız token imsinizi yapıştırıyoruz.
```
curl -H "Authorization: Bearer access_token" https://www.googleapis.com/drive/v3/files/1sR-dJlr4W_A0sk37NkZaZm8UncMxqM-0?alt=media -o payment_params.dat
```

## Tekrar [oauthplayground](https://developers.google.com/oauthplayground/) Linkine gidiyoruz.
![image](https://user-images.githubusercontent.com/73015593/189119650-2eec3e44-5349-4ad5-90aa-b1c756990fd7.png)

## Authorize API Kısmına `https://www.googleapis.com/auth/drive.readonly` Linkini yapıştırıyoruz ve tıklıyoruz.Ardından bir hesabımız ile yetkilendirme yapıyoruz.
![image](https://user-images.githubusercontent.com/73015593/189124152-6c538160-2b01-4ad6-abce-f2a9cf62b858.png)

## Exchange authorization code for tokens tıklıyoruz. Oluşan `access_token` kısmını kopyalıyoruz.
![1](https://user-images.githubusercontent.com/73015593/189121544-29cefe00-0432-440c-95f0-7e2f079839b2.png)

##  access_token kısmına kopyaladığımız token imsinizi yapıştırıyoruz.
```
curl -H "Authorization: Bearer access_token" https://www.googleapis.com/drive/v3/files/149tUhC0oXJxsXDnx7vODkOZtIYzC_5HO?alt=media -o update_params.dat
```
![image](https://user-images.githubusercontent.com/73015593/189122839-aa3677fc-fcb0-4346-8153-3a4d6531283a.png)

## Node ile beraber `zoro` çalıştırıyoruz. `[executor account]` Kısmına node için kullandığımızdan farklı bir isim girmemiz lazım.
```
zoro --node 127.0.0.1:8765 --seed [executor account] --network debug \
  --update-circuit-params ~/zoro/update_params.dat --payment-circuit-params ~/zoro/payment_params.dat \
  --db ~/.bazuka-debug
```

## Yeni bir blok oluşturulduktan sonra, uzi-miner PoW bulmacası üzerinde çalışmaya başlamalıdır, bu nedenle sisteminizde uzi-miner'ı da çalıştırmanız gerekir. 
* `THREADNUMBER` kısmına kullanacağımız thread sayısını yazıyoruz.
* Ekip tarafından önerilen 12-16vcpu dan 24-32 thread 
```
git clone https://github.com/zeeka-network/uzi-miner
cd ~/uzi-miner
cargo install --path .
uzi-miner --node 127.0.0.1:8765 --threads THREADNUMBER
```

## zoro servis dosyası oluşturuyoruz. `[executor account]` kısmına yukarda zoro başlatırken girdiğimiz ismi giriyoruz. 
```
tee /etc/systemd/system/zoro.service > /dev/null <<EOF
[Unit]
Description=Zoro
After=network.target
[Service]
User=root
ExecStart=/root/.cargo/bin/zoro --node 127.0.0.1:8765 --seed '[executor account]' --network debug --update-circuit-params ~/zoro/update_params.dat --payment-circuit-params ~/zoro/payment_params.dat --db ~/.bazuka-debug
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```

## uzi-miner servis dosyası oluşturuyoruz. `THREADNUMBER` Kısmına yukarda uzi miner başlatırken girdiğimiz thread sayısınız giriyoruz.
```
tee /etc/systemd/system/uzi.service > /dev/null <<EOF
[Unit]
Description=Uzi
After=network.target
[Service]
User=root
ExecStart=/root/.cargo/bin/uzi-miner --node 127.0.0.1:8765 --threads THREADNUMBER
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```

## zoro servisi oluşturuyoruz. 
```
sudo systemctl daemon-reload
sudo systemctl enable zoro
sudo systemctl restart zoro
```

## uzi miner servisi oluşturuyoruz.
```
sudo systemctl daemon-reload
sudo systemctl enable uzi
sudo systemctl restart uzi
```

## Zero contract Para Yatırın
```
bazuka deposit 
```

## Bu mesajı veya verilen alt komutların yardımını yazdırma komutu :
```
bazuka help 
```

## Node çalıştırma:
```
bazuka node Run node
```

## Sıradan token gönderme:
```
bazuka rsend 
```

Node durumunu yazdırmak için:
```
bazuka status 
```

## Zero-contract Token withdraw:
```
bazuka withdraw
```

## zero-transaction ile token gönderme:
```
bazuka zsend
```
