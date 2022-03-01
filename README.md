# etlegacy-server
Enemy Territory Legacy mod server image

### Usage
```
docker build --build-arg SERVER_PASSWORD=ServerPasswordHere --build-arg REFEREE_PASSWORD=RefereePasswordHere --build-arg RCON_PASSWORD=RconPasswordHere . -t etlegacy
docker run -p 27960:27960/udp -d etlegacy
```
