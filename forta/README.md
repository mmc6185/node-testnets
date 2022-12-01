# <h1 align="center">Forta Testnet</h1>

![forta](https://user-images.githubusercontent.com/73015593/177802204-af0a8c50-d0a1-432c-9a01-682cf4378dee.jpg)

# Hetzner'de 20 Euro bonus [Link](https://hetzner.cloud/?ref=vtZTtbpG2Vcn)   


# Linkler
> ## [Discord](https://discord.gg/78rCzsZ7)<br>
> ## [Forta website](https://forta.org/)
> ## [Forta explorer](https://explorer.forta.network/)

# Sistem gereksinimleri 
```
CPU: 4 cores
Memory: 16GB RAM
SSD: 100GB drive space
```

# Node kurulumu

## root yetkisi kazanıyoruz.
```
sudo su
```

## root dizini altında gidiyoruz.
```
cd /root
```

## Sistem güncellemesi yapıyoruz.
```
apt-get update && apt-get upgrade -y 
```

## Docker kurulumu yapıyoruz.
```
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```
[Örnek bir docker kurulum]
![y](https://user-images.githubusercontent.com/73015593/177807724-a80846ae-c972-4417-a77f-50e2c04ea47a.PNG)


## Docker versiyonu kontrol ediyoruz.
```
docker version
```
[Örnek bir versiyon çıktısı komutu]
![dockerversion](https://user-images.githubusercontent.com/73015593/177807937-ff677b34-762e-4b2d-9925-f0595cdfd70a.PNG)


## Docker address pool konfigurasyonu yapıyoruz
```
tee /etc/docker/daemon.json > /dev/null <<EOF
{
   "default-address-pools": [
        {
            "base":"172.17.0.0/12",
            "size":16
        },
        {
            "base":"192.168.0.0/16",
            "size":20
        },
        {
            "base":"10.99.0.0/16",
            "size":24
        }
    ]
}
EOF
systemctl restart docker
```

## Forta binary dosyalarını indirip yüklüyoruz.
```
sudo curl https://dist.forta.network/pgp.public -o /usr/share/keyrings/forta-keyring.asc -s
echo 'deb [signed-by=/usr/share/keyrings/forta-keyring.asc] https://dist.forta.network/repositories/apt stable main' | sudo tee -a /etc/apt/sources.list.d/forta.list
apt-get update
sudo apt-get install forta
```

## initialize (başlatma) işlemini yapıyoruz.your_passphrase kısmına kendi şifrenizi girin.
```
forta init --passphrase your_passphrase
```

## Yukardaki komutla oluşan scanner adresine polygon ağından 0.1 matic göndeririz.
![scanner](https://user-images.githubusercontent.com/73015593/177836404-4d78ae2b-5bdf-4c33-9d3b-a71b2f3d62d2.PNG)


[örnek bir initialize işlemi]
![forta](https://user-images.githubusercontent.com/73015593/177824269-4884af1d-bdd7-415d-91ed-0ae5907a9de2.PNG)

# Alchemy sitesine kayıt oluyoruz.
https://www.alchemy.com/ 


## Ekosistem olarak eth seçiyoruz
![eth](https://user-images.githubusercontent.com/73015593/177829152-b8b052f0-40b2-43ce-bee1-49733843575d.PNG)


## Create your first app geliyoruz ve network kısmından polygon mainnet seçiyoruz
![polygon](https://user-images.githubusercontent.com/73015593/177829550-41166ae8-f97e-4eb0-88c5-cb22bcef93a8.PNG)


## Dashboard kısmından HTTPS kısmını kopyalıyoruz.
![https](https://user-images.githubusercontent.com/73015593/177832725-630a6a67-8e05-4e70-9ecb-9a676d27c8c7.PNG)


## Config dosyamızı düzenliyoruz.
```
nano /root/.forta/config.yml
```

[İlk hali böyle]
![first](https://user-images.githubusercontent.com/73015593/177833283-5c397c6f-8dfc-4500-a687-18cad6723652.PNG)


## Alchemy'den kopyaladığımız linki url kısmına yapıştırıyoruz.Ardından ctrl x y ile kaydedip çıkıyoruz.

[ikinci hali böyle]

![second](https://user-images.githubusercontent.com/73015593/177834269-9b481759-09d6-4574-9d09-8ac01d967cff.PNG)


## Register işlemi yapıyoruz.Polygon adresi kısmına matic transferi yaptığımız metamask adresimiz.Şifre kısmına yukarıda oluşturduğumuz şifre bilgisini giriyoruz.
```
forta register --owner-address polygon-adresiniz --passphrase şifre
```
[Başarılı bir register işlemi]
![succes](https://user-images.githubusercontent.com/73015593/177836798-e06e2187-e661-42f5-9a69-e40f743d7b06.PNG)


## Forta için systemd servis dosyası oluşturuyoruz.Şifre kısmına yukarıda oluşturduğumuz şifremizi giriyoruz.
```
sudo tee /etc/systemd/system/quicksilverd.service > /dev/null <<EOF
[Unit]
Description=Forta
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Environment="FORTA_DIR=/root/.forta/"
Environment="FORTA_PASSPHRASE=şifre"
Restart=on-failure
RestartSec=15s

ExecStart=/usr/bin/forta run

[Install]
WantedBy=multi-user.target
EOF
```

## Forta servisimizi aktif hale getiriyoruz.
```
systemctl daemon-reload
systemctl enable forta
systemctl restart forta
```

## Forta servisimizi kontrol ediyoruz
[Başarılı çalışan bir servis]

![runnig](https://user-images.githubusercontent.com/73015593/177838547-34ab9d76-9d15-42bb-997a-751dde86fac5.PNG)

## Alchemy sitesinden gelen istek sayısını kontrol ediyoruz.
Total request kısmı ile 24 saatte gelen toplam istek sayısına bakıyoruz.
Success kısmı ile 24 saate gelen isteklerin başarı oranına bakıyoruz.
Alt kısımdaki 1 min ago gibi kısımlar ile anlık gelen istekleri izliyoruz.
![alchemy](https://user-images.githubusercontent.com/73015593/177838935-b73d53e6-87ec-47ca-8048-c3446e90c21a.PNG)

# Yararlı komutlar

## Scanner node adresi öğrenmek için : 
```
forta account address
```
![addres](https://user-images.githubusercontent.com/73015593/177840005-f080802f-72d2-432c-b798-2732934b69ba.PNG)


## Forta node durumuna bakmak için : 
```
forta status
```
![status](https://user-images.githubusercontent.com/73015593/177840234-53fd87e7-8b2e-4452-82b8-6dbae1922895.PNG)


## Forta loglarına bakmak için : 
```
journalctl -u forta -f -o cat
```
![journal](https://user-images.githubusercontent.com/73015593/177840454-2d702260-a95e-4600-a5ff-147008148227.PNG)


## Forta durdurmak için : 
```
systemctl stop forta
```

# Forta başlatmak için : 
```
systemctl start forta
```

# Testnet ödülleri kontrol etmek için : (FORTA_SCANNER_ADDRESS) kısmına scanner adresimizi giriyoruz.
```
curl https://api.forta.network/stats/sla/scanner/FORTA_SCANNER_ADDRESS?startTime=2022-04-24T00:00:00Z | jq .statistics.avg
```
100% ödül: SLA ≥ 0.9
80% ödül: SLA ≥ 0.75
0% ödül: SLA < 0.75

![curl](https://user-images.githubusercontent.com/73015593/177841904-155f95da-cef5-4ad8-9feb-9be12402eb85.PNG)











