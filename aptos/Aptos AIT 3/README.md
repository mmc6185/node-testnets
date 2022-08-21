# <h1 align="center">Aptos AIT 3</h1>

![aptos](https://user-images.githubusercontent.com/73015593/177651583-9bfbdf15-79ee-447e-8442-5230a47fefff.jpg)

# Testnet detayları
Aptos AIT 3 testnetine dünya genelinden 225 kişi seçilecek.Her bir katılımcı 800 aptos token kazanacak. Daha iyi performans gösteren bazı katılımcılar ek 200 aptos token daha kazanacak.

[Discord](https://discord.gg/zJURJRB5) 

[Daha fazla detay için medium makalesi](https://aptoslabs.medium.com/welcome-to-aptos-incentivized-testnet-3-9d7ce888205c)


# Sistem gereksinimleri
```
CPU: 8 cores, 16 threads
2.8GHz, or faster
Memory: 32GB RAM.
Disk: 300GB ssd 
```

# Node kurulumu

## 1- root yetkisi kazanırız.
```
sudo su
```

## 2- root dizini altına gideriz.
```
cd /root
```

## 3- Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```

## 4- Gerekli kütüphanelerin kurulumunu yapıyoruz.
```
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony unzip liblz4-tool -y
```

## 5- Docker kurulumu yapıyoruz.
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## 6- Docker compose kurulumu yapıyoruz.
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## 7- Aptos'u indiriyoruz.
```
wget -qO aptos-cli.zip https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-v0.3.1/aptos-cli-0.3.1-Ubuntu-x86_64.zip
unzip -o aptos-cli.zip
chmod +x aptos
mv aptos /usr/local/bin
```

## 8- Varsayılan kullanıcımızın ana dizininde aptoss isimli bir dizin oluşturuyoruz (Bizde root) ve içine giriyoruz.
```
mkdir -p ~/aptoss
cd ~/aptoss
```

## 9- validator.yaml ve docker-compose.yaml config dosyalarını indiriyoruz.
```
cd ~/aptoss
wget https://raw.githubusercontent.com/mmc6185/node-testnets/main/aptos/Aptos%20AIT%203/docker-compose.yaml
wget https://raw.githubusercontent.com/mmc6185/node-testnets/main/aptos/Aptos%20AIT%203/validator.yaml
```

## 10- ~/aptoss/keys dizinimizde node owner key, consensus key ve networking key Oluşturuyoruz.
```
aptos genesis generate-keys --output-dir  ~/aptoss/keys
```
![image](https://user-images.githubusercontent.com/73015593/185751077-6dddccd4-83d4-43f4-8b1f-0d80d51642bf.png)

## 11- Validator bilgilerini yapılandırıyoruz. NodeName kısmına node ismimizi giriyoruz. ~/aptoss klasörü altında girdiğimiz NodeName ile bir klasör oluşuyor.
```
IPADDR=$(curl icanhazip.com)
cd ~/aptoss
aptos genesis set-validator-configuration \
    --local-repository-dir ~/aptoss \
    --username NodeName \
    --owner-public-identity-file ~/aptoss/keys/public-keys.yaml \
    --validator-host $IPADDR:6180 \
    --stake-amount 100000000000000
```
![image](https://user-images.githubusercontent.com/73015593/185748828-5cb506b1-a2a0-447c-a00b-f5f3b8f89414.png)

## 12- Aptos validatorSet'teki node'u tanımlayan layout.yaml dosyası oluşturuyoruz. NodeName kısmına validator bilgilerini yapılandırırken girdiğimiz ismi giriyoruz.
```
echo "root_key: "D04470F43AB6AEAA4EB616B72128881EEF77346F2075FFE68E14BA7DEBD8095E"
users: ["NodeName"]
chain_id: 43
allow_new_validators: false
epoch_duration_secs: 7200
is_test: true
min_stake: 100000000000000
min_voting_threshold: 100000000000000
max_stake: 100000000000000000
recurring_lockup_duration_secs: 86400
required_proposer_stake: 100000000000000
rewards_apy_percentage: 10
voting_duration_secs: 43200
voting_power_increase_limit: 20" >layout.yaml
```
![image](https://user-images.githubusercontent.com/73015593/185750753-2ab59e84-c10b-4360-a9cb-97d78d7182cf.png)

## 13- AptosFramework Move paketini ~/$aptoss dizinine framework.mrb olarak indiriyoruz.
```
wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.3.0/framework.mrb -P ~/aptoss
```
![image](https://user-images.githubusercontent.com/73015593/185749237-651894d3-6376-46bb-8520-5a480a5e116a.png)

## 14- Genesis blob ve waypoint compile ediyoruz.
```
aptos genesis generate-genesis --local-repository-dir ~/aptoss --output-dir ~/aptoss
```
![image](https://user-images.githubusercontent.com/73015593/185750839-65aee241-32c1-4b1b-9064-8493f9efb374.png)

## 15- Docker başlatıyoruz.
```
docker-compose down -v
docker-compose up -d
```

## 16- Sitemize giderek aptos node durumumuza bakıyoruz [LINK](https://node.aptos.zvalid.com/). (Görseldeki gibi bir çıktı almanız lazım)
![image](https://user-images.githubusercontent.com/73015593/185756564-77fc1420-da9a-4f23-9de6-c384737a2d75.png)

# Testnet registration
## 1- Tüm işlemler doğruysa [aptoslabs](https://aptoslabs.com/community) sitesine giderek GET STARTED diyoruz.
![image](https://user-images.githubusercontent.com/73015593/185756923-95c0e568-8d17-4491-9b08-15831da44151.png)

## 2- Aptos lab github'ından petra wallet indiriyoruz. [LINK](https://github.com/aptos-labs/aptos-core/releases/download/wallet-v0.1.6/wallet-extension.zip)

## 3- İndirdiğimiz zipli klasörü winrar gibi bir unzip aracı ile çıkartıyoruz. 
![image](https://user-images.githubusercontent.com/73015593/185758793-4347bfd8-587f-41e2-897c-e32daf5b99f8.png)

## 4- Connect wallet kısmı için wallet eklememiz gerekiyor.
![image](https://user-images.githubusercontent.com/73015593/185757229-7d458615-2666-4a3d-81e9-953c7fd1e694.png)

## 5- (Chrome extensions)[chrome://extensions/] adresine gidiyoruz.

## 6- Sağ üstten geliştirici modunu açıyoruz.
![image](https://user-images.githubusercontent.com/73015593/185757293-4e716003-bfd6-4a85-8945-25aa3d830873.png)

## 7- Sol üstten paketlenmemiş öğe yükle seçiyoruz. ve zipten çıkardığımız cüzdan klasörünü yüklüyoruz.(varsayılan klasör ismi build)
![image](https://user-images.githubusercontent.com/73015593/185757360-2a15e493-bbe1-45f4-a001-a9cc1357e422.png)

## 8- Petra Aptos wallet eklentilerde gözüküyor. Ardından cüzdan oluşturuyoruz. [aptoslabs](https://aptoslabs.com/it3) sitesine giderek cüzdanımızı bağlıyoruz. 
![image](https://user-images.githubusercontent.com/73015593/185758968-1553f391-6703-4be2-b63a-00b48af88de7.png)

## 9- NODE REGISTRATION kısmında gireceğimiz bilgileri öğreniyoruz. (NodeName kısmına kendi klasör ismimizi giriyoruz. API PORT Kısmına 80 yazıyoruz.)
```
cat $HOME/aptoss/NodeName/operator.yaml
```
<img width="679" alt="walet" src="https://user-images.githubusercontent.com/73015593/185760465-ef7f2257-2164-41de-a427-e8729caf9e54.png">

# Ek komutlar

## 1- Loglara bakmak için
```
docker logs -f aptos-fullnode --tail 50
```

## 2- Node sync durumuna bakmak için
```
curl 127.0.0.1:9101/metrics 2> /dev/null | grep aptos_state_sync_version | grep type
```









