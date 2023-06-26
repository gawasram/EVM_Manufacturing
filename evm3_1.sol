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
        _combinations[address(0x2b2eCC73501591A3cC8C5037A1088d7cebA7C68A)][address(0x2cC021E6fA4c18Fc2eEBF861A9A3E9255a24099d)] = address(0xf661D832d644f8eAc25CA1B1E7098E1BE6a3D29c); // Example combination: Wood + Rock = Hammer
        _combinations[address(0x4)][address(0x5)] = address(0x6); // Example combination: Wool + Rope = Net
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
