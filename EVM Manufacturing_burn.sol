// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TokenMinter {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    address private _owner;
    mapping(address => uint256) private _burnedTokens;

    mapping(string => Combination) private _combinations;

    struct Combination {
        address[1] requiredTokens;
        address[1] requiredNFTs;
        string resultingToken;
    }

    event TokenMinted(address indexed user, uint256 tokenId, string tokenType);

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the contract owner can call this function");
        _;
    }

    constructor() {
        _owner = msg.sender;
        _initializeCombinations();
    }

    function _initializeCombinations() private {
        _combinations["Mint Rope NFT"] = Combination([address(0)], [address(0)], "Rope NFT");
        _combinations["Mint Net NFT"] = Combination([address(0)], [address(this)], "Net NFT");
        _combinations["Mint Cloth NFT"] = Combination([address(0)], [address(0)], "Cloth NFT");
        _combinations["Mint Lumber NFT"] = Combination([address(0)], [address(0)], "Lumber NFT");
        _combinations["Mint Forge NFT"] = Combination([address(0)], [address(0)], "Forge NFT");
        _combinations["Mint Metal NFT"] = Combination([address(0)], [address(0)], "Metal NFT");
        _combinations["Mint Hammer NFT"] = Combination([address(0)], [address(0)], "Hammer NFT");
        _combinations["Mint Ax NFT"] = Combination([address(0)], [address(0)], "Ax NFT");
        _combinations["Mint Saw NFT"] = Combination([address(0)], [address(0)], "Saw NFT");
        _combinations["Mint Cabin NFT"] = Combination([address(0)], [address(0)], "Cabin NFT");
        _combinations["Mint Barn NFT"] = Combination([address(0)], [address(0)], "Barn NFT");
        _combinations["Mint Ship NFT"] = Combination([address(0)], [address(0)], "Ship NFT");
        _combinations["Mint New Character NFT"] = Combination([address(0)], [address(0)], "New Character NFT");
    }

    function burnAndMintERC721(
        string memory combinationName,
        uint256 amount,
        address characterNFT,
        string memory tokenType,
        string memory tokenURI
    ) external {
        require(amount > 0, "Amount must be greater than zero");
        require(bytes(tokenType).length > 0, "Token type must be specified");

        Combination storage combination = _combinations[combinationName];
        require(combination.requiredTokens.length > 0, "Invalid combination");

        for (uint256 i = 0; i < combination.requiredTokens.length; i++) {
            IERC20 token = IERC20(combination.requiredTokens[i]);
            uint256 balanceBefore = token.balanceOf(msg.sender);
            require(token.transferFrom(msg.sender, address(this), amount), "TransferFrom failed");
            uint256 balanceAfter = token.balanceOf(msg.sender);
            require(balanceBefore - balanceAfter == amount, "Invalid ERC20 transfer");
            _burnedTokens[combination.requiredTokens[i]] += amount;
        }

        _tokenIdCounter.increment();
        uint256 newTokenId = _tokenIdCounter.current();

        _mintERC721(newTokenId, combination.resultingToken, tokenURI, characterNFT);

        emit TokenMinted(msg.sender, newTokenId, combination.resultingToken);
    }

    function _mintERC721(
        uint256 tokenId,
        string memory tokenType,
        string memory tokenURI,
        address characterNFT
    ) internal {
        ERC721 token = new ERC721(tokenType, tokenType);
        token.safeMint(msg.sender, tokenId);
        token.setTokenURI(tokenId, tokenURI);

        ERC721(characterNFT).safeTransferFrom(msg.sender, address(this), tokenId);
        // You can add more custom logic here based on your requirements
    }

    function getBurnedTokenAmount(address erc20Token) external view returns (uint256) {
        return _burnedTokens[erc20Token];
    }

    function setTokenURI(
        address erc721Token,
        uint256 tokenId,
        string memory tokenURI
    ) external onlyOwner {
        ERC721(erc721Token).setTokenURI(tokenId, tokenURI);
    }
}