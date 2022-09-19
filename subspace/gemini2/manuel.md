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

## 8- Farmer için farmerd isimli bir servis oluşturuyoruz. (walletAddress kısmına ödül almak istediğimiz cüzdan adresimizi giriyoruz.plotSize kısmına plot boyutunu giriyoruz)
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

## 9- Farmer servisimizi başlatıyoruz.
```
sudo systemctl daemon-reload
sudo systemctl enable farmerd
sudo systemctl restart farmerd
```

## Node loglarımıza bakıyoruz. 
```
journalctl -u subspaced -f -o cat
```
![image](https://user-images.githubusercontent.com/73015593/191123736-54a27507-4911-42b4-ae37-2d685257ae38.png)






