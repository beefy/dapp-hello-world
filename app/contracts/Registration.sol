// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract Registration {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => User) public users;
    struct User {
        string name;
        uint8 age;
        bool registered;
    }

    event NewUser(address userAddress, string name, uint8 age);
    event NewValue(address userAddress, uint256 value);

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can register a user.");
        _;
    }

    function registerUser(
        address _address,
        string memory _name,
        uint8 _age
    ) public onlyOwner {
        users[_address] = User(_name, _age, true);
        emit NewUser(_address, _name, _age);
    }

    function send(uint256 _value) public {
        require(
            users[msg.sender].registered == true,
            "Caller is not registered."
        );
        emit NewValue(msg.sender, _value);
    }
}
