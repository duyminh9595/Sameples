#!/bin/bash
source ../terminal_control.sh

export FABRIC_CFG_PATH=${PWD}/../config
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
export CORE_PEER_TLS_ROOTCERT_FILE_ORG1=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG2=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/ca.crt

CHANNEL_NAME="supplychain-channel"
CHAINCODE_NAME="supplychain"
CHAINCODE_VERSION="1.0"
CHAINCODE_PATH="../chaincode/assets"
CHAINCODE_LABEL="supplychain_1"

setEnvForthayson() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=thaysonMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/users/Admin@thayson.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}
# setEnvForthayson
setEnvForcohuong() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=cohuongMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/users/Admin@cohuong.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

packageChaincode() {
    rm -rf ${CHAINCODE_NAME}.tar.gz
    setEnvForthayson
    print Green "========== Packaging Chaincode on Peer0 thayson =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CHAINCODE_PATH} --lang node --label ${CHAINCODE_LABEL}
    echo ""
    print Green "========== Packaging Chaincode on Peer0 thayson Successful =========="
    ls
    echo ""
}
# packageChaincode
installChaincodethayson() {
    setEnvForthayson
    print Green "========== Installing Chaincode on Peer0 thayson =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 thayson =========="
    echo ""

    
}
# installChaincodethayson
installChaincodecohuong() {
    setEnvForcohuong
    print Green "========== Installing Chaincode on Peer0 thayson =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 thayson =========="
    echo ""
}
# installChaincodecohuong
queryInstalledChaincodethayson() {
    setEnvForthayson
    print Green "========== Querying Installed Chaincode on Peer0 thayson=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    print Yellow "PackageID is ${PACKAGE_ID}"
    print Green "========== Query Installed Chaincode Successful on Peer0 thayson=========="
    echo ""
}
# queryInstalledChaincodethayson
approveChaincodeBythayson() {
    setEnvForthayson
    print Green "========== Approve Installed Chaincode by Peer0 thayson =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 thayson =========="
    echo ""
}
# approveChaincodeBythayson

queryInstalledChaincodecohuong() {
    setEnvForcohuong
    print Green "========== Querying Installed Chaincode on Peer0 cohuong=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    print Yellow "PackageID is ${PACKAGE_ID}"
    print Green "========== Query Installed Chaincode Successful on Peer0 cohuong=========="
    echo ""
}
# queryInstalledChaincodecohuong
approveChaincodeBycohuong() {
    setEnvForcohuong
    print Green "========== Approve Installed Chaincode by Peer0 cohuong=========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel \
    --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 cohuong =========="
    echo ""
}
# approveChaincodeBycohuong

checkCommitReadynessForthayson() {
    setEnvForthayson
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 thayson =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 thayson =========="
    echo ""
}
# checkCommitReadynessForthayson

checkCommitReadynessForcohuong() {
    setEnvForcohuong
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 cohuong =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 cohuong =========="
    echo ""
}
# checkCommitReadynessForcohuong



commitChaincode() {
    setEnvForthayson
    print Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com \
    --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} \
    --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} \
    --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} \
    --version ${CHAINCODE_VERSION} --sequence 1 --init-required
    print Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}
# commitChaincode
queryCommittedChaincode() {
    setEnvForthayson
    print Green "========== Query Committed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME}
    print Green "========== Query Committed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}
# queryCommittedChaincode
getInstalledChaincode() {
    setEnvForthayson
    print Green "========== Get Installed Chaincode from Peer0 thayson =========="
    peer lifecycle chaincode getinstalledpackage --package-id ${PACKAGE_ID} --output-directory . \
    --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Get Installed Chaincode from Peer0 thayson Successful =========="
    echo ""
}
# getInstalledChaincode
queryApprovedChaincode() {
    setEnvForthayson
    print Green "========== Query Approved of Installed Chaincode on Peer0 thayson =========="
    peer lifecycle chaincode queryapproved -C s${CHANNEL_NAME} -n ${CHAINCODE_NAME} --sequence 1
    print Green "========== Query Approved of Installed Chaincode on Peer0 thayson Successful =========="
    echo ""
}
# queryApprovedChaincode
initChaincode() {
    setEnvForthayson
    print Green "========== Init Chaincode on Peer0 thayson ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com \
    --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} \
    --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} \
    --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} \
    -c '{"Args":["registerUser","duyminh95@gmail.com","123456","le quang duy minh","01/01/2000"]}' --isInit

    print Green "========== Init Chaincode on Peer0 thayson Successful ========== "
    echo ""
}
# initChaincode

packageChaincode
installChaincodethayson
queryInstalledChaincodethayson
approveChaincodeBythayson
checkCommitReadynessForthayson
installChaincodecohuong
queryInstalledChaincodecohuong
approveChaincodeBycohuong
checkCommitReadynessForcohuong
commitChaincode
queryCommittedChaincode


