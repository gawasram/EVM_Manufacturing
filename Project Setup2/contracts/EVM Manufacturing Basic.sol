// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Import ERC20 and ERC721 interfaces
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

// Import OpenZeppelin ERC20 and ERC721 implementations
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract TokenExchangeContract {
    // Address of the ERC20 token to be burned
    address public erc20TokenAddress;
    // Address of the ERC721 token to be burned
    address public erc721TokenAddress;
    // Address of the ERC20 token to be minted
    address public mintedERC20TokenAddress;
    // Address of the ERC721 token to be minted
    address public mintedERC721TokenAddress;

    // Events to track token burning and minting
    event TokensBurned(address indexed burner, uint256 amount);
    event ERC721TokensBurned(address indexed burner, uint256 tokenId);
    event ERC20TokensMinted(address indexed receiver, uint256 amount);
    event ERC721TokensMinted(address indexed receiver, uint256 tokenId);

    constructor(
        address _erc20TokenAddress,
        address _erc721TokenAddress,
        address _mintedERC20TokenAddress,
        address _mintedERC721TokenAddress
    ) {
        erc20TokenAddress = _erc20TokenAddress;
        erc721TokenAddress = _erc721TokenAddress;
        mintedERC20TokenAddress = _mintedERC20TokenAddress;
        mintedERC721TokenAddress = _mintedERC721TokenAddress;
    }

    // Function to burn ERC20 tokens and mint new ERC20 tokens
    function burnERC20ToMintERC20(uint256 _amount) external {
        // Transfer the ERC20 tokens from the caller to this contract
        IERC20(erc20TokenAddress).transferFrom(msg.sender, address(this), _amount);

        // Burn the ERC20 tokens
        ERC20Burnable(erc20TokenAddress).burn(_amount);

        // Mint the new ERC20 tokens to the caller
        IERC20(mintedERC20TokenAddress).mint(msg.sender, _amount);

        emit TokensBurned(msg.sender, _amount);
        emit ERC20TokensMinted(msg.sender, _amount);
    }

    // Function to burn ERC721 tokens and mint new ERC721 tokens
    function burnERC721ToMintERC721(uint256 _tokenId) external {
        // Transfer the ERC721 token from the caller to this contract
        IERC721(erc721TokenAddress).transferFrom(msg.sender, address(this), _tokenId);

        // Burn the ERC721 token
        IERC721(erc721TokenAddress).burn(_tokenId);

        // Mint the new ERC721 token to the caller
        ERC721Enumerable(mintedERC721TokenAddress).mint(msg.sender);

        emit ERC721TokensBurned(msg.sender, _tokenId);
        emit ERC721TokensMinted(msg.sender, _tokenId);
    }
}
