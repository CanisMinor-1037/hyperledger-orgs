# 生成创世区块
configtxgen -configPath . \
-profile ThreeOrgsOrdererGenesis \
-channelID fabric-channel \
-outputBlock ./channel-artifacts/orderer.genesis.block

export CHANNELID=mychannel

# 生成通道文件
configtxgen -configPath . \
-profile ThreeOrgsChannel \
-channelID $CHANNELID \
-outputCreateChannelTx ./channel-artifacts/${CHANNELID}.tx

# 更新锚节点配置文件
# Org0
configtxgen -configPath . \
-profile ThreeOrgsChannel \
-channelID $CHANNELID \
-asOrg Org0MSP \
-outputAnchorPeersUpdate ./channel-artifacts/Org0MSPanchors.tx

# Org1
configtxgen -configPath . \
-profile ThreeOrgsChannel \
-channelID $CHANNELID \
-asOrg Org1MSP \
-outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx

# Org2
configtxgen -configPath . \
-profile ThreeOrgsChannel \
-channelID $CHANNELID \
-asOrg Org2MSP \
-outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx

# 将channel-artifacts拷贝到另外两台机器上
# scp -r channel-artifacts/ power@101.43.248.215:~/hyperledger/fabric-network-docker

# scp -r channel-artifacts/ power_company@47.113.205.36:~/hyperledger/fabric-network-docker