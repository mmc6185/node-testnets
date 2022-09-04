# <h1 align="center">Meson Testnet</h1>

![meson](https://user-images.githubusercontent.com/73015593/178377476-0705f8ea-8bec-42f0-9b3a-cc6292151e73.jpg)

# Linkler
> ## [Discord](https://discord.gg/53KYA9gB)<br>
> ## [Meson network website](https://meson.network/)
> ## [Meson network explorer](https://dashboard.meson.network/)

# Node kurulumu

## [Kayıt](https://dashboard.meson.network/register) sitesinden kayıt işlemi yapıyoruz.
![register](https://user-images.githubusercontent.com/73015593/178377654-5a12e790-ee38-4f37-a983-42b9e9d426b2.jpg)

## Scriptimizi çalıştırıyoruz.
```
wget 'https://staticassets.meson.network/public/meson_cdn/v3.1.18/meson_cdn-linux-amd64.tar.gz' && tar -zxf meson_cdn-linux-amd64.tar.gz && rm -f meson_cdn-linux-amd64.tar.gz && cd ./meson_cdn-linux-amd64 && sudo ./service install meson_cdn
```
![script](https://user-images.githubusercontent.com/73015593/178378494-9335c2ad-25a7-41cd-ad69-0e9fcb5acb44.jpg)

## [user_node](https://dashboard.meson.network/user_node) sitesinden token adresimizi kopyalıyoruz. (Bir başkasınınkini kopyalamayın.Token adresi size özgüdür.)
![token](https://user-images.githubusercontent.com/73015593/178378901-c7c76fe6-e791-436e-b6ec-79c1e85f2b16.jpg)

## config ayarlıyoruz. tokenAddress kısmına yukarıda kopyaladığımız cüzdan adresimizi giriyoruz. cache.size disk boyutu ne kadar yüksek ayarlarsanız ödülünüz o kadar artar.
```
sudo ./meson_cdn config set --token=tokenAddress --https_port=443 --cache.size=30
```
![config](https://user-images.githubusercontent.com/73015593/178379194-e314e763-0de6-4d87-a6f7-2dc80e7faf3b.jpg)

## Portlara izin veriyoruz.
```
ufw allow 443
```

## Servisimizi başlatıyoruz.
```
sudo ./service start meson_cdn
```
![servis](https://user-images.githubusercontent.com/73015593/178379513-70a0410d-699a-4d63-9f6a-07791819318e.jpg)

## Günlük kazandığınız ödüllere [Günlük](https://dashboard.meson.network/reward/msntt) sitesine bakarak kontrol ediyoruz.
![today](https://user-images.githubusercontent.com/73015593/178380152-b77c93d4-e894-48fa-abd2-69a09950fd63.jpg)

## Çalışan node'larımıza [Node](https://dashboard.meson.network/user_node) sitesinden bakıyoruz.
![noe](https://user-images.githubusercontent.com/73015593/178380480-a619df99-836f-47e4-8c69-8da5d0eb94ec.jpg)

## Toplam kazandığımız ödüllere [Toplam](https://dashboard.meson.network/token_balance/msntt) sitesine bakarak kontrol ediyoruz.
![image](https://user-images.githubusercontent.com/73015593/178380566-db3022ce-70c1-4b27-b2a9-9d672c6f8b28.png)

## Servis kontrol etmek için:
```
sudo ./service status meson_cdn
```
![image](https://user-images.githubusercontent.com/73015593/178379654-6cd39c1f-8d06-4cde-a098-c3f746e38440.png)

## Servis durdurup node'u silmek için:
```
sudo ./service stop meson_cdn && sudo ./service remove meson_cdn
```


























