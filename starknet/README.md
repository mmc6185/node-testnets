# <h1 align="center">Starknet Testneti</h1>

![starknet](https://user-images.githubusercontent.com/73015593/181306567-6d7b8819-2d73-4872-89be-00086a8609ae.jpg)

# Node kurulumu

## root yetkisi kazanıyoruz.
```
sudo su
```

## root dizini altında gidiyoruz.
```
cd /root
```

## Sunucumuzu güncelliyoruz.
```
apt-get update && apt-get upgrade -y
```

## Python için paket yönetim aracı olan pip kurulumu yapıyoruz.
```
sudo apt install -y python3-pip
```

## Gerekli araçların kurulumlarını yapıyoruz. (fastecdsa kriptografide kullanılan bir python aracı.)
```
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
sudo apt-get install libgmp-dev
pip3 install fastecdsa
sudo apt-get install -y pkg-config
```
![image](https://user-images.githubusercontent.com/73015593/181313569-65539667-347a-40a7-a646-9061857c189c.png)


## Rust kurulumu yapıyoruz. (1 numaralı kurulumu yapıyoruz)
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install cargo
```
![image](https://user-images.githubusercontent.com/73015593/181313689-5dca6c5e-9f9b-4e02-85ba-4171bfef6a58.png)


## Rustup son sürüme güncelliyoruz.
```
rustup update stable
```
![image](https://user-images.githubusercontent.com/73015593/181327056-5e4e3cb5-e208-4773-a090-2961fb785ae3.png)

## pathfinder aracını github'tan sunucumuza klonluyoruz.
```
git clone --branch v0.2.5-alpha https://github.com/eqlabs/pathfinder.git
```
![image](https://user-images.githubusercontent.com/73015593/181339554-48f6af5a-9a3c-4314-8873-f7a1a5522143.png)

## Sanal ortam oluşturmak için gerekli aracımızı yüklüyoruz.
```
sudo apt install python3.8-venv
```

## py klasörü içine giriyoruz.
```
cd ~/pathfinder/py
```

## venv isimli bir sanal ortam oluşturuyoruz.
```
python3 -m venv .venv
```

## Sanal ortamımızı aktif ediyoruz.
```
source .venv/bin/activate
```
![image](https://user-images.githubusercontent.com/73015593/181342338-300694e9-d071-4a84-bda9-82289b606d2f.png)

## Node için birkaç gerekli araç daha yüklüyoruz.
```
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
```
![image](https://user-images.githubusercontent.com/73015593/181342478-467457fb-5686-4826-a705-0c39a3fb013f.png)

## İşlemlerin doğru olduğunu anlamak için pytest aracımızı çalıştırıyoruz
```
pytest
```
![image](https://user-images.githubusercontent.com/73015593/181343021-68319d0c-b3b1-49d7-94c7-cf3e1d719c31.png)

## Node kurulumu yapıyoruz.
```
cargo build --release --bin pathfinder
```














