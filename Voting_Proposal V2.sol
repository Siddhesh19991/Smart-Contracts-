/** Adding time element to the pervious version of the ballot contract for timekeeping*/
/** registration is 10 days and voting period is 1 day */

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
    
    enum Stage {init,reg,Vote,done}
    Stage public stage = Stage.init;
    
    uint starttime;

    event votingcompleted();
    
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
     
    /** all proposals have been created */ 
    function allproposals () public {
        if(msg.sender != chairperson) return;
        stage = Stage.reg;
        starttime = block.timestamp;
    } 
    
    
    /** total number of proposals */
    function totalproposals() public view returns(uint){
        return proposals.length;
    }
    
    modifier reg() {
	require(stage == Stage.reg,"Not at registration stage"); 
	_;
										}
										
    
    /** To register */
    function register(address wanttovote) public reg() {
        if (msg.sender != chairperson || voters[wanttovote].voted == true) return;
        voters[wanttovote].weight=1;
        if (block.timestamp > (starttime + 10 days)) { 
            stage = Stage.Vote;
            starttime = block.timestamp;
        }
    }
    
    modifier vot() {
	require(stage == Stage.Vote,"Not at voting stage"); 
	_;
										}
										
    /** To vote */
    function vote(uint proposalindex) public vot() {
        if(voters[msg.sender].weight == 0 && voters[msg.sender].voted == true) return;
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = proposalindex;
        
        proposals[proposalindex].votecount += voters[msg.sender].weight;
        if(block.timestamp > (starttime + 1 days)){
            stage=Stage.done;
            emit votingcompleted(); 
        }   
    }
    
    modifier done() {
	require(stage == Stage.done,"Not at done stage"); 
	_;
										}
    
    /** Winner */
    function winner() public done() view returns (string memory name,uint votecount) {
        uint winnercount = 0 ;
         uint p;
        for (uint i =0;i< proposals.length;i++){
            if(proposals[i].votecount > winnercount){
                winnercount = proposals[i].votecount;
                p=i;
            }
        }
        assert (winnercount >0);      /** to make sure there is no winner as soon as proposals are created and no votes are pull forth */
        return(proposals[p].name,proposals[p].votecount);
    }
    
}
