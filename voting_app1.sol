// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Voting {
    string[] public candidates;
    uint256[] public voteCounts;

    mapping(address => uint256) public voterToCandidate;

    function addCandidate(string memory _name) public {
        candidates.push(_name);
        voteCounts.push(0);
    }

    function vote(uint256 _candidateIndex) public {
        require(voterToCandidate[msg.sender] == 0, "You've already voted");

        voterToCandidate[msg.sender] = _candidateIndex;
        voteCounts[_candidateIndex]++;
    }

    function getWinner() public view returns (string memory) {

        uint256 maxVotes = 0;
        uint256 winnerIndex = 0;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (voteCounts[i] > maxVotes) {
                maxVotes = voteCounts[i];
                winnerIndex = i;
            }
        }

        return candidates[winnerIndex];
    }
}