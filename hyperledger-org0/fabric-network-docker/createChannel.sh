# 在fabric-cli中运行
# 创建channel
export APP_CHANNEL=mychannel
export TIMEOUT=60
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer channel create -o orderer0.example.com:7050 \
-c ${APP_CHANNEL} \
-f "/tmp/channel-artifacts/${APP_CHANNEL}.tx" \
--timeout "${TIMEOUT}s" \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# 移动businesschannel.block
mv $APP_CHANNEL.block /tmp/channel-artifacts/