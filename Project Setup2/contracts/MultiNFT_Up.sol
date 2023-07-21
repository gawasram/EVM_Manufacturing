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

    // Function to mint a new token in FishNet collection
    function mintFishNetToken(address to, string memory uri) public {
        require(wool.transferFrom(msg.sender, address(this), 6), "Failed to process Wool payment!");
        require(rope.transferFrom(msg.sender, address(this), 1), "Failed to process Rope payment!");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.FishNet;
    }

    // Function to mint a new token in Forge collection
    function mintForgeToken(address to, string memory uri) public {
        require(brick.transferFrom(msg.sender, address(this), 100), "Failed to process Brick payment!");
        require(clay.transferFrom(msg.sender, address(this), 3), "Failed to process Clay payment!");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Forge;
    }

    // Function to mint a new token in Anvil collection
    function mintAnvilToken(address to, string memory uri) public {
        require(iron.transferFrom(msg.sender, address(this), 100), "Failed to process Iron payment!");
        require(wood.transferFrom(msg.sender, address(this), 3), "Failed to process Wood payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Anvil;
    }

    // Function to mint a new token in Hammer collection
    function mintHammerToken(address to, string memory uri) public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 1), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Hammer;
    }

    // Function to mint a new token in Axe collection
    function mintAxeToken(address to, string memory uri) public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 2), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Axe;
    }

    // Function to mint a new token in Saw collection
    function mintSawToken(address to, string memory uri) public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 3), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.Saw;
    }

    // Function to mint a new token in PickAxe collection
    function mintPickAxeToken(address to, string memory uri) public {
        require(wood.transferFrom(msg.sender, address(this), 1), "Failed to process Wood payment!");
        require(iron.transferFrom(msg.sender, address(this), 3), "Failed to process Iron payment!");
        require(_hasNFTOfType(msg.sender, CollectionType.Forge), "Must be holding a Forge NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Anvil), "Must be holding an Anvil NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.PickAxe;
    }

    // Function to mint a new token in RowBoat collection
    function mintRowBoatToken(address to, string memory uri) public {
        require(_hasNFTOfType(msg.sender, CollectionType.Hammer), "Must be holding a Hammer NFT");
        require(_hasNFTOfType(msg.sender, CollectionType.Saw), "Must be holding a Saw NFT");
        require(_isCharacterNFTHolder(msg.sender), "Must be holding a Character NFT");
        require(wood.transferFrom(msg.sender, address(this), 16), "Failed to process Wood payment!");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _tokenCollection[tokenId] = CollectionType.RowBoat;
    }

    // Function to buy a FishNet token
    function buyFishNetToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintFishNetToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/FishNet.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a Forge token
    function buyForgeToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintForgeToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRF1j5g9tDQpsZX5zhkBo5XBsjrLk7ui6JkxjRpp5fv6r",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy an Anvil token
    function buyAnvilToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintAnvilToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/Anvil.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a Hammer token
    function buyHammerToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintHammerToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/Hammer.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy an Axe token
    function buyAxeToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintAxeToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/Axe.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a Saw token
    function buySawToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintSawToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/Saw.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a PickAxe token
    function buyPickAxeToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintPickAxeToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/PickAxe.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
    }

    // Function to buy a RowBoat token
    function buyRowBoatToken() public {
        require(paymentCurrency.transferFrom(msg.sender, address(this), 10 ether), "Failed to process payment!");
        mintRowBoatToken(msg.sender,
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmRp2mhLQw1JhDMqNpNHfD5URfeNapjJwR5GBmEg1VEugL/RowBoat.json",
                    Strings.toString(_tokenIdCounter.current()),
                    ".json"
                )
            )
        );
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
        // Replace this function with your logic to determine if a token is a Character NFT
        // For example, you can have a mapping that stores whether a token is a Character NFT or not.
        // For the sake of this example, let's assume Character NFTs have even tokenIds.
        return tokenId % 2 == 0;
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
