# <h1 align="center">Massa testnet 13</h1>

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

## massa repository'den `massa 13.0` binary dosyasını indiriyoruz.
```
wget -O massa.tar.gz https://github.com/massalabs/massa/releases/download/TEST.13.0/massa_TEST.13.0_release_linux.tar.gz
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
  ["90.91.163.193:31245", "P1275NJu5qAHum4rbqzRmamiM6J4srZ9oMMPADZfXE48cVpzVfYq"],
  ["65.108.231.87:31245", "P12GDLgmJcQ3Dw33XvPir7FEAKxa88vW9yFYGortHWUBR9cke347"],
  ["188.34.178.188:31245", "P12HEMn7EPqzqhCA2JyD9sEqT7hrgYqQaNWUaAYwgQezkBVUiQmN"],
  ["149.102.136.159:31245", "P12HQrPMdNKjeBAEobriJAvs4Jm33UQAgq5boqMrPfoJ5i9NSRSq"],
  ["81.220.162.85:31245", "P12NJhxBdwxhVqnfmyjYCnuFH37TZZXY12PVxwmZJ8CMdyy7JEte"],
  ["188.34.152.212:31245", "P12VNeLka3pMeh5e3zKWCR9BuWqgQH1AmqSvpkuwv2NnATb3deeZ"],
  ["212.83.179.55:31245", "P12ZRWLThP468gHYK97d3ubuiTFqtJKxEH5zQzV5UdbxTaK8CkFu"],
  ["164.68.125.184:31245", "P12h5MR4tZN81qYnTxU5kp4QvpeZAmcbBpxSoXLjeCQ4USKQsg9q"],
  ["209.145.52.66:31245", "P12jHacJDTWfPc3s4A3mg3UDbrg9JXXsNGT8jaonbf5YedJFjRth"],
  ["146.19.24.242:31245", "P12pEvmT2wZuZDuKKwR8GfTJ88PodWU3KSdUsrtWCJVhjxHwjFa3"],
  ["46.18.107.154:31245", "P12vNMSLsmv9zD9sL8H2PdLzSP5BbKTs9CopQWWMR1UouvKfN7X6"],
  ["135.181.74.113:31245", "P12wSpddFfzPa9ogsCoingouhaSSSkzQBruosNDotdkJxsniGk6d"],
  ["65.21.176.31:31245", "P14KVNFmk2EMoa6rD1FUzP3ME2NKsyhUkEve5ecxeC9tXQNsA6T"],
  ["144.126.156.119:31245", "P198WDDZVbU7NwiKSMZc4eXxsSEL1nv98A6Pjs375j4upxA7PkV"],
  ["65.108.148.151:31245", "P1AhLAuapebTXq6cCXdEdezqk4K5J4XfAiyFPcoWcn1Vs2hP2q9"],
  ["65.108.238.61:31245", "P1NZ83PuDSWopoLUbVEsW7UMg9XJ2eXgBNPjeLVQeUEWVXEdAUd"],
  ["86.195.187.151:31245", "P1XVCo4u8E2AisJsmj9oYkykCwqxud2zqMUWmdrLMh7dhwn2U16"],
  ["135.181.154.205:31245", "P1g2DuP2p24UmvfSH497J4f32zptiNHMdipCUMW9wdrEjaXeTp1"],
  ["149.102.153.191:31245", "P1gA4LJePQpwk9u2ui7AwbSRvVQeU98QS9dzub8wRh3WiX2rxZd"],
  ["139.177.190.178:31245", "P1gTzUqVHWHpJz6SZu7rnc1SCfK3zZN5ycA42PHnCNsPsG95F32"],
  ["5.161.83.44:31245", "P1kFis14TeyQdFa3tmgS8dxQK1RpYC2gtUBdtpX3peBcxi2vGuA"],
  ["158.247.203.237:31245", "P1mcZJf3os5kxCsdmMgVABEi97BX2ezkrD1UnQMm4CF8LCbSudq"],
  ["37.120.163.80:31245", "P1oNpHtoz2Xv1sm4qnasBJDhZymidcbAm9AZbfjXVVzW1tCgd4o"],
  ["194.163.151.34:31245", "P1pBRvf4pqnXg3nAXSSEvktgaJG9Tr74SDbbJ5JLuHAqSj6KKEL"],
  ["194.163.159.106:31245", "P1qoTrXs8beb45pr7QkGym1jvyJYuTDi3obgayypicFkNHxUf3E"]
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


# Script ile kurmak isteyenler için [LetskyNode](https://teletype.in/@letskynode/Massa) hazırladığı harika bir döküman.










