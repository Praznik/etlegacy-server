# etlegacy-server
Enemy Territory Legacy mod server image

### Usage
```
docker build --tag etlegacy --build-arg ET_PASSWORD=ServerPasswordHere
docker run -p 27960:27960/udp -d etlegacy
```
