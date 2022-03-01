# etlegacy-server
Enemy Territory Legacy mod server image

### Usage
```
docker build --build-arg ET_PASSWORD=ServerPasswordHere . -t etlegacy
docker run -p 27960:27960/udp -d etlegacy
```
