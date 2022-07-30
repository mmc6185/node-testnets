# <h1 align="center">Stratos SDS</h1>

![stratos](https://user-images.githubusercontent.com/73015593/177883166-54990a2a-2b9d-4e27-9559-0aed1c36f3f8.jpg)

# Node kurulumu 

## root yetkisi kazanıyoruz.
```
sudo su
```

## root dizinine gidiyoruz.
```
cd /root
```

## Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```
![image](https://user-images.githubusercontent.com/73015593/180839997-c55fa8b7-8938-4749-a249-c0d066b0e39c.png)

## Kütüphane kurulumu yapıyoruz.
```
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```

## Go kurulumu yapıyoruz.
```
wget -O go1.18.2.linux-amd64.tar.gz https://golang.org/dl/go1.18.2.linux-amd64.tar.gz 
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz && rm go1.18.2.linux-amd64.tar.gz 
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile 
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile 
echo 'export GO111MODULE=on' >> $HOME/.bash_profile 
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile 
go version 
```

## source code ile binary dosyayı derliyoruz.
```
cd $HOME
git clone https://github.com/stratosnet/sds.git
cd ~/sds
git checkout v0.8.1
make build
cp target/ppd $HOME/bin
```
![image](https://user-images.githubusercontent.com/73015593/180841281-fc0803b8-7b24-4d6e-b435-292c4b3eb3b9.png)

## $GOPATH/bin altında Binary dosya oluşturuyoruz.
```
make install
```

## Node dosyası oluşturup yapılandırıyoruz. 
1- Numaralı yere şifre giriyoruz.
2- Numaralı yere cüzdan ismimizi giriyoruz.
3- numaralı yere input bip39 Eğer eski cüzdan kullanmak istiyorsak mnemonic giriyoruz. Yeni cüzdan oluşturmak için enter basmamız yeterli.
4- numaralı yere enter basıyoruz.
5- numaralı yere y giriyoruz.
```
cd $HOME
mkdir rsnode
cd rsnode
ppd config -w -p
```
![image](https://user-images.githubusercontent.com/73015593/180845362-f87832db-9715-4dec-8d3f-4889428b27ce.png)

## config dosyasına giriyoruz.
```
nano $HOME/rsnode/configs/config.toml
```

## Versiyon kısmı aşağıdaki gibi değilse düzenliyoruz.
```
[version]
  app_ver = 8
  min_app_ver = 8
  show = 'v0.8.1'
```
![image](https://user-images.githubusercontent.com/73015593/181843359-8a3f68c4-f195-4d3a-8124-9da79257bad3.png)

## stratos_chain_url kısmını aşağıdaki gibi değilse düzenliyoruz.
```
stratos_chain_url = 'https://rest-tropos.thestratos.org:443' 
```
![image](https://user-images.githubusercontent.com/73015593/180859039-fd0e7d3e-72d8-44bf-ac9f-8ae7c516e27e.png)

## [sp-list] yani meta node'ları aşağıdaki gibidüzenliyoruz.
```
[[sp_list]]
p2p_address = 'stsds1mr668mxu0lyfysypq88sffurm5skwjvjgxu2xt'
p2p_public_key = 'stsdspub1zcjduepq4v8yu6nzem787nfnwvzrfvpc5f7thktsqjts6xp4cy4a2j4rgm7sgdy4zy'
network_address = '35.73.160.68:8888'
[[sp_list]]
p2p_address = 'stsds1ftcvm2h9rjtzlwauxmr67hd5r4hpxqucjawpz6'
p2p_public_key = 'tsdspub1zcjduepqq9rk5zwkzfnnszt5tqg524meeqd9zts0jrjtqk2ly2swm5phlc2qtrcgys'
network_address = '46.51.251.196:8888'
[[sp_list]]
p2p_address = 'stsds12uufhp4wunhy2n8y5p07xsvy9htnp6zjr40tuw'
p2p_public_key = 'stsdspub1zcjduepqkst98p2642fv8eh8297ppx7xuzu7qjz67s9hjjhxjxs834md7e0s5rm3lf'
network_address = '18.130.202.53:8888'
[[sp_list]]
p2p_address = 'stsds1wy6xupax33qksaguga60wcmxpk6uetxt3h5e3e'
p2p_public_key = 'stsdspub1zcjduepqyyfl7ljwc68jh2kuaqmy84hawfkak4fl2sjlpf8t3dd00ed2eqeqlm65ar'
network_address = '35.74.33.155:8888'
[[sp_list]]
p2p_address = 'stsds1nds6cwl67pp7w4sa5ng5c4a5af9hsjknpcymxn'
p2p_public_key = 'stsdspub1zcjduepq6mz8w7dygzrsarhh76tnpz0hkqdq44u7usvtnt2qd9qgp8hs8wssl6ye0g'
network_address = '52.13.28.64:8888'
[[sp_list]]
p2p_address = 'stsds1403qtm2t7xscav9vd3vhu0anfh9cg2dl6zx2wg'
p2p_public_key = 'stsdspub1zcjduepqzarvtl2ulqzw3t42dcxeryvlj6yf80jjchvsr3s8ljsn7c25y3hq2fv5qv'
network_address = '3.9.152.251:8888'
[[sp_list]]
p2p_address = 'stsds1hv3qmnujlrug00frk86zxr0q23rnqcaquh62j2'
p2p_public_key = 'stsdspub1zcjduepqj69eeq07yfdgu4cdlupvga897zjqjakuru0qar5na7as4kjr7jgs0k7aln'
network_address = '18.223.175.117:8888'
```
![image](https://user-images.githubusercontent.com/73015593/180858395-b9adda1e-41a0-40b2-92ea-b75ff77150ef.png)

## chain_id kısmını tropos-4 olarak ayarlı değilse düzenliyoruz.
```
chain_id = 'tropos-4'
```
![image](https://user-images.githubusercontent.com/73015593/180858499-32f8ea8c-1ca8-43c3-945b-90843fedf75c.png)

## network_address kısmına kendi ip adresimizi aşağıdaki gibi düzenliyoruz.
```
network_address = 'your node external ip' 
```
![image](https://user-images.githubusercontent.com/73015593/180859350-2f671d71-31f5-47a1-98ae-d9d0cf93b546.png)

## Son olarak config.toml dosyası aşağıdaki gibi gözükür.
![image](https://user-images.githubusercontent.com/73015593/180859798-456e15cd-fd1b-4a66-a6a0-2dba8d6ae212.png)

## Faucetten token alıyoruz. WalletAddress kısmına cüzdan adresimizi yazıyoruz.
```
curl --header "Content-Type: application/json" --request POST --data '{"denom":"ustos","address":"WalletAddress"} ' https://faucet-tropos.thestratos.org/credit

```

## tmux kurulumu yapıyoruz.
```
apt-get install tmux
```

## sds isimli bir oturum oluşturuyoruz.
```
tmux new-session -s sds
```

## sds resource node başlatıyoruz. (please register at first çıktısı almamız gerekiyor.)
```
cd ~/rsnode
ppd start
```
![image](https://user-images.githubusercontent.com/73015593/180861862-5d26d766-ec76-43f1-bdfa-4a7376f7597c.png)

## ctrl+b d ile çıkıyoruz.

## screen aracımızı yüklüyoruz.
```
apt-get install screen
```

## terminal isimli bir screen oluşturuyoruz.
```
screen -S terminal
```

## resource node ile etkileşim kurabilmek için ek terminal açıyoruz.
```
cd ~/rsnode
ppd terminal
```
![image](https://user-images.githubusercontent.com/73015593/180884393-d57cb317-7455-4efc-b420-2316079d09b7.png)


## registerpeer işlemi yapıyoruz.Aşağıdaki gibi registered as PP successfully çıktısı almamız gerekli.
```
registerpeer
```
![image](https://user-images.githubusercontent.com/73015593/180886132-985304e7-ba5b-4819-9276-c0de0803f22f.png)

## activate işlemi yapıyoruz. (activate amount fee gas)
```
activate 10000000000 10000 1000000
```
![image](https://user-images.githubusercontent.com/73015593/180886338-cd37ffd5-28c2-450d-8848-7d93eb2a2d46.png)

## Node durumumuza bakıyoruz.
```
status
```
![image](https://user-images.githubusercontent.com/73015593/180886576-fdd002ee-6e73-4270-a8bb-89ee9f89bcf1.png)

## Kazandığımız ödülleri tarayıcıdan kontrol etmek için (cüzdanAdresi kısmına cüzdan adresimizi yazıyoruz):
--Utros stos'un 1.000.000.000 da 1 ine eşit.

https://rest-tropos.thestratos.org/pot/rewards/wallet/cüzdanAdresi
![image](https://user-images.githubusercontent.com/73015593/180897082-3142e697-2280-4f94-bf92-8b6d6f1dce34.png)

# Ek komutlar 
  
## Ozon almak için: (purchaseAmount kısmına ustos ile alacağımız miktar, fee amount kısmına fee miktarı, gasAmount kısmına gas yazıyoruz.) 
Ozon, SDS tarafından kullanılan trafik birimidir. Ağ trafiğini içeren işlemler, ozonun yürütülmesini gerektirir. 
--prepay <purchaseAmount> <feeAmount> <gasAmount>
```
prepay 500000000 10000 1000000
```
  
## Cüzdandaki ozon miktarını sorgulamak için: (walletAddress kısmına cüzdan adresini yazıyoruz.)
```
getoz walletAddress
```
![image](https://user-images.githubusercontent.com/73015593/180892216-e1a18eb4-d5f1-4cef-9044-a55bb44694f6.png)

## Dosya yüklemek için (PATH kısmına dosyanın dizinin yapıştırırız.):
```
put PATH
```
![image](https://user-images.githubusercontent.com/73015593/180891673-c52a20e7-9e30-4f00-b136-425c2ddab412.png)

## Dosya indirmek için (SHARE_LINK kısmına dosya hash'ini yazıyoruz.PASSWORD kısmına ise eğer dosya şifreli paylaşılmışsa şifre bilgisini yazıyoruz.):
```
getsharefile SHARE_LINK PASSWORD
```
![image](https://user-images.githubusercontent.com/73015593/181343895-d5f198fb-f264-485c-ab34-fa617c34731d.png)

## Yüklenen dosyaları listelemek için:
```
ls
```
![image](https://user-images.githubusercontent.com/73015593/180892343-03354dde-c8c8-4bff-9bbc-b120c586cd62.png)
  
## Yüklenen dosyayı paylaşmak için:
FILE_HASH kısmına dosya hash'i gireceğiz.
EXPIRY_TIME kısmına ne kadar süre sonra yok olacağını giriyoruz. (0 girersek dosya paylaşımı sonsuza kadar kalıcı olur.)
PRIVATE kısmına dosyanın gizli veya public olacağını yazıyoruz. (0 girersek şifresiz, 1 ise şifreli)
sharefile FILE_HASH EXPIRY_TIME PRIVATE
```
sharefile v05ahm52mafaujmvqodbnj2u4ld0edm611nlqp58 0 0 
```
![image](https://user-images.githubusercontent.com/73015593/180892716-a0e12f19-087a-412c-9c6e-9c37ae77612f.png)

## Tüm paylaşılan dosyaları listelemek için:
```
allshare
```
![image](https://user-images.githubusercontent.com/73015593/180893298-e33565f6-3683-445e-8147-297624d4877d.png)

## Yüklenen bir dosya silmek için. (FILE_HASH kısmındda dosya'nın hashini giriyoruz)
```
delete FILE_HASH
```

## Mining:SUSPEND olunca (Bu hatanın sebebi Node'umuzun kötü performans sergilemesi.)
Activation: Active | Mining: SUSPEND | Initial tier: 2 | Ongoing tier: 0 | Weight score: 8000
updateStake <stakeDelta> <fee> <gas> <isIncrStake> 

```
updateStake 1000000000 10000 1000000 1
```

## Dosya paylaşımını durdurmak için ShareId kısmına share id mizi yazıyoruz.:
```
cancelshare ShareId
``` 
  
## Kaynak kullanımını görüntülemek için:
```
monitor
```
![image](https://user-images.githubusercontent.com/73015593/180893837-c42d93e5-27cc-4a18-bc7b-61ef2884db6b.png)

## Kaynak kullanımı görüntülemesini kapatmak için:
```
stopmonitor
```
  
## Cüzdan adreslerini listelemek için:
```
wallets
```
![image](https://user-images.githubusercontent.com/73015593/180893952-b91def6b-5a4a-4115-9892-dcb07727e3a5.png)

 
# (opsiyonel) SCRIPT Otomatik dosya oluşturup yükleme (ödül almak için gerekli değil):

## Ozon alımı yapıyoruz. (Eğer cüzdanımızda 1 token varsa)
```
prepay 1000000000 10000 600000
```
  
## Ozon alımının başarılı olup olmadığını kontrol ediyoruz. WalletAddress kısmına cüzdan adresimizi yazıyoruz.
```
getoz walletAddress
```
![image](https://user-images.githubusercontent.com/73015593/180888582-96417f6d-b58f-49c5-90e3-93bb057b43a9.png)  
  
## ctrl+a d ile terminal screen den çıkıyoruz.  

## upload isimli bir screen oluşturuyoruz.
```
screen -S upload
```

## upload isimli bir klasör oluşturuyoruz.
```
mkdir -p ~/upload
```
  
## upload.sh script'i oluşturuyoruz.
```
nano $HOME/rsnode/upload.sh
```
  
## script komutlarımızı yapıştırıyoruz ardından ctrl x y ile kaydedip çıkıyoruz.
```
#!/bin/bash
while true;
do /usr/bin/head -c 25M /dev/urandom > "$HOME/upload/test-$(date '+%Y%m%d%H%M')" ; ppd terminal exec put "$HOME/upload/test-$(date '+%Y%m%d%H%M')";
sleep 900;
/usr/bin/rm -rf "$HOME/upload/test*";
sleep 1;
done
```
![image](https://user-images.githubusercontent.com/73015593/180889190-01fd7b22-c6c9-422d-8958-47d057115474.png)
  
## upload.sh dosyasına executuble yetkisi veriyoruz.
```
cd $HOME/rsnode
chmod +x upload.sh 
./upload.sh
```
![image](https://user-images.githubusercontent.com/73015593/180891088-2c2bd036-0f4c-4f00-becd-c3ecb0e8f67b.png)
















































