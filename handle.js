const Web3 = require('web3');
const http = require("http");
const config = require('config');
const abi = require("./abi.json");

// providers have to be websocket (in this file atleast)
var web3 = new Web3(new Web3.providers.WebsocketProvider("wss://api.avax-test.network/ext/bc/C/ws"));

// set addresses
var oracle_address = config.get('oracle.address');
var contract = new web3.eth.Contract(abi,oracle_address);
var callback_address = "0x0000000000000000000000000000000000000000";

function setvalue(api){
	var account = config.get("account.address");
	let pv = config.get("account.privateKey");
	// change 'value' to whatever you want (http response, ...)
	var value = api;
	// var data = contract.methods.setValue(value, "callback address / contract you want to make a callback", "functionABI").encodeABI();
	var data = contract.methods.setValue([value], callback_address, "__callback(string[])").encodeABI();
	// var data = contract.methods.setValue([value]").encodeABI();
	// var data = contract.methods.setValue([value], callback_address, "__callback(string[])").encodeABI();
	// var data = contract.methods.onlyCallback([value], callback_address, "__callback(string[])").encodeABI();
	
	// there is 3 functions in oracle contract
	// setvalue()
	// setvalue() with callback
	// onlyCallback()

	// build transaction
	var tx = {from:account,
		to: oracle_address,
		gas: 300000,
		value: 0,
		data:data};
	// sign a transaction then send it
	web3.eth.accounts.signTransaction(tx, pv).then(signed =>{
		web3.eth.sendSignedTransaction(signed.rawTransaction).on("receipt", console.log);
	});
}
console.log("Working...");

// subscribe to getRequest event
contract.events.getRequest()
	.on('data', function(req){
		// get API parameter
		req = req["returnValues"]["API"];
		// call setValue
		setvalue(req);
		console.log("Calling....");
	});
