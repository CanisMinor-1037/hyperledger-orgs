docker-compose -f docker-compose-1orderer.yaml up -d
docker-compose -f docker-compose-org0-2peer.yaml up -d
docker-compose -f docker-compose-1ca.yaml up -d