pragma solidity >=0.5.0 <0.9.0;


contract ballot{
    
    struct voter{
        uint weight;
        bool voted;
        uint vote;  /** which one they voted for (Index)*/
    }
    
    struct proposal{
        string name;
        uint votecount;
    }
    
    address public chairperson;
    mapping(address => voter) public voters;
    
    proposal[] public proposals;
    
    /** to get the chairhead*/
    constructor() {
        chairperson = msg.sender;  /**Stores the address of the one that deploys that contract and only that address can mint new tokens  */
        voters[chairperson].weight=2;
    }
    
    /** to create a proposal */ 
    function newproposal(string memory names) public{
        if(msg.sender != chairperson) return;
        proposals.push(proposal(names,0));
    }
     
    /** total number of proposals */
    function totalproposals() public view returns(uint){
        return proposals.length;
    }
    
    
    /** To register */
    function register(address wanttovote) public{
        if (msg.sender != chairperson || voters[wanttovote].voted == true) return;
        voters[wanttovote].weight=1;
    }
    
    
    /** To vote */
    function vote(uint proposalindex) public{
        if(voters[msg.sender].weight == 0 && voters[msg.sender].voted == true) return;
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = proposalindex;
        
        proposals[proposalindex].votecount += voters[msg.sender].weight;
    }
    
    /** Winner */
    function winner() public view returns (string memory name,uint votecount){
        uint winnercount = 0 ;
         uint p;
        for (uint i =0;i< proposals.length;i++){
            if(proposals[i].votecount > winnercount){
                winnercount = proposals[i].votecount;
                p=i;
            }
        }
        return(proposals[p].name,proposals[p].votecount);
    }
    
}
