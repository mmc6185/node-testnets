# <h1 align="center">Supspace gemini 2</h1>

![image](https://user-images.githubusercontent.com/73015593/191116186-21c2e76a-1925-4d8d-98dd-f41239fac5f7.png)

> ## [Web Site](https://subspace.network/)
> ## [Subspace Explorer](https://telemetry.subspace.network/#list/)
> ## [Subspace Discord](https://discord.gg/97XHpF4p)


## 1- Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```

## 2- Gerekli kütüphanelerin kurulumunu yapıyoruz.
```
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony unzip liblz4-tool -y
```

## 3- Supspace node ve farmer binary dosyasalarını indiriyoruz.
```
cd $HOME
wget -qO subspace-node-ubuntu-x86_64-gemini-2a-2022-sep-10 https://github.com/subspace/subspace/releases/download/gemini-2a-2022-sep-10/subspace-node-ubuntu-x86_64-gemini-2a-2022-sep-10
wget -qO subspace-farmer-ubuntu-x86_64-gemini-2a-2022-sep-10 https://github.com/subspace/subspace/releases/download/gemini-2a-2022-sep-10/subspace-farmer-ubuntu-x86_64-gemini-2a-2022-sep-10
```

## 4- Binary dosyalarımıza execute yetkisi veriyoruz.
```
sudo chmod +x subspace-node-ubuntu-x86_64-gemini-2a-2022-sep-10
sudo chmod +x subspace-farmer-ubuntu-x86_64-gemini-2a-2022-sep-10
```

## 5- Binary dosyalarımızı `/usr/local/bin` altına taşıyoruz.
```
sudo mv subspace-node-ubuntu-x86_64-gemini-2a-2022-sep-10 /usr/local/bin/subspaceNode
sudo mv subspace-farmer-ubuntu-x86_64-gemini-2a-2022-sep-10 /usr/local/bin/subspaceFarmer
```

## 6- Node için subspaced isimli bir servis dosyası oluşturuyoruz. (NodeName kısmına kendi node isminizi yazın)
```
sudo tee <<EOF >/dev/null /etc/systemd/system/subspaced.service
[Unit]
Description=Supsapce Node
After=network.target

[Service]
User=$USER
ExecStart=$(which subspaceNode) --chain gemini-2a --execution wasm --state-pruning archive --validator --name NodeName
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## 7- Node servisimizi başlatıyoruz.
```
sudo systemctl daemon-reload
sudo systemctl enable subspaced
sudo systemctl restart subspaced
```

## 8- [Polkadot.js](https://chrome.google.com/webstore/detail/polkadot%7Bjs%7D-extension/mopnmbcafieddcagagdcbnhejhlodfdd) Cüzdan eklentisi tarayıcımıza indiriyoruz.
![image](https://user-images.githubusercontent.com/73015593/191125812-304eebe5-a9db-4418-bddd-ed97c986d938.png)

## 9- Cüzdan oluşturduktan sonra sağ üstten ayarlardan format şeklini subspace olarak seçiyoruz.Oluşan cüzdan adresini kopyalıyoruz.
![image](https://user-images.githubusercontent.com/73015593/191126053-abded3d2-5553-40ad-80dc-2e020380e3ff.png)

## 10- Farmer için farmerd isimli bir servis oluşturuyoruz. 
* walletAddress kısmına ödül almak istediğimiz cüzdan adresimizi giriyoruz.
* plotSize kısmına plot boyutunu giriyoruz. (100G girebilirsiniz)
```
sudo tee <<EOF >/dev/null /etc/systemd/system/farmerd.service
[Unit]
Description=Supsapce Node
After=network.target

[Service]
User=$USER
ExecStart=$(which subspaceFarmer) farm --reward-address walletAddress --plot-size plotSize
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## 11- Farmer servisimizi başlatıyoruz.
```
sudo systemctl daemon-reload
sudo systemctl enable farmerd
sudo systemctl restart farmerd
```

## 12- Node loglarımıza bakıyoruz. (Aşağıdaki gibi bir çıktı almanız lazım.)
```
journalctl -u subspaced -f -o cat
```
![image](https://user-images.githubusercontent.com/73015593/191123736-54a27507-4911-42b4-ae37-2d685257ae38.png)

## Sync kontrol etmek için : (isSynincg:false çıktısı almanız lazım)
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "system_health", "params":[]}' http://localhost:9933
```
![image](https://user-images.githubusercontent.com/73015593/191126248-714aee95-0824-4e36-aaa8-7acf2ce5c992.png)



