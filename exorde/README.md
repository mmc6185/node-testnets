# Sistem gereksinimleri
```
CPU: 2 cores
Memory: 4 RAM.
Disk: 1GB ssd 
```
![image](https://user-images.githubusercontent.com/73015593/202112675-13d2fc93-5151-4dd8-b73e-a8860800e94a.png)


## 1- Ana dizine gidiyoruz.
```
cd $HOME
```

## 2- Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```

## 3- Gerekli kütüphanelerin kurulumunu yapıyoruz.
```
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony unzip liblz4-tool -y
```

## 4- Docker kurulumu yapıyoruz.
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## 5- Docker compose kurulumu yapıyoruz.
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## 6- Exorde CLI'ın son sürümünü zipli olarak indiriyoruz. 
```
wget https://github.com/exorde-labs/ExordeModuleCLI/archive/refs/heads/main.zip \
--output-document=ExordeModuleCLI.zip
```

## 7- Exorde CLI'ı zipten çıkartıyoruz.
```
unzip ExordeModuleCLI.zip \
&& rm ExordeModuleCLI.zip \
&& mv ExordeModuleCLI-main ExordeModuleCLI
```

## 8- Exorde CLI klasörüne giriyoruz. 
```
cd ExordeModuleCLI
```

## 9- Container image oluşturuyoruz.
```
docker build -t exorde-cli:latest .
```

## 10- Exorde CLI başlatıyoruz.
* (0 = no logs, 1 = general logs, 2 = validation logs, 3 = validation + scraping logs, 4 = detailed validation + scraping logs
```
docker run \
-d \
--restart unless-stopped \
--pull always \
--name exorde-cli \
rg.fr-par.scw.cloud/exorde-labs/exorde-cli -m <YOUR_MAIN_ADDRESS> -l <LOGGING_LEVEL>
```
![image](https://user-images.githubusercontent.com/73015593/202119649-70bcc244-ebac-45a0-a37b-942a89701d9c.png)





