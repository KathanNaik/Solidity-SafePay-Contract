SafePay contract has 4 functions and one global variable

1) seller is set to the one deploying the contract.

2) there is a buyer address array and 4 mapping assosiating buyer to Payable Amount, Status, Code and Delivery.
	there are 4 status 0->money requested, 1->money paid, 2->item delivered, 3->purchase cancelled

3) PaymentRequest function can only be called by seller and takes buyer's, delivery partner's adress and requested money amount as arguments.

4) Payment function can only be called if a payment request for a buyer exist, money sent with the call in appropriate and status is 0 that is set to 1 after call.

IMPORTANT= Payment function will then genarate 6 digit OTP that has to be given to delivery partner when receiving order.

5) CancelOrder will refund any amount paid by the sender if item is not delivered and set status to 3.

6) OrderDelivered function will take buyer's adress check if sender is the assigned delivery partner and Pass code is matching with OTP Code and if it is send money to seller and status to 2.

