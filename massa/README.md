# <h1 align="center">Massa testnet</h1>

![massa](https://user-images.githubusercontent.com/73015593/180018941-20b9e515-6e94-47ef-b928-b8e3ba507691.jpg)

## Sistem gereksinimleri
```
8GB RAM
100 GB SSD
4 vCPU
```

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
![image](https://user-images.githubusercontent.com/73015593/180020260-2774f980-3211-458b-afe3-230f8dc89a34.png)


## Kütüphane kurulumu yapıyoruz.
```
sudo apt install pkg-config curl git build-essential libssl-dev
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

## Massa'nın github dosyasını massa repository'den sunucumuza klonluyoruz.
```
git clone --branch testnet https://github.com/massalabs/massa.git
```
![image](https://user-images.githubusercontent.com/73015593/180027098-8b7a2a69-f3f4-4bd1-9c61-3cbdf0836bdf.png)

## tmux terminal oturumu aracımızı indiriyoruz.
```
sudo apt install tmux
```
![image](https://user-images.githubusercontent.com/73015593/180027867-cce13a4b-de27-4d0b-8668-6127a1317442.png)

## massa_node isimli bir tmux oturumu açıyoruz.
```
tmux new -s massa_node
```
![image](https://user-images.githubusercontent.com/73015593/180028279-d4f3c68b-d0da-4ac9-a3b1-f29dc854ebd9.png)

## massa-node dizinimize gidiyoruz.
```
cd ~/massa/massa-node/
```

##  massa Node'u çalıştırıyoruz. (Bu kısım biraz zaman alabilir.)
```
RUST_BACKTRACE=full cargo run --release |& tee logs.txt
```
![image](https://user-images.githubusercontent.com/73015593/180028676-ed1aa426-7de1-4960-ad05-34b8776a3bdc.png)



































