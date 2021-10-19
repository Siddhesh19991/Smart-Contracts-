pragma solidity >=0.5.0 <0.9.0;

contract bidder {

    string public name;
    uint public bidamount = 2000;
    bool public eligible;
    uint constant minbid =100;
    
    function setname(string memory nm) public {
        name = nm;
    }
    
    function setbidamount(uint x) public {
        bidamount = x;
    }
    
    function determineeligibility() public {
        if (bidamount >= minbid) eligible = true;
        else eligible = false;
    }
    
}
