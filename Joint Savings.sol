/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/

pragma solidity ^0.5.0;


// Define a new contract named `JointSavings`
contract JointSavings {
    // Define variables
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Define function to withdraw funds
    function withdraw(uint amount, address payable recipient) public {
        // Check if recipient is authorized
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        // Check if contract has sufficient funds
        require(contractBalance >= amount, "Insufficient funds!");
        // Update last to withdraw
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }
        // Transfer funds to recipient
        recipient.transfer(amount);
        // Update last withdraw amount
        lastWithdrawAmount = amount;
        // Update contract balance
        contractBalance = address(this).balance;
    }

    // Define function to deposit funds
    function deposit() public payable {
        // Update contract balance
        contractBalance = address(this).balance;
    }

    // Define function to set joint account addresses
    function setAccounts(address payable account1, address payable account2) public {
        // Set account addresses
        accountOne = account1;
        accountTwo = account2;
    }

    // Default fallback function to receive Ether
    function () external payable {
        // Update contract balance
        contractBalance = address(this).balance;
    }
}
