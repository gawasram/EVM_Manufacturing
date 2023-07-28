// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract FISHNETNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    WOOLToken public wool; 
    ROPEToken public rope; 

    // Address of the deployed CharacterNFTHolder contract
    address public characterNFTContractAddress;

    // Constructor with the address of the CharacterNFTHolder contract
    constructor(
        address _wool,
        address _rope,
        address _characterNFTContractAddress
    ) ERC721("FISHNET NFT", "FISHNET") {
        require(_wool != address(0), "Wool token address can't be address zero");
        require(_rope != address(0), "Rope token address can't be address zero");
        require(_characterNFTContractAddress != address(0), "Character NFT contract address can't be address zero");
        wool = WOOLToken(_wool);
        rope = ROPEToken(_rope);
        characterNFTContractAddress = _characterNFTContractAddress;
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // Function to check if a user holds a Character NFT
   function buyFishNetToken() public {
    // Check if the user is holding a Character NFT
    require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");

    // Transfer the required amount of WOOL and ROPE tokens to the contract address
    require(wool.transferFrom(msg.sender, address(this), 6), "Failed to process Wool payment!");
    require(rope.transferFrom(msg.sender, address(this), 1), "Failed to process Rope payment!");

    // Burn the transferred WOOL and ROPE tokens
    wool.burn(6);
    rope.burn(1);

    // Mint the new FishNet NFT
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(msg.sender, tokenId);
    _setTokenURI(
        tokenId,
        string(
            abi.encodePacked(
                "https://gateway.pinata.cloud/ipfs/QmYWrnfwyjb5qrKx4oBreCrHBB5yu8APV7how5XweLWmpR",
                Strings.toString(_tokenIdCounter.current()),
                ".json"
            )
        )
    );
}

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
