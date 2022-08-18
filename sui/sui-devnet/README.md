# <h1 align="center">Sui devnet (full node)</h1>

![sui](https://user-images.githubusercontent.com/73015593/178133251-a0ed4307-3cc5-4aab-b929-280afc1788d2.jpg)

## Sistem gereksinimleri
```
8GB RAM
50 GB SSD
2 vCPU
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

## Kütüphane kurulumu yapıyoruz.
```
sudo apt install tzdata git ca-certificates curl build-essential libssl-dev pkg-config libclang-dev cmake jq -y
```

## Rust kurulumu yapıyoruz.1 diyerek Proceed with installation (default) kurulumu yapıyoruz.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```
![rust](https://user-images.githubusercontent.com/73015593/178137185-c538518e-94ba-42e7-9ddb-fd7c93452a58.PNG)

## Rust sürümünü kontrol edelim.
```
rustc --version
```
[rustc 1.62.0 çıktısı alıyoruz]

![version](https://user-images.githubusercontent.com/73015593/178137217-5ecb4d32-7905-48a4-bf22-c80da0b6d3e6.PNG)

## Sui'nin github dosyasını sui repository'den sunucumuza klonluyoruz.
```
git clone https://github.com/MystenLabs/sui.git
```
![git](https://user-images.githubusercontent.com/73015593/178137523-b43c98cd-9288-4d2a-941b-266c1e06e1ec.PNG)

## sui dizinine giriyoruz
```
cd sui
```

## sui repository'i uzak sunucuya bağlıyoruz.
```
git remote add upstream https://github.com/MystenLabs/sui
```

## fork'umuzun sync olmasını sağlıyoruz.
```
git fetch upstream
```
![fetch](https://user-images.githubusercontent.com/73015593/178137878-9255c113-24e0-47fb-bab9-2d9448523681.PNG)

## Sui devnet için branch kontrol ediyoruz.
```
git checkout --track upstream/devnet
```
![branch](https://user-images.githubusercontent.com/73015593/178138016-880e22bd-6de9-4b72-a965-e5676e4895bf.PNG)

## full node config dosyasını kopyalıyoruz.
```
cp crates/sui-config/data/fullnode-template.yaml fullnode.yaml
```

## güncel genesis.blob dosyasını indiriyoruz.
```
curl -fLJO https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
```
![genesis](https://user-images.githubusercontent.com/73015593/178141517-29ed3adb-1c6e-4efe-87d6-ae1ee9572ce7.PNG)

## tmux terminal oturumu aracımızı indiriyoruz.
```
sudo apt install tmux
```
![tmux](https://user-images.githubusercontent.com/73015593/178141714-fb755163-012e-4a23-9e1f-2a82369b5659.PNG)

## sui isimli bir tmux oturumu açıyoruz. 
```
tmux new -s sui
```

## sui-node isimli binary dosya oluşturuyoruz. (Bu uzun bir süre alabilir.)
```
cargo build --release -p sui-node
```
![BUİLD](https://user-images.githubusercontent.com/73015593/178142310-ebcb9588-8ef8-412e-9653-4187da32348d.PNG)

## Kurulum tamamlandıktan sonra ctrl+b d tuşları ile tmux'tan çıkıyoruz.

## sui servis dosyasını oluşturuyoruz.
```
echo "[Unit]
Description=Sui
After=network.target

[Service]
User=root
Type=simple
ExecStart=/usr/local/bin/sui --config-path $HOME/sui/fullnode.yaml
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/suid.service
mv $HOME/suid.service /etc/systemd/system/

sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
```

## Servisimizi aktifleştiriyoruz.
```
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl restart suid
```

## Kurulum tamamlandıktan sonra [explorerdan](https://node.sui.zvalid.com/) kendimizi kontrol ediyoruz.
![image](https://user-images.githubusercontent.com/73015593/185306232-bb0734f1-6879-442a-98de-6b7eb6602fb6.png)

# Yararlı komutlar

## Node durumumuza bakmak için : 

## logları izlemek için: 
```
journalctl -fu suid -o cat
```

## tmux oturumlarını listelemek için:
```
tmux ls
```
![tmuxls](https://user-images.githubusercontent.com/73015593/178143796-39bf0cc7-7bdb-4fee-93e8-5b96c69bc8d4.PNG)

##  belirli bir tmux oturumuna girmek için (session_name kısmına girmek istediğiniz oturumu yazın. örnek: sui): 
```
tmux attach-session -t sui
```

## Servis başlatmak için: 
```
systemctl start suid
```

## Servis durdurmak için:
```
systemctl stop suid
```

## Servis tekrar başlatmak için:
```
systemctl stop suid
```

## Servis durumuna bakmak için:
```
service suid status
```





