export DOMAIN=registry.thinhlh.com
export EMAIL=thinhlh0812@gmail.com

cd ~
git clone https://github.com/TH-Logistic/registry-service
cd registry-service

docker compose up -d # To run nginx by default with certbot to generate certificates
sleep 20
cat ./volumes/nginx/config/default-config-with-ssl.txt >> ./volumes/nginx/config/default.conf
docker compose exec nginx nginx -s reload