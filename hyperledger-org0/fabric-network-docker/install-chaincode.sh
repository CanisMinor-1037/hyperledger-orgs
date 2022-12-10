# 编译打包源码
mvn compile package -DskipTests -Dmaven.test.skip=true

mv target/chaincode.jar $PWD

# 删除编译后产生的 target 目录； src 源代码目录； pom.xml
#rm -rf target/ src pom.xml

# 打包链码
cd /etc/hyperledger/fabric/chaincodes/

#export CCNAME=hyperledger-fabric-contract-java-demo
export CCNAME=powercompany-go

peer lifecycle chaincode package ${CCNAME}.tar.gz \
--path ./${CCNAME}/ \
--lang java \
--label ${CCNAME}_1

# 在peer节点上安装链码
# peer0.org0
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org0MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/peers/peer0.org0.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/users/Admin@org0.example.com/msp
export CORE_PEER_ADDRESS=peer0.org0.example.com:7051

peer lifecycle chaincode install ${CCNAME}.tar.gz

# peer1.org0
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org0MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/peers/peer1.org0.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/users/Admin@org0.example.com/msp
export CORE_PEER_ADDRESS=peer1.org0.example.com:8051

peer lifecycle chaincode install ${CCNAME}.tar.gz

# peer0.org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode install ${CCNAME}.tar.gz
# 结果
# [020 12-07 11:13:12.57 UTC] [cli.lifecycle.chaincode] submitInstallProposal -> INFO Installed remotely: response:<status:200 payload:"\nh${CCNAME}_1:2ef462a461383ad50ec03592a457f1d052b83827bc3ea128b329407ae6e8641b\022'${CCNAME}_1" > 
# [021 12-07 11:13:12.57 UTC] [cli.lifecycle.chaincode] submitInstallProposal -> INFO Chaincode code package identifier: ${CCNAME}_1:2ef462a461383ad50ec03592a457f1d052b83827bc3ea128b329407ae6e8641b
# 2ef462a461383ad50ec03592a457f1d052b83827bc3ea128b329407ae6e8641b

# peer1.org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer1.org1.example.com:8051

peer lifecycle chaincode install ${CCNAME}.tar.gz

# peer0.org2
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:7051

peer lifecycle chaincode install ${CCNAME}.tar.gz

# peer1.org2
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer1.org2.example.com:8051

peer lifecycle chaincode install ${CCNAME}.tar.gz

# 查询链码包 peer1.org2
peer lifecycle chaincode queryinstalled
# 结果
# Installed chaincodes on peer:
# Package ID: ${CCNAME}_1:2ef462a461383ad50ec03592a457f1d052b83827bc3ea128b329407ae6e8641b, Label: ${CCNAME}_1

# 将包ID导出为环境变量
export CC_PACKAGE_ID=${CCNAME}_1:2ef462a461383ad50ec03592a457f1d052b83827bc3ea128b329407ae6e8641b

# 批准链码定义
export SEQ=2
# org0
export APP_CHANNEL=mychannel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org0MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/peers/peer0.org0.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/users/Admin@org0.example.com/msp
export CORE_PEER_ADDRESS=peer0.org0.example.com:7051

peer lifecycle chaincode approveformyorg -o orderer0.example.com:7050 \
--ordererTLSHostnameOverride orderer0.example.com \
--channelID $APP_CHANNEL \
--name ${CCNAME} \
--version 1.0 \
--package-id $CC_PACKAGE_ID \
--sequence 2 \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# org1
export APP_CHANNEL=mychannel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode approveformyorg -o orderer0.example.com:7050 \
--ordererTLSHostnameOverride orderer0.example.com \
--channelID $APP_CHANNEL \
--name ${CCNAME} \
--version 1.0 \
--package-id $CC_PACKAGE_ID \
--sequence $SEQ \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# 检查通道成员是否已批准相同链码
peer lifecycle chaincode checkcommitreadiness \
--channelID $APP_CHANNEL \
--name ${CCNAME} \
--version 1.0 \
--sequence $SEQ \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem \
--output json

# org2
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:7051

peer lifecycle chaincode approveformyorg -o orderer0.example.com:7050 \
--ordererTLSHostnameOverride orderer0.example.com \
--channelID $APP_CHANNEL \
--name ${CCNAME} \
--version 1.0 \
--package-id $CC_PACKAGE_ID \
--sequence $SEQ \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# 再次检查
peer lifecycle chaincode checkcommitreadiness \
--channelID $APP_CHANNEL \
--name ${CCNAME} \
--version 1.0 \
--sequence $SEQ \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem \
--output json

# 将链码提交到通道
peer lifecycle chaincode commit -o orderer0.example.com:7050 \
--ordererTLSHostnameOverride orderer0.example.com \
--channelID $APP_CHANNEL \
--name ${CCNAME} \
--version 1.0 \
--sequence $SEQ \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem \
--peerAddresses peer0.org0.example.com:7051 \
--tlsRootCertFiles /etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/peers/peer0.org0.example.com/tls/ca.crt \
--peerAddresses peer0.org1.example.com:7051 \
--tlsRootCertFiles /etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt \
--peerAddresses peer0.org2.example.com:7051 \
--tlsRootCertFiles /etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

# 确认链码已提交到通道
peer lifecycle chaincode querycommitted --channelID $APP_CHANNEL \
--name ${CCNAME} \
--cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# 调用链码

# createCat
peer chaincode invoke -o orderer0.example.com:7050 \
--ordererTLSHostnameOverride orderer0.example.com \
--tls --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem \
-C $APP_CHANNEL \
-n ${CCNAME} \
--peerAddresses peer0.org0.example.com:7051 \
--tlsRootCertFiles /etc/hyperledger/fabric/crypto-config/peerOrganizations/org0.example.com/peers/peer0.org0.example.com/tls/ca.crt \
--peerAddresses peer0.org1.example.com:7051 \
--tlsRootCertFiles /etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt \
--peerAddresses peer0.org2.example.com:7051 \
--tlsRootCertFiles /etc/hyperledger/fabric/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt \
-c '{"function":"createCat","Args":["cat-0" , "tom" ,  "3" , "蓝色" , "大懒猫"]}'

# queryCat
peer chaincode query \
-C $APP_CHANNEL \
-n ${CCNAME} \
-c '{"Args":["queryCat" , "cat-0"]}'