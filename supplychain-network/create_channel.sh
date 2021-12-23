#!/bin/bash
source ../terminal_control.sh

export FABRIC_CFG_PATH=${PWD}/../config/
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

export CHANNEL_NAME=supplychain-channel

setEnvForPeer0thayson() {
    export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=thaysonMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/users/Admin@thayson.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForPeer1thayson() {
    export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=thaysonMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/thayson.supplychain.com/users/Admin@thayson.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

setEnvForPeer0cohuong() {
    export PEER0_ORG2_CA=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=cohuongMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/users/Admin@cohuong.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForPeer1cohuong() {
    export PEER1_ORG2_CA=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=cohuongMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/cohuong.supplychain.com/users/Admin@cohuong.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}



createChannel() {
    setEnvForPeer0thayson

    print Green "========== Creating Channel =========="
    echo ""
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.supplychain.com \
    -f ./channel-artifacts/$CHANNEL_NAME.tx --outputBlock \
    ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 
    echo ""
}

joinChannel() {
    
    setEnvForPeer0thayson
    print Green "========== Peer0thayson Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1thayson
    print Green "========== Peer1thayson Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0cohuong
    print Green "========== Peer0cohuong Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1cohuong
    print Green "========== Peer1cohuong Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""


    
}

updateAnchorPeers() {
    setEnvForPeer0thayson
    print Green "========== Updating Anchor Peer of Peer0thayson =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0cohuong
    print Green "========== Updating Anchor Peer of Peer0cohuong =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
}



createChannel
joinChannel
updateAnchorPeers
