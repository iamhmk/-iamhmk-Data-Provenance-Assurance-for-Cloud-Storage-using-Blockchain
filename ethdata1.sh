sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update                      
sudo apt-get -y install ethereum
geth --datadir node1 init genesis_node1.json
geth --datadir="FirstNode" --networkid 9999 --nodiscover console --unlock 8735f9db95c21b4289214a2a9f8b806766772171 --rpc --rpcport "8545" --rpccorsdomain "*" --rpcapi "eth,net,web3,miner,debug,personal,rpc" --port 30303 --allow-insecure-unlock --nat extip:192.168.43.204


geth --datadir="node2" --networkid 9999 --nodiscover console --unlock d51e6352715e3b3673397d2c5b96949103ce1277 --rpc --rpcport "8545" --rpccorsdomain "*" --rpcapi "eth,net,web3,miner,debug,personal,rpc" --port 30303 --allow-insecure-unlock --nat extip:192.168.43.204


geth --datadir="ThirdNode" --networkid 9999 --nodiscover console --unlock ee1a8e4e7ae436ad7338281b5da26038401761f6 --rpc --rpcport "8546" --rpccorsdomain "*" --rpcapi "eth,net,web3,miner,debug,personal,rpc" --port 30304 --allow-insecure-unlock --nat extip:192.168.43.204




var t1
t0=Date.now()
i=10

var tx_hash= []
for(i=0;i<10;i++){
tx_hash.push(eth.sendTransaction({from:eth.accounts[0],to:"0x69500c65bd190accf8bcc0b4fca8d58e42ed6c2c",value:15000000}))

}


#for local ThirdNode
t0=Date.now()
var tx_hash
for(i=0;i<10;i++){
tx_hash=eth.sendTransaction({from:eth.accounts[0],to:"0xee1a8e4e7ae436ad7338281b5da26038401761f6",value:15000000})
}


tx_receipt = eth.getTransactionReceipt(tx_hash)
console.log(Date.now()-t0)


for(i=1;i<10;i++){
eth.getTransaction(tx_hash[i])
}


#console.log(tx_rt)
var result =null;
while(result === null) {
 result = eth.getTransactionReceipt(tx_hash);
 console.log("wait");
 }
console.log(Date.now()-t0);





function waitForTx(tx_hash) {
        var result = null;

        // This is not really efficient but nodejs cannot pause the running process
        while(result == null) {
            result = eth.getTransactionReceipt(tx_hash);
        }
        console(Date.now()-t0);
    }

waitForTx(tx_hash);




var mining_threads = 1
function checkWork() {
    if (eth.getBlock("pending").transactions.length > 0) {
        if (eth.mining) return;
        console.log("== Pending transactions! Mining...");
        miner.start(mining_threads);
    } else {
        
        miner.stop();
        console.log("== No transactions! Mining stopped.");
        console.log("Transaction Delay:")
        
       console.log(Date.now()-t0);
        
    }
}

eth.filter("latest", function(err, block) { checkWork(); });
eth.filter("pending", function(err, block) { checkWork(); });

checkWork();





