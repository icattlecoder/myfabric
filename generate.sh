if [ "$FABRIC_BINS" == "" ];then
    echo "Please set FABRIC_BINS first!"
    exit 1
fi

mkdir -p channel-artifacts
mkdir -p crypto-config

export FABRIC_CFG_PATH=$PWD
export CHANNEL_NAME=mychannel  

$FABRIC_BINS/cryptogen generate --config=./crypto-config.yaml

$FABRIC_BINS/configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

$FABRIC_BINS/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

$FABRIC_BINS/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
$FABRIC_BINS/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP