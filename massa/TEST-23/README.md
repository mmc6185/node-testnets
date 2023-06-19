# <h1 align="center">Massa testnet 23</h1>

![massa](https://user-images.githubusercontent.com/73015593/180018941-20b9e515-6e94-47ef-b928-b8e3ba507691.jpg)

# Hetzner'de 20 Euro bonus [Link](https://hetzner.cloud/?ref=vtZTtbpG2Vcn)   

# Linkler
> ## [Discord](https://discord.gg/K59z3Asm)
> ## [Massa website](https://massa.net/)
> ## [Massa explorer](https://paranormal-brothers.com/massa/)

# Sistem gereksinimleri
```
16GB RAM
50-100 GB SSD
6-8 vCPU
```

# Node kurulumu

## Sistem güncellemesi yapıyoruz. 
(Debian veya Ubuntu tabanlı Linux sistemlerindeki paketleri güncelleyen bir komut.)
```
sudo apt update && sudo apt upgrade -y
```
![image](https://user-images.githubusercontent.com/73015593/180020260-2774f980-3211-458b-afe3-230f8dc89a34.png)


## Kütüphane kurulumu yapıyoruz. 
(Bu komut, Debian veya Ubuntu tabanlı Linux sistemlerinde belirtilen paketleri indirip kurmaya yarar. İşlevi kısaca, "make", "clang", "curl", "pkg-config", "libssl-dev", "build-essential", "git", "jq", "ncdu" ve "bsdmainutils" paketlerini otomatik olarak yükleyerek sistemde bu paketlere ihtiyaç duyan programların çalışmasını sağlar. -y bayrağı, herhangi bir onay isteğine otomatik olarak "evet" yanıtı verir. "< "/dev/null"" ifadesi ise herhangi bir giriş veya etkileşim olmadan komutun çalışmasını sağlar.)
```
sudo apt install make clang curl pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
```
![image](https://user-images.githubusercontent.com/73015593/180020703-faa62886-4328-45a2-9136-37d70a097f1c.png)

## Rust kurulumu yapıyoruz. 1 diyerek Proceed with installation (default) kurulumu yapıyoruz. 
(Bu komut, Rust programlama dilinin Rustup aracılığıyla kurulumunu gerçekleştirir. Rustup, Rust programlama dilini yönetmek ve güncellemek için kullanılan bir araçtır.)
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Rust'un ortam değişkenlerini etkinleştiriyoruz.
Bu komut, Rust programlama dilinin yüklü olduğu ve yönetildiği Cargo ortam değişkenlerini geçerli kabuk oturumunda etkinleştirmek için kullanılır.
```
source $HOME/.cargo/env
```
![image](https://user-images.githubusercontent.com/73015593/180025712-25d76b2a-72f4-43ee-abf2-6bdb110359bc.png)

## Rust sürümünü kontrol edelim.
```
rustc --version
```
![image](https://user-images.githubusercontent.com/73015593/180025948-fa63daf2-5b2e-4de5-8e55-05b46f3a1cbc.png)

## Rust programlama dilinin Nightly sürümünü yüklüyoruz
Rust programlama dilinde Nightly toolchain olarak adlandırılan deneysel ve güncel özellikleri içeren bir Rust sürümünü yüklemek için kullanılır.
```
rustup toolchain install nightly
```
![image](https://user-images.githubusercontent.com/73015593/180026786-c0cfc916-1f77-4834-9c20-08720564f10d.png)

## varsayılan olarak ayarlıyoruz.
Bu komut, Rust programlama dilinde varsayılan olarak kullanılacak derleme aracı zincirini "Nightly" sürümü olarak ayarlar. Bu, Rust ile çalışırken Nightly sürümünü otomatik olarak kullanmanızı sağlar.
```
rustup default nightly
```

## massa repository'den `Massa 23.2` binary dosyasını indiriyoruz.
```
wget -O massa.tar.gz https://github.com/massalabs/massa/releases/download/TEST.23.2/massa_TEST.23.2_release_linux.tar.gz
tar -xzf massa.tar.gz
rm massa.tar.gz
```

# 1.Seçenek : Servis dosyası oluşturmak isteyenler için. 
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

## Servisimizi başlatıyoruz.
```
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable massa-node
sudo systemctl restart massa-node
```

# 2.Seçenek : Screen kullanmak isteyenler için. 

## Massa node isimli bir screen olusturuyoruz
```
screen -S massa-node
```

## massa-node dizinine gidiyoruz.
```
cd ~/massa/massa-node
```

## Massa node'unu başlatıyoruz.Ardindan CTRL+A + D ile screen'den cikiyoruz.
```
./massa-node -p PASSWORD |& tee logs.txt
```
![image](https://github.com/mmc6185/node-testnets/assets/73015593/30dac6d1-847b-4743-8e67-0fd03dda393a)

## Massa client isimli bir screen olusturuyoruz.
```
screen -S massa-client
```

## massa-client dizinine gidiyoruz.
```
cd ~/massa/massa-client
```

Massa client başlatıyoruz
```
./massa-client
```

Not : 
```
Servis dosyası oluşturmak ve screen kullanarak bir ekran oluşturmak, farklı kullanım senaryolarına ve ihtiyaçlara bağlı olarak avantajlara ve dezavantajlara sahiptir.

  Servis dosyası oluşturmanın avantajları şunlardır:

    1. Otomatik Başlatma: Servis dosyası, sistem başlangıcında otomatik olarak çalıştırılabilir. Bu, sunucu veya servislerin otomatik olarak başlamasını sağlar ve sistem yeniden başlatıldığında manuel müdahale gerektirmez.

    2. İzin ve Kontrol: Servis dosyası, servisin çalıştığı kullanıcı ve izinlerin yönetimini sağlar. Sistem düzeyinde servisin çalıştırılmasını ve izinlerini belirleyebilirsiniz.

    3. İşletim Sistemi Entegrasyonu: Servis dosyası, işletim sistemiyle entegre bir şekilde çalışır ve sistemin hizmetlerini düzgün bir şekilde yönetir. Sistem günlüklerine erişim sağlar, hata yönetimi yapar ve sistem üzerinde daha iyi bir kontrol sağlar.

  screen kullanarak ekran oluşturmanın avantajları şunlardır:

    1. Oturum Yönetimi: screen, birden fazla terminal oturumunu aynı anda çalıştırmanızı sağlar. Bu, birden fazla işi aynı anda yönetebilir ve geçiş yapabilirsiniz. Ekran oturumlarına dönerek işleri askıya alabilir ve devam ettirebilirsiniz.

    2. Bağımsızlık: screen, sunucuya veya sisteme özgü olmayan bir araçtır. İhtiyaç duyduğunuzda farklı sistemlere taşıyabilir ve aynı yöntemi kullanabilirsiniz. Sunucu bağımsızlığı sağlar.

  Servis dosyası oluşturmanın dezavantajları şunlardır:

    1. Karmaşa: Servis dosyaları, yapılandırmalar ve izinlerle ilgili ayrıntılı bilgilere ihtiyaç duyar. Başlangıç düzeyindeki kullanıcılar için karmaşık olabilir.

    2. İzleme ve Hata Ayıklama: Servislerin çalışmasını izlemek ve hataları ayıklamak için ek adımlara ihtiyaç duyabilirsiniz. Log dosyalarını takip etmek ve hataları bulmak daha fazla çaba gerektirebilir.

  screen kullanarak ekran oluşturmanın dezavantajları şunlardır:

    1. Otomatik Başlatma: screen kullanırken otomatik başlatma işlevi yoktur. Her oturumu manuel olarak başlatmanız gerekir, bu da sistemi yeniden başlatıldığında ekranları manuel olarak başlatmanız gerektiği anlamına gelebilir.

    2. İzin ve Kontrol: screen kullanırken, izinler ve kullanıcı kontrolleri daha sınırlı
```

## massa client başlatıyoruz. Yeni cüzdan oluşturmamız gerekiyor. Eski cüzdanın formatı desteklenmiyor artık. 
```
* `wallet_generate_secret_key` girin.
```


## [Massa Discord](https://discord.gg/K59z3Asm)'una gidiyoruz. 
![image](https://user-images.githubusercontent.com/73015593/189432317-2044f944-e9ac-4f72-bf62-3d8a0911289a.png)

## #⌠✅⌡testnet-rewards-registration kanalına gidiyoruz ve rastgele bir mesaj atıyoruz. Ardından bot bize özelden mesaj atacak.
![image](https://user-images.githubusercontent.com/73015593/189432602-d46fae1f-01fb-4f06-9080-5f5ea50c7940.png)

## #⌠💸⌡testnet-faucet kanalına gidiyoruz ve cüzdan adresimizi gönderiyoruz. (Cüzdan bilgilerine bakmak için `wallet_info` komutunu gireriz.)
![image](https://user-images.githubusercontent.com/73015593/189433642-d563dec7-ef95-4044-b951-11274241c359.png)

## Bot'a sunucu ip adresimizi gönderiyoruz.
![image](https://user-images.githubusercontent.com/73015593/189433133-d69be7c4-0895-4e1d-83f7-d6888c7784a3.png)

## Cuzdan adresimizi kaydediyoruz. `your_address` kısmına cuzdan adresimizi giriyoruz. (Cüzdan bilgilerine bakmak için `wallet_info` komutu girebilirsiniz.) 
```
node_start_staking your_address 
```

## Gelen tokenler ile rol satın alıyoruz. (`walletAddress` kısmına cüzdan adresimizi giriyoruz.)
```
buy_rolls walletAddress 1 0
```
![image](https://user-images.githubusercontent.com/73015593/189447804-5c93be9d-eb6f-4eed-9a59-bf5963518aea.png)

## Testnete kayıt yaptırıyoruz. (`staking_address` kısmına cüzdan adresimizi, `discordId` kısmına discord Id mizi giriyoruz.) 
```
node_testnet_rewards_program_ownership_proof staking_address discordId
```
![image](https://user-images.githubusercontent.com/73015593/189438905-871ec8b4-6ef9-43cd-8245-b9cb747c6a78.png)

## Oluşan çıktıyı bota gönderiyoruz.
![image](https://user-images.githubusercontent.com/73015593/189439038-0189b397-dadb-42f6-aa0a-36bd40c2c826.png)

## Tüm her şeyi bot'a `info` yazarak kontrol edebiliriz.
![image](https://user-images.githubusercontent.com/73015593/189439183-a69e2f3b-de4c-4c05-9b0b-180639b4a86a.png)










