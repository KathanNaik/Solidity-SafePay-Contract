pragma solidity ^0.4.17;

contract SafePay {

    address public seller;
    address[] private buyer;

    mapping(address => uint) private PayableAmount;
    mapping(address => uint) private Status;
    mapping(address => uint) private Code;
    mapping(address => address) private Delivery;

    function SafePay() public {
        seller= msg.sender;
    }

    function PaymentRequest(address buyer_address, address delivery_partner, uint amount_requested) public{
        require (msg.sender == seller);

        buyer.push(buyer_address);
        PayableAmount[buyer_address]= amount_requested;
        Delivery[buyer_address]= delivery_partner;
        Status[buyer_address]= 0;

    }

    function Payment() public payable returns (uint) {
        uint x = buyer.length;
        bool b=false;
        for(uint i=0; i<x ; i++){
            if(msg.sender == buyer[i]){
                require(msg.value ==  PayableAmount[buyer[i]]);
                require(Status[buyer[i]] == 0);
                b=true;

            Status[buyer[i]]= 1;
            Code[buyer[i]]= uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % 999983;

            return Code[buyer[i]];
            }
        }
        require(b==true);
        return 0;
    }

    function CancelOrder() public returns (string) {
         uint x = buyer.length;
         bool b=false;
        for(uint i=0; i<x ; i++){
            if(msg.sender == buyer[i]){

                 require(Status[buyer[i]]<2);
                 b=true;

                if(Status[buyer[i]] == 1){
                    msg.sender.transfer(PayableAmount[buyer[i]]);
                }

            Status[buyer[i]]= 3;

            return "Order Canceled";
            }
        }
        return "No Pending Orders";
         require(b==true);
    } 

    function OrderDelivered(address Reciever , uint Pass) public returns (string) {
         uint x = buyer.length;
          bool b=false;
        for(uint i=0; i<x ; i++){
            if(Reciever == buyer[i]){

                require( Delivery[buyer[i]] == msg.sender);
                require( Code[buyer[i]] == Pass );
                require( Status[buyer[i]] == 1);
                b=true;

                    seller.transfer(PayableAmount[buyer[i]]);
                     Status[buyer[i]]= 2;

                     return "Thanks for the Purchase!";
            }
             return "Invalid Code";
             require(b==true);
        }

    }
}