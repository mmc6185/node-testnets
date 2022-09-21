# <h1 align="center">Massa testnet 14</h1>

![massa](https://user-images.githubusercontent.com/73015593/180018941-20b9e515-6e94-47ef-b928-b8e3ba507691.jpg)

# Linkler
> ## [Discord](https://discord.gg/J7scURTM)<br>
> ## [Massa website](https://massa.net/)
> ## [Massa explorer](https://paranormal-brothers.com/massa/)

# Sistem gereksinimleri
```
8GB RAM
50-100 GB SSD
4 vCPU
```

# Node kurulumu

## Sistem güncellemesi yapıyoruz.
```
sudo apt update && sudo apt upgrade -y
```
![image](https://user-images.githubusercontent.com/73015593/180020260-2774f980-3211-458b-afe3-230f8dc89a34.png)


## Kütüphane kurulumu yapıyoruz.
```
sudo apt install make clang curl pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```
![image](https://user-images.githubusercontent.com/73015593/180020703-faa62886-4328-45a2-9136-37d70a097f1c.png)

## Rust kurulumu yapıyoruz. 1 diyerek Proceed with installation (default) kurulumu yapıyoruz.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```
![image](https://user-images.githubusercontent.com/73015593/180025712-25d76b2a-72f4-43ee-abf2-6bdb110359bc.png)

## Rust sürümünü kontrol edelim.
```
rustc --version
```
![image](https://user-images.githubusercontent.com/73015593/180025948-fa63daf2-5b2e-4de5-8e55-05b46f3a1cbc.png)

## nightly indiriyoruz.
```
rustup toolchain install nightly
```
![image](https://user-images.githubusercontent.com/73015593/180026786-c0cfc916-1f77-4834-9c20-08720564f10d.png)

## varsayılan olarak ayarlıyoruz.
```
rustup default nightly
```

## massa repository'den `massa 14.7` binary dosyasını indiriyoruz.
```
wget -O massa.tar.gz https://github.com/massalabs/massa/releases/download/TEST.14.7/massa_TEST.14.7_release_linux.tar.gz
tar -xzf massa.tar.gz
rm massa.tar.gz
```

## Servis dosyası oluşturuyoruz. `[PASSWORD]` kısmına cüzdan şifremizi giriyoruz.
```
echo "[Unit]
Description=Massa Node
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/massa/massa-node/
ExecStart=$HOME/massa/massa-node/massa-node -p [PASSWORD]
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/massa-node.service
sudo mv $HOME/massa-node.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
```

## `HOME/massa/massa-node/base_config/config.toml` dosyamıza giriyoruz.
```
nano $HOME/massa/massa-node/base_config/config.toml
```

## bootstrap kısmını yeni bootstrap listesi ile değiştiriyoruz.
```
[bootstrap]
bootstrap_list = [
  ["136.169.209.154:31245", "P12DvjzCo18r1iDnzYx184cjwHFfKBGBS3q3EZi9dbkMK3ekHKmy"],
  ["95.217.238.124:31245", "P12HG92SY91i9ys8PTe4RT1AinhU4gthnGvBXVBxY94GmQR6omox"],
  ["65.108.199.30:31245", "P12HdkAyvLiF6j8ncFg1SBYgXSGVT5XizSbi1yW8HuvdNTHMfdKe"],
  ["5.161.69.66:31245", "P12L1TF5Zp29XzmCJLa1Pf1a3CWsd1z2VrzgzJE2UAoJjEGiezvY"],
  ["38.242.146.57:31245", "P12Q6HdZcJz7VDD8gYJEBWJPeEBt7Ek4X9XB4pJXLeZ1qxVWrEnt"],
  ["65.21.253.220:31245", "P12R3PdzS6bFQavnir6fJggaE6ZgCBecaMVoSV37qzeUCUyyzWC9"],
  ["143.110.155.106:31245", "P12RSNkU3AnfWbvZJbNg2Pd1hGXmWEmQsnPhDEaEKN2tvJFSTykr"],
  ["34.168.83.156:31245", "P12SCauSSFRxQtRZqSRs8QV7D3LeCqEHTWiHvgqEtQjeJFnmr1qB"],
  ["149.202.86.103:31245", "P12UbyLJDS7zimGWf3LTHe8hYY67RdLke1iDRZqJbQQLHQSKPW8j"],
  ["167.86.97.154:31245", "P12eA2MSqC9wjBYgUK979Ljgy4Yc5Wwi61jvCoqSWS4yyjmZd79d"],
  ["65.21.244.128:31245", "P12fvZYCCZ8dn2GUFgZXSE7wi6aC5yeRTTWxtDqa5CwS7aW38VkP"],
  ["81.169.219.19:31245", "P12gUxiNsHQXnEX4bJJobnEYAbDWUwciqT9aYEFhxhfj6v3QB2uE"],
  ["82.66.154.222:31245", "P12jXXz4e4RpdKz7BDVH3qwAHrJUmhoF8AQwRCD2Gq26PkzPktKH"],
  ["185.182.184.7:31245", "P12ny3DgX9WnJCgAM18EXuFASatArwLj887cGMyL1pgnjGJuq7sg"],
  ["65.108.219.193:31245", "P12o4b3KRxFthRbpwxL2ASpWuJ8f2Q66cwrPzuH1Gxg2Xu8E1B6T"],
  ["5.161.61.170:31245", "P12osCLF2Ft8TUs3XRaXKFxuMx7fo2PEQSY2kn2VBDoXJtt36dUM"],
  ["158.69.120.215:31245", "P12rPDBmpnpnbECeAKDjbmeR19dYjAUwyLzsa8wmYJnkXLCNF28E"],
  ["149.202.89.125:31245", "P12vxrYTQzS5TRzxLfFNYxn6PyEsphKWkdqx2mVfEuvJ9sPF43uq"],
  ["174.138.7.246:31245", "P12vyoenuRN9JorA56SMCxrv6sh1gpKWgYQc69t6LTZvVcXcop8A"],
  ["51.75.60.228:31245", "P13Ykon8Zo73PTKMruLViMMtE2rEG646JQ4sCcee2DnopmVM3P5"],
  ["88.141.159.77:31245", "P1HeDWFaJ36QeTSEMy9ANc39JpUq2co2mCqhsHCG4B3Zf9LJk1L"],
  ["161.97.162.180:31245", "P1MzX8FUo3NL1PvzxaVXY3QQhwk5YUTFr3DVMzdbFdtJo49uuFL"],
  ["95.217.12.175:31245", "P1Rbidb2ajhR7eQth7U9gmJSkMPG8qNG8yxDxarMCuWP74havqL"],
  ["82.64.216.7:31245", "P1Tk3m8bcdtnRtUtvHZ2875HDmsGL9sc1RDw2wzVvE1AgXiR8XG"],
  ["65.108.199.31:31245", "P1Wk2zouEMJQtphpbymY6hkcVUDf77GaAwZ9uQVEkkFcL45BxrQ"],
  ["158.69.23.120:31245", "P1XxexKa3XNzvmakNmPawqFrE9Z2NFhfq1AhvV1Qx4zXq5p1Bp9"],
  ["95.216.201.131:31245", "P1aP1LF27a15PPdB5QVki61EY5kkkN8UUKhGeQF25HRmFH4KFaU"],
  ["54.36.174.177:31245", "P1gEdBVEbRFbBxBtrjcTDDK9JPbJFDay27uiJRE3vmbFAFDKNh7"],
  ["82.64.84.25:31245", "P1gvaKFbbm9o9Cq9P7AJeeqnpWZ1wqvAoXp21nfPvvrhgPhkcai"],
  ["198.27.74.52:31245", "P1hdgsVsd4zkNp8cF1rdqqG6JPRQasAmx12QgJaJHBHFU1fRHEH"],
  ["38.242.201.8:31245", "P1jh5nytFZ3YFBArniYYUMmTSJXuwbSepwEN3LpTB6VmffprfmQ"],
  ["198.27.74.5:31245", "P1qxuqNnx9kyAMYxUfsYiv2gQd5viiBX126SzzexEdbbWd2vQKu"]
]
```
![image](https://user-images.githubusercontent.com/73015593/189427058-9bea2587-c585-4724-9ee2-c554cbd622d9.png)

## Servisimizi başlatıyoruz.
```
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable massa-node
sudo systemctl restart massa-node
```

## Daha önce wallet oluşturanlar eski wallet.dat dosyasını sunucuda `$HOME/massa/massa-client` dizini altına atıyoruz.
![image](https://user-images.githubusercontent.com/73015593/189427917-632b6ff0-cd0b-45ed-9181-7c8080973d1e.png)

## massa client başlatıyoruz. 
* `[walletpassword]` kısmına cüzdan şifremizi giriyoruz.
* --wallet $HOME/massa/massa-client/wallet.dat yerine daha önce cüzdan oluşturmadıysanız `wallet_generate_secret_key` girin.
```
cd $HOME/massa/massa-client/
./massa-client --wallet $HOME/massa/massa-client/wallet.dat -p [walletpassword]
```
![image](https://user-images.githubusercontent.com/73015593/189431398-7ad587a0-c9b1-46b2-b485-ee370ccf4c5a.png)

## [Massa Discord](https://discord.gg/J7scURTM)'una gidiyoruz. 
![image](https://user-images.githubusercontent.com/73015593/189432317-2044f944-e9ac-4f72-bf62-3d8a0911289a.png)

## #⌠✅⌡testnet-rewards-registration kanalına gidiyoruz ve rastgele bir mesaj atıyoruz. Ardından bot bize özelden mesaj atacak.
![image](https://user-images.githubusercontent.com/73015593/189432602-d46fae1f-01fb-4f06-9080-5f5ea50c7940.png)

## #⌠💸⌡testnet-faucet kanalına gidiyoruz ve cüzdan adresimizi gönderiyoruz. (Cüzdan bilgilerine bakmak için `wallet_info` komutunu gireriz.)
![image](https://user-images.githubusercontent.com/73015593/189433642-d563dec7-ef95-4044-b951-11274241c359.png)

## Gelen tokenler ile rol satın alıyoruz. (`walletAddress` kısmına cüzdan adresimizi giriyoruz.)
```
buy_rolls walletAddress 1 0
```
![image](https://user-images.githubusercontent.com/73015593/189447804-5c93be9d-eb6f-4eed-9a59-bf5963518aea.png)

## Bot'a sunucu ip adresimizi gönderiyoruz.
![image](https://user-images.githubusercontent.com/73015593/189433133-d69be7c4-0895-4e1d-83f7-d6888c7784a3.png)

## secret key'imizi kaydediyoruz. `secretKeys` kısmına wallet secret key'imizi giriyoruz. (Cüzdan bilgilerine bakmak için `wallet_info` komutu gireriz.) 
```
node_add_staking_secret_keys secretKeys 
```

## Testnete kayıt yaptırıyoruz. (`staking_address` kısmına cüzdan adresimizi, `discordId` kısmına discord Id mizi giriyoruz.) 
```
node_testnet_rewards_program_ownership_proof staking_address discordId
```
![image](https://user-images.githubusercontent.com/73015593/189438905-871ec8b4-6ef9-43cd-8245-b9cb747c6a78.png)

## Oluşan çıktıyı bota gönderiyoruz.
![image](https://user-images.githubusercontent.com/73015593/189439038-0189b397-dadb-42f6-aa0a-36bd40c2c826.png)

## Tüm her şeyi bot'a `info` yazarak kontrol edebiliriz.
![image](https://user-images.githubusercontent.com/73015593/189439183-a69e2f3b-de4c-4c05-9b0b-180639b4a86a.png)












