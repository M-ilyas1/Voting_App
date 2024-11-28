// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting_System {
    string public candidate_1 = "Muhammad"; 
    string public candidate_2 = "Abbas"; 

    uint public votesForMuhammad = 0; 
    uint public votesForAbbas = 1;

    mapping(address => uint) private Votes; 
    mapping(address => bytes32) private keys; 

    function Voting_Casting(uint candidateId, string memory secret) public returns (string memory) {
        
        if (candidateId != 0 && candidateId != 1) {
            return "Invalid candidate";
        }
        
        if (Votes[msg.sender] != 0) {
            return "You have already voted";
        }

        
        bytes32 hashedSecret = keccak256(abi.encodePacked(secret));
        
        Votes[msg.sender] = candidateId; 
        keys[msg.sender] = hashedSecret; 

        if (candidateId == 0) {
            votesForMuhammad++; 
        } else {
            votesForAbbas++;
        }

        return "Vote cast successfully"; 
    }

    
    function verification(address Voter, string memory secret) public view returns (string memory result) {
        
        bytes32 hashedSecret = keccak256(abi.encodePacked(secret));

        if (keys[Voter] == hashedSecret) {
            if (Votes[Voter] == 0) {
                return "Muhammad";
            } else if (Votes[Voter] == 1) {
                return "Abbas";
            }
        } else {
            return "Invalid secret code";
        }
    }

    
    function GetCount(uint candidateId) public view returns (uint) {
        if (candidateId == 0) {
            return votesForMuhammad;
        } else if (candidateId == 1) {
            return votesForAbbas;
        } else {
            revert("Invalid candidate id");
        }
    }
}