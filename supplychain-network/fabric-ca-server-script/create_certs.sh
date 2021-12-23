createCertForthayson() {
    echo
    echo "Enroll CA admin of thayson"
    echo
    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.thayson.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-thayson-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-thayson-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-thayson-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-thayson-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.thayson"
    echo

    fabric-ca-client register --caname ca.thayson.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    echo
    echo "Register peer1.thayson"
    echo

    fabric-ca-client register --caname ca.thayson.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    echo
    echo "Register user1.thayson"
    echo

    fabric-ca-client register --caname ca.thayson.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    echo
    echo "Register admin.thayson"
    echo

    fabric-ca-client register --caname ca.thayson.supplychain.com --id.name org1admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.thayson.supplychain.com -M ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/msp --csr.hosts peer0.thayson.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.thayson.supplychain.com -M ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.thayson.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/tlsca/tlsca.thayson.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer0.thayson.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/ca/ca.thayson.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.thayson.supplychain.com -M ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/msp --csr.hosts peer1.thayson.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.thayson.supplychain.com -M ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.thayson.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/tlsca/tlsca.thayson.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/peers/peer1.thayson.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/ca/ca.thayson.supplychain.com-cert.pem
    
    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/users/User1@thayson.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.thayson.supplychain.com -M ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/users/User1@thayson.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/thayson.supplychain.com/users/Admin@thayson.supplychain.com

    echo
    echo "Generate thayson Admin MSP"
    echo

    fabric-ca-client enroll -u https://org1admin:adminpw@localhost:7054 --caname ca.thayson.supplychain.com -M ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/users/Admin@thayson.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/thayson/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/thayson.supplychain.com/users/Admin@thayson.supplychain.com/msp/config.yaml
}

createCertForcohuong() {
    echo
    echo "Enroll CA admin of cohuong"
    echo
    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.cohuong.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-cohuong-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-cohuong-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-cohuong-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-cohuong-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.cohuong"
    echo

    fabric-ca-client register --caname ca.cohuong.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    echo
    echo "Register peer1.cohuong"
    echo

    fabric-ca-client register --caname ca.cohuong.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    echo
    echo "Register user1.cohuong"
    echo

    fabric-ca-client register --caname ca.cohuong.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    echo
    echo "Register admin.cohuong"
    echo

    fabric-ca-client register --caname ca.cohuong.supplychain.com --id.name org2admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.cohuong.supplychain.com -M ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/msp --csr.hosts peer0.cohuong.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.cohuong.supplychain.com -M ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.cohuong.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/tlsca/tlsca.cohuong.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer0.cohuong.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/ca/ca.cohuong.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.cohuong.supplychain.com -M ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/msp --csr.hosts peer1.cohuong.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.cohuong.supplychain.com -M ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.cohuong.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/tlsca/tlsca.cohuong.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/peers/peer1.cohuong.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/ca/ca.cohuong.supplychain.com-cert.pem
    
    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/users/User1@cohuong.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.cohuong.supplychain.com -M ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/users/User1@cohuong.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/cohuong.supplychain.com/users/Admin@cohuong.supplychain.com

    echo
    echo "Generate cohuong Admin MSP"
    echo

    fabric-ca-client enroll -u https://org2admin:adminpw@localhost:8054 --caname ca.cohuong.supplychain.com -M ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/users/Admin@cohuong.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/cohuong/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/cohuong.supplychain.com/users/Admin@cohuong.supplychain.com/msp/config.yaml
}

createCretificateForOrderer() {
  echo
  echo "Enroll CA admin of Orderer"
  echo
  mkdir -p ../organizations/ordererOrganizations/supplychain.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/ordererOrganizations/supplychain.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the Orderer Admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers
  # mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/supplychain.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com

  echo
  echo "Generate the Orderer MSP"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/config.yaml

  echo
  echo "Generate the orderer TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com

  echo
  echo "Generate the Orderer2 MSP"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/config.yaml

  echo
  echo "Generate the Orderer2 TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com

  echo
  echo "Generate the Orderer3 MSP"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/config.yaml

  echo
  echo "Generate the Orderer3 TLS certs"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/users
  mkdir -p ../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com

  echo
  echo "Generate the Admin MSP Orderer"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp/config.yaml

}

createCertForthayson
createCertForcohuong
createCretificateForOrderer