pragma solidity >=0.5.16;

contract Mycontract{
    
    address OrganizationHead;
    
    struct Members{
        uint weight;
        uint Joinedon;
        bool currentmember;
        uint assets;
        uint investments;
    } 
    
    struct investments{
        uint totalInvestment;
    }
    
    bytes32 Pass;
    
    enum State {Start, Active, End}
    State public state;
    
    address CurrentHighest;
    address Claimer;
    
    mapping(uint => uint) public Investments;
    mapping(uint => uint) public collaborators;
    mapping(address => Members) public Details;
    mapping(address => uint) public Membership;
    
    event Ending(address Claimer, uint Amount);
    event notify(string);
    
    modifier onlyOrgLeader(){
       require(msg.sender == OrganizationHead); 
       _;
    }
    
    modifier Active{
        require(state == State.Active, "This State is not Active");
        _;
    }
    
    modifier isMember(){
        require(Membership[msg.sender] == 1);
        _;
    }
    
    function register() public payable{
        if (Membership[msg.sender] == 1){
            revert();
        }
        // Pass = keccak256(abi.encodePacked(password));
        
        
        Membership[msg.sender] = 1;
        Details[msg.sender].Joinedon = block.timestamp;
        Details[msg.sender].currentmember = true;
        
        emit notify("Sucessfully Registered!");
        
        state = State.Active;
    }
    
    function Collaborate(uint collabto) public payable Active{
        // require(Pass == keccak256(abi.encodePacked(passkey)), "The Password is wrong!");
        collaborators[collabto] = collaborators[collabto] + 1;
    }
    
    function investInAsset(uint investin) public payable isMember Active{
        if(Membership[msg.sender] != 1){
            revert();
        }
        Investments[investin] += msg.value;
        
        Details[msg.sender].investments += 1;
    }

    
    function unregister() public{
        if (Membership[msg.sender] != 1){
            revert();
        }
        Membership[msg.sender] = 0;
        Details[msg.sender].currentmember = false;
        
        emit notify("You are now unregistered!");
        
        state = State.End;
    }
    
    
    
    
}


// pragma solidity >=0.5.16;

// contract Mycontract{
    
//     address organizationHead;
    
//     struct members{
//         address lastinteraction;
//         uint capital;
//         uint Joinedon;
//         bool currentmember;
//         // uint hashmsg;
//         uint assets;
//     }
    
//     // struct Pass{
//     //     bytes32 Password;
//     // }
    
//     // bytes32 Password;
    
//     // mapping(address => bytes32) public Password;
//     mapping(address => uint) public collaborators;
//     mapping(address => uint) public membership;
//     mapping(address=> members) public Details;
    
//     modifier onlyOrgLeader(){
//        require(msg.sender == organizationHead); 
//        _;
//     }
    
//     modifier orgmember(){
//         require(membership[msg.sender] == 1);
//         _;
//     }
    
//     modifier onlymember(){
//         require(membership[msg.sender] == 1);
//         _;
//     }
    
//     constructor() public{
//         organizationHead = msg.sender;
//     }
    
//     //Events
    
//     //Declare an Event
//     event notify(string);
    
//     event Collab(address indexed _from, address indexed _to);
    
//     event Asset(address indexed _from, uint _value);


    
    
//     function register() public payable{
//         if(membership[msg.sender] == 1){
//             revert();
//         }
    
//         membership[msg.sender] = 1;
//         Details[msg.sender].Joinedon = block.timestamp;
//         Details[msg.sender].currentmember = true;
        
//         // Password[msg.sender] = bytes32(keccak256(abi.encodePacked(pass)));
//         // Password = keccak256(abi.encodePacked(pass));

        
//         emit notify("Successfully Registered!");
//     }
    
//     function transferfunds(address payable transferto) public payable onlymember{
//         if(membership[msg.sender] != 1){
//             revert();
//         }
//         uint amount = msg.value;
        
//         Details[msg.sender].capital = Details[msg.sender].capital - amount;
//         Details[transferto].capital = Details[transferto].capital + amount;
        
//         transferto.transfer(amount);
//     }
    
//     function Collaborate(address colabto) public{
//         // require(keccak256(abi.encodePacked(Passw)) == Password[msg.sender], "The Pass Key was wrong !");
//         // require(Passw == Password);
//         if(msg.sender == colabto){
//             revert();
//         }
//         if(membership[msg.sender] != 1){
//             revert();
//         }
//         collaborators[colabto] = collaborators[colabto] + 1;
//         collaborators[msg.sender] = collaborators[msg.sender] + 1;
        
//         Details[colabto].lastinteraction = msg.sender;
//         Details[msg.sender].lastinteraction = colabto;
        
//         // Details[colabto].hashmsg = Hashmsg;
        
//         emit Collab(msg.sender, colabto);
        
//     }
    
//     function registerAsset(uint AssetID) public onlyOrgLeader{
//         Details[msg.sender].assets = AssetID;
//         emit Asset(msg.sender, AssetID);
//     }
    
//     function unregister() public{
//         if(membership[msg.sender] != 1){
//             revert();
//         }
//         membership[msg.sender] = 0;
//         Details[msg.sender].currentmember = false;
        
//         emit notify("You have now been unregistered!");
//     }
// }