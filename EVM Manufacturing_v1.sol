// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TokenFactory {
    mapping(address => mapping(address => uint256)) private _balances;
    mapping(address => mapping(address => address)) private _combinations;
    mapping(address => address) private _characterOwners;

    event TokensBurned(address indexed sender, address indexed token, uint256 amount);
    event TokenMinted(address indexed receiver, address indexed token, uint256 amount);

    constructor() {
        // Set up combinations here
        _combinations[address(0x1)][address(0x2)] = address(0x3); // Wool + Rope = Net
        _combinations[address(0x1)][address(0x3)] = address(0x4); // Wool + Net = Cloth
        _combinations[address(0x2)][address(0x4)] = address(0x5); // Rope + Cloth = Lumber
        _combinations[address(0x6)][address(0x7)] = address(0x8); // Clay + Character = Forge
        _combinations[address(0x1)][address(0x9)] = address(0xA); // Wool + Rock = Metal
        _combinations[address(0xA)][address(0x8)] = address(0xB); // Metal + Forge = Hammer
        _combinations[address(0xA)][address(0x5)] = address(0xC); // Metal + Lumber = Ax
        _combinations[address(0xA)][address(0x5)] = address(0xD); // Metal + Lumber = Saw
        _combinations[address(0xB)][address(0xC)] = address(0xE); // Hammer + Saw = Cabin
        _combinations[address(0xB)][address(0xC)] = address(0xF); // Hammer + Saw = Barn
        _combinations[address(0xE)][address(0xF)] = address(0x10); // Cabin + Barn = Ship
        _combinations[address(0x11)][address(0x12)] = address(0x13); // Male Character + Female Character = New Character
        // Add more combinations as needed
    }

    function burnAndMint(address tokenToBurn1, uint256 amount1, address tokenToBurn2, uint256 amount2) external {
        require(_combinations[tokenToBurn1][tokenToBurn2] != address(0x0), "Invalid token combination");

        // Burn the specified amounts of tokens from the sender
        require(_balances[msg.sender][tokenToBurn1] >= amount1, "Insufficient balance of tokenToBurn1");
        require(_balances[msg.sender][tokenToBurn2] >= amount2, "Insufficient balance of tokenToBurn2");
        _balances[msg.sender][tokenToBurn1] -= amount1;
        _balances[msg.sender][tokenToBurn2] -= amount2;

        // Mint the new token and send it to the sender
        address newToken = _combinations[tokenToBurn1][tokenToBurn2];
        _balances[msg.sender][newToken] += 1;

        emit TokensBurned(msg.sender, tokenToBurn1, amount1);
        emit TokensBurned(msg.sender, tokenToBurn2, amount2);
        emit TokenMinted(msg.sender, newToken, 1);
    }

    function transferCharacterOwnership(address characterNFT, address newOwner) external {
        require(_characterOwners[characterNFT] == msg.sender, "You are not the owner of this character");
        _characterOwners[characterNFT] = newOwner;
    }

    function getCharacterOwner(address characterNFT) external view returns (address) {
        return _characterOwners[characterNFT];
    }
}