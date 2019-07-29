if [ "$FABRIC_BINS" == "" ];then
    echo "Please set FABRIC_BINS first!"
    exit 1
fi

export FABRIC_CFG_PATH=$PWD
export CHANNEL_NAME=mychannel  

function start_orderer(){
    FABRIC_LOGGING_SPEC=INFO \
    ORDERER_GENERAL_CLUSTER_CLIENTCERTIFICATE=$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt \
    ORDERER_GENERAL_CLUSTER_CLIENTPRIVATEKEY=$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key \
    ORDERER_GENERAL_CLUSTER_ROOTCAS="[$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]" \
    ORDERER_GENERAL_GENESISFILE=$PWD/channel-artifacts/genesis.block \
    ORDERER_GENERAL_GENESISMETHOD=file \
    ORDERER_GENERAL_LISTENADDRESS=0.0.0.0 \
    ORDERER_GENERAL_LOCALMSPDIR=$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp \
    ORDERER_GENERAL_LOCALMSPID=OrdererMSP \
    ORDERER_GENERAL_TLS_CERTIFICATE=$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt \
    ORDERER_GENERAL_TLS_ENABLED="true" \
    ORDERER_GENERAL_TLS_PRIVATEKEY=$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key \
    ORDERER_GENERAL_TLS_ROOTCAS='[$PWD/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]' \
    ORDERER_KAFKA_TOPIC_REPLICATIONFACTOR='1' \
    ORDERER_KAFKA_VERBOSE="true" \
    $FABRIC_BINS/orderer
}

start_orderer