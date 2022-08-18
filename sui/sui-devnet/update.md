# <h1 align="center">Sui devnet (full node) update</h1>

![sui](https://user-images.githubusercontent.com/73015593/178133251-a0ed4307-3cc5-4aab-b929-280afc1788d2.jpg)

## Docker_compose ve Genesis dosyamızın bulunduğu dizine gidiyoruz.
```
cd /var/sui
```

## genesis.blob dosyasını siliyoruz.
```
rm genesis.blob
```

## Güncel genesis.blob dosyasını indiriyoruz.
```
wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
```

## Docker compose pull ediyoruz.
```
docker-compose pull 
```

## Docker compose tekrar başlatıyoruz.
docker-compose down -v 
docker-compose up -d  
```
