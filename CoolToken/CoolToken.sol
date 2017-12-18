pragma solidity ^0.4.11;

import "./IERC20.sol";

contract CoolToken is IERC20 {

    uint public constant _totalSupply = 100000000;

    string public constant symbol = "COOL";
    string public constant name = "Cool token";
    uint8 public constant decimels = 3; //after . how much

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed; //how much is spent
    
    function CoolToken() {
        balances[msg.sender] = _totalSupply;
    }

    //return totalSupply
    function totalSupply() constant returns (uint256 totalSupply) {
        return _totalSupply;
    }

    //return balance of owner address
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    //trnasfer need to do checks before transfer
    function transfer(address _to, uint256 _value) returns (bool success){
        require(
            balances[msg.sender] >= _value //check if sender balance is more or equal to totla have
            && _value > 0 //check if value is more then zero that user sent
        );

        balances[msg.sender] -= _value; //atimti is senderio
        balances[_to] += _value; //add to receipent
        Transfer(msg.sender, _to, _value); //transfer event
        return true;
    }

    //also need some checks
    //track who was givven permision to whom
    function transferFrom(address _from, address _to, uint256 _value) returns(bool success) {
        require(
            allowed[_from][msg.sender] >= _value //how much spent check
            && balances[_from] >= _value
            && _value > 0
        );
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    
}