pragma solidity >=0.5.0 <0.9.0;

contract coin {
    address public minter;
    mapping(address => uint) public balances;
    
    
    event sent(address from , address to , uint amount);
    
    constructor() public {
        minter = msg.sender;            /**Stores the address of the one that deploys that contract and only that address can mint new tokens  */
    }
    
    function mint(address receiver , uint amount) public {
        if(msg.sender != minter) return;
        balances[receiver] += amount;
    }
    
    function send(address receiver, uint amount) public {
        if (balances[msg.sender]<amount) return;  
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender ,receiver,amount);
    }
    
    
}
