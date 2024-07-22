const rlp = require("rlp");
const keccak = require("keccak");
const zk = require("zksync-ethers");

var nonce = 3; //The nonce must be a hex literal!
var sender = "0x0000000000000000000000000000000000008006"; //Requires a hex string as input!

/*var input_arr = [sender, nonce];
var rlp_encoded = rlp.encode(input_arr);

var contract_address_long = keccak("keccak256")
  .update(rlp_encoded)
  .digest("hex");

var contract_address = contract_address_long.substring(24); //Trim the first 24 characters.*/
//console.log("contract_address: " + contract_address);

let address = zk.utils.createAddress(sender, nonce);

console.log("contract_address: " + address);
