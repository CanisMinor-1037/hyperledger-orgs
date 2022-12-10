# 用crypto-config.yaml生成crypto-config/
cryptogen generate \
--config=./crypto-config.yaml \
--output ./crypto-config

# tree level=2
tree crypto-config -L 2

# 将crypto-config拷贝到另外两台主机上
# scp -r crypto-config power@101.43.248.215:~/hyperledger/fabric-network-docker

# scp -r crypto-config power_company@47.113.205.36:~/hyperledger/fabric-network-docker
