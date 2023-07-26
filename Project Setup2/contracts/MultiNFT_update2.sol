// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MultiNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    ERC20 public paymentCurrency;
    ERC20 public wool;
    ERC20 public rope;
    ERC20 public brick;
    ERC20 public clay;
    ERC20 public iron;
    ERC20 public wood;

    // Enum to represent different collections
    enum CollectionType { FishNet, Forge, Anvil, Hammer, Axe, Saw, PickAxe, RowBoat }

    // Mapping to store the category of each token
    mapping(uint256 => CollectionType) private _tokenCollection;
    // Mapping to store whether a token is a Character NFT or not
    mapping(uint256 => bool) private _isCharacterToken;

    constructor(
        ERC20 _paymentCurrency,
        ERC20 _wool,
        ERC20 _rope,
        ERC20 _brick,
        ERC20 _clay,
        ERC20 _iron,
        ERC20 _wood
    ) ERC721("MultiNFT", "MNFT") {
        require(address(_paymentCurrency) != address(0), "Token address can't be address zero");
        paymentCurrency = _paymentCurrency;
        wool = _wool;
        rope = _rope;
        brick = _brick;
        clay = _clay;
        iron = _iron;
        wood = _wood;
    }

    // Function to buy a FishNet NFT
    function buyFishNetToken() public {
        require(wool.transferFrom(msg.sender, address(this), 6), "Failed to process Wool payment!");
        require(rope.transferFrom(msg.sender, address(this), 1), "Failed to process Rope payment!");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintCharacterFishNetToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmYWrnfwyjb5qrKx4oBreCrHBB5yu8APV7how5XweLWmpR",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a Forge NFT
    function buyForgeToken() public {
        require(brick.transferFrom(msg.sender, address(this), 100), "Failed to process Brick payment!");
        require(clay.transferFrom(msg.sender, address(this), 3), "Failed to process Clay payment!");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintCharacterForgeToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRF1j5g9tDQpsZX5zhkBo5XBsjrLk7ui6JkxjRpp5fv6r",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy an Anvil NFT
    function buyAnvilToken() public {
        require(iron.transferFrom(msg.sender, address(this), 100), "Failed to process Iron payment!");
        require(wood.transferFrom(msg.sender, address(this), 3), "Failed to process Wood payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintAnvilToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmSwejMnKMos73cGCX25GgbVMYAx1TTU1H9xWeisuoazKc",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a Hammer NFT
    function buyHammerToken() public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 1), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintHammerToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmceUyF5cXEuAxS2x8rmieyVR4PN6GuDUVR26XCaLk1Jkc",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy an Axe NFT
    function buyAxeToken() public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 2), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintAxeToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmbgGHecctuKPXaupowKPQjbiah3bN8z3RsZsy9FfgZoHX",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a Saw NFT
    function buySawToken() public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 3), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintSawToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmQEknfXffoK5TBdivL5j6y7U28zzCo75g9AtHtjvdZWZi",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a PickAxe NFT
    function buyPickAxeToken() public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 3), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        mintPickAxeToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/Qmdv8EpnjQHTtDuZeWPbXaZ82HR9sNfXdVUWSu778NGHYx",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a RowBoat NFT
    function buyRowBoatToken() public {
        require(_hasNFTOfType(msg.sender, CollectionType.Hammer), "Must be holding a Hammer NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Saw), "Must be holding a Saw NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        require(wood.transferFrom(msg.sender, address(this), 16), "Failed to process Wood payment!");
        mintRowBoatToken(
            msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmQ8W7XtXyCQVWEZfYJVYxzN7cNFdA8R5sxEdJ4dghMCow",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to mint a new Character NFT token in FishNet collection
    function mintCharacterFishNetToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _setCharacterNFT(tokenId); // Set the token as a Character NFT
        _tokenCollection[tokenId] = CollectionType.FishNet;
    }

    // Function to mint a new Character NFT token in Forge collection
    function mintCharacterForgeToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _setCharacterNFT(tokenId); // Set the token as a Character NFT
        _tokenCollection[tokenId] = CollectionType.Forge;
    }

    // Function to mint a new token in Anvil collection
    function mintAnvilToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Anvil;
    }

    // Function to mint a new token in Hammer collection
    function mintHammerToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Hammer;
    }

    // Function to mint a new token in Axe collection
    function mintAxeToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Axe;
    }

    // Function to mint a new token in Saw collection
    function mintSawToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Saw;
    }

    // Function to mint a new token in PickAxe collection
    function mintPickAxeToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.PickAxe;
    }

    // Function to mint a new token in RowBoat collection
    function mintRowBoatToken(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.RowBoat;
    }

    // Function to get the collection type of a token
    function getCollectionType(uint256 tokenId) public view returns (CollectionType) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenCollection[tokenId];
    }

    // Helper function to check if the sender holds an NFT of a specific type
    function _hasNFTOfType(address holder, CollectionType collectionType) private view returns (bool) {
        for (uint256 i = 0; i < balanceOf(holder); i++) {
            if (_tokenCollection[tokenOfOwnerByIndex(holder, i)] == collectionType) {
                return true;
            }
        }
        return false;
    }

    // Helper function to check if the sender holds a Character NFT
    function _isCharacterNFTHolder(address holder) private view returns (bool) {
        for (uint256 i = 0; i < balanceOf(holder); i++) {
            if (_isCharacterNFT(tokenOfOwnerByIndex(holder, i))) {
                return true;
            }
        }
        return false;
    }

    // Helper function to check if the given tokenId belongs to a Character NFT
    function _isCharacterNFT(uint256 tokenId) private view returns (bool) {
        return _isCharacterToken[tokenId];
    }

    // Internal function to set the Character NFT attribute for a token
    function _setCharacterNFT(uint256 tokenId) private {
        _isCharacterToken[tokenId] = true;
    }

    // The following functions are overrides required by Solidity.

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
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
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