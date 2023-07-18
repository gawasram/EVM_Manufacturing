// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

// Import ERC20 and ERC721 interfaces
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

// Import OpenZeppelin ERC20 and ERC721 implementations
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract TokenExchangeContract {
    // Address of the ERC20 and ERC721 tokens to be burned
    address public woolERC20TokenAddress;
    address public ropeERC20TokenAddress;
    address public clayERC20TokenAddress;
    address public rockERC20TokenAddress;
    address public woodERC20TokenAddress;
    address public brickERC20TokenAddress;
    address public ironERC20TokenAddress;
    address public lumberERC20TokenAddress;

     // Address of the ERC721 tokens to be burned
    address public characterNFTTokenAddress;
    address public forgeNFTTokenAddress;
    address public sawNFTTokenAddress;
    address public hammerNFTTokenAddress;
    address public axNFTTokenAddress;
    address public rowboatNFTTokenAddress;
    address public anvilNFTTokenAddress;
    address public pickaxeNFTTokenAddress;

    // Address of the ERC20 and ERC721 tokens to be minted
    address public ropeMintedERC20TokenAddress;
    address public clothMintedERC20TokenAddress;
    address public brickMintedERC20TokenAddress;
    address public ironMintedERC20TokenAddress;
    address public lumberMintedERC20TokenAddress;

    // Address of the ERC721 tokens to be minted
    address public fishNetMintedNFTTokenAddress;
    address public forgeMintedNFTTokenAddress;
    address public anvilMintedNFTTokenAddress;
    address public hammerMintedNFTTokenAddress;
    address public axMintedNFTTokenAddress;
    address public sawMintedNFTTokenAddress;
    address public pickaxeMintedNFTTokenAddress;
    address public rowboatMintedNFTTokenAddress;

    constructor(
        address _woolERC20TokenAddress,
        address _ropeERC20TokenAddress,
        address _clayERC20TokenAddress,
        address _rockERC20TokenAddress,
        address _woodERC20TokenAddress,
        address _brickERC20TokenAddress,
        address _ironERC20TokenAddress,
        address _lumberERC20TokenAddress,
        address _characterNFTTokenAddress,
        address _forgeNFTTokenAddress,
        address _sawNFTTokenAddress,
        address _hammerNFTTokenAddress,
        address _axNFTTokenAddress,
        address _rowboatNFTTokenAddress,
        address _ropeMintedERC20TokenAddress,
        address _clothMintedERC20TokenAddress,
        address _brickMintedERC20TokenAddress,
        address _ironMintedERC20TokenAddress,
        address _lumberMintedERC20TokenAddress,
        address _fishNetMintedNFTTokenAddress,
        address _forgeMintedNFTTokenAddress,
        address _anvilMintedNFTTokenAddress,
        address _hammerMintedNFTTokenAddress,
        address _axMintedNFTTokenAddress,
        address _sawMintedNFTTokenAddress,
        address _pickaxeMintedNFTTokenAddress,
        address _rowboatMintedNFTTokenAddress,
        address _anvilNFTTokenAddress, 
        address _pickaxeNFTTokenAddress 
    ) {
        woolERC20TokenAddress = _woolERC20TokenAddress;
        ropeERC20TokenAddress = _ropeERC20TokenAddress;
        clayERC20TokenAddress = _clayERC20TokenAddress;
        rockERC20TokenAddress = _rockERC20TokenAddress;
        woodERC20TokenAddress = _woodERC20TokenAddress;
        brickERC20TokenAddress = _brickERC20TokenAddress;
        ironERC20TokenAddress = _ironERC20TokenAddress;
        lumberERC20TokenAddress = _lumberERC20TokenAddress;

        characterNFTTokenAddress = _characterNFTTokenAddress;
        forgeNFTTokenAddress = _forgeNFTTokenAddress;
        sawNFTTokenAddress = _sawNFTTokenAddress;
        hammerNFTTokenAddress = _hammerNFTTokenAddress;
        axNFTTokenAddress = _axNFTTokenAddress;
        rowboatNFTTokenAddress = _rowboatNFTTokenAddress;
        anvilNFTTokenAddress = _anvilNFTTokenAddress; // Added this line
        pickaxeNFTTokenAddress = _pickaxeNFTTokenAddress; // Added this line

        ropeMintedERC20TokenAddress = _ropeMintedERC20TokenAddress;
        clothMintedERC20TokenAddress = _clothMintedERC20TokenAddress;
        brickMintedERC20TokenAddress = _brickMintedERC20TokenAddress;
        ironMintedERC20TokenAddress = _ironMintedERC20TokenAddress;
        lumberMintedERC20TokenAddress = _lumberMintedERC20TokenAddress;

        fishNetMintedNFTTokenAddress = _fishNetMintedNFTTokenAddress;
        forgeMintedNFTTokenAddress = _forgeMintedNFTTokenAddress;
        anvilMintedNFTTokenAddress = _anvilMintedNFTTokenAddress;
        hammerMintedNFTTokenAddress = _hammerMintedNFTTokenAddress;
        axMintedNFTTokenAddress = _axMintedNFTTokenAddress;
        sawMintedNFTTokenAddress = _sawMintedNFTTokenAddress;
        pickaxeMintedNFTTokenAddress = _pickaxeMintedNFTTokenAddress;
        rowboatMintedNFTTokenAddress = _rowboatMintedNFTTokenAddress;
    }

    // Function to burn ERC20 and ERC721 tokens to mint new ERC20 and ERC721 tokens
    function burnToMintRope() external {
        uint256 amount = 3;
        require(IERC20(woolERC20TokenAddress).balanceOf(msg.sender) >= amount, "Insufficient WOOL balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn WOOL ERC20 tokens
        ERC20Burnable(woolERC20TokenAddress).burnFrom(msg.sender, amount);


        // Mint ROPE ERC20 tokens to the caller
        ERC20Burnable(ropeMintedERC20TokenAddress).burnFrom(msg.sender, amount);
    }

    function burnToMintCloth() external {
        uint256 amount = 8;
        require(IERC20(woolERC20TokenAddress).balanceOf(msg.sender) >= amount, "Insufficient WOOL balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn WOOL ERC20 tokens
        ERC20Burnable(woolERC20TokenAddress).burnFrom(msg.sender, amount);


        // Mint CLOTH ERC20 tokens to the caller
        ERC20Burnable(clothMintedERC20TokenAddress).burnFrom(msg.sender, 1);
    }

    function burnToMintBrick() external {
        uint256 amount = 2;
        require(IERC20(clayERC20TokenAddress).balanceOf(msg.sender) >= amount, "Insufficient CLAY balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn CLAY ERC20 tokens
        ERC20Burnable(clayERC20TokenAddress).burnFrom(msg.sender, amount);

        // Mint BRICK ERC20 tokens to the caller
        ERC20Burnable(brickMintedERC20TokenAddress).burnFrom(msg.sender, 1);
    }

    function burnToMintIron() external {
        uint256 rockAmount = 3;
        uint256 woodAmount = 1;
        require(IERC20(rockERC20TokenAddress).balanceOf(msg.sender) >= rockAmount, "Insufficient ROCK balance");
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC721(forgeNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a FORGE NFT");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn ROCK ERC20 tokens
        IERC20(rockERC20TokenAddress).burnFrom(msg.sender, rockAmount);

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Mint IRON ERC20 tokens to the caller
        IERC20(ironMintedERC20TokenAddress).mint(msg.sender, 1);
    }

    function burnToMintLumber() external {
        uint256 woodAmount = 2;
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC721(sawNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a SAW NFT");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Mint LUMBER ERC20 tokens to the caller
        IERC20(lumberMintedERC20TokenAddress).mint(msg.sender, 1);
    }

    function burnToMintFishNet() external {
        uint256 woolAmount = 6;
        uint256 ropeAmount = 1;
        require(IERC20(woolERC20TokenAddress).balanceOf(msg.sender) >= woolAmount, "Insufficient WOOL balance");
        require(IERC20(ropeERC20TokenAddress).balanceOf(msg.sender) >= ropeAmount, "Insufficient ROPE balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn WOOL ERC20 tokens
        IERC20(woolERC20TokenAddress).burnFrom(msg.sender, woolAmount);

        // Burn ROPE ERC20 tokens
        IERC20(ropeERC20TokenAddress).burnFrom(msg.sender, ropeAmount);

        // Mint FISH NET NFT to the caller
        IERC721(fishNetMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintForge() external {
        uint256 brickAmount = 100;
        uint256 clayAmount = 3;
        require(IERC20(brickERC20TokenAddress).balanceOf(msg.sender) >= brickAmount, "Insufficient BRICK balance");
        require(IERC20(clayERC20TokenAddress).balanceOf(msg.sender) >= clayAmount, "Insufficient CLAY balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");

        // Burn BRICK ERC20 tokens
        IERC20(brickERC20TokenAddress).burnFrom(msg.sender, brickAmount);

        // Burn CLAY ERC20 tokens
        IERC20(clayERC20TokenAddress).burnFrom(msg.sender, clayAmount);

        // Mint FORGE NFT to the caller
        IERC721(forgeMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintAnvil() external {
        uint256 ironAmount = 100;
        uint256 woodAmount = 3;
        require(IERC20(ironERC20TokenAddress).balanceOf(msg.sender) >= ironAmount, "Insufficient IRON balance");
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");
        require(IERC721(forgeNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a FORGE NFT");

        // Burn IRON ERC20 tokens
        IERC20(ironERC20TokenAddress).burnFrom(msg.sender, ironAmount);

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Mint ANVIL NFT to the caller
        IERC721(anvilMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintHammer() external {
        uint256 woodAmount = 1;
        uint256 ironAmount = 1;
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC20(ironERC20TokenAddress).balanceOf(msg.sender) >= ironAmount, "Insufficient IRON balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");
        require(IERC721(forgeNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a FORGE NFT");
        require(IERC721(anvilNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold an ANVIL NFT");

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Burn IRON ERC20 tokens
        IERC20(ironERC20TokenAddress).burnFrom(msg.sender, ironAmount);

        // Mint HAMMER NFT to the caller
        IERC721(hammerMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintAx() external {
        uint256 woodAmount = 1;
        uint256 ironAmount = 2;
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC20(ironERC20TokenAddress).balanceOf(msg.sender) >= ironAmount, "Insufficient IRON balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");
        require(IERC721(forgeNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a FORGE NFT");
        require(IERC721(anvilNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold an ANVIL NFT");

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Burn IRON ERC20 tokens
        IERC20(ironERC20TokenAddress).burnFrom(msg.sender, ironAmount);

        // Mint AX NFT to the caller
        IERC721(axMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintSaw() external {
        uint256 woodAmount = 1;
        uint256 ironAmount = 3;
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC20(ironERC20TokenAddress).balanceOf(msg.sender) >= ironAmount, "Insufficient IRON balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");
        require(IERC721(forgeNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a FORGE NFT");
        require(IERC721(anvilNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold an ANVIL NFT");

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Burn IRON ERC20 tokens
        IERC20(ironERC20TokenAddress).burnFrom(msg.sender, ironAmount);

        // Mint SAW NFT to the caller
        IERC721(sawMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintPickaxe() external {
        uint256 woodAmount = 1;
        uint256 ironAmount = 3;
        require(IERC20(woodERC20TokenAddress).balanceOf(msg.sender) >= woodAmount, "Insufficient WOOD balance");
        require(IERC20(ironERC20TokenAddress).balanceOf(msg.sender) >= ironAmount, "Insufficient IRON balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");
        require(IERC721(forgeNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a FORGE NFT");
        require(IERC721(anvilNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold an ANVIL NFT");

        // Burn WOOD ERC20 tokens
        IERC20(woodERC20TokenAddress).burnFrom(msg.sender, woodAmount);

        // Burn IRON ERC20 tokens
        IERC20(ironERC20TokenAddress).burnFrom(msg.sender, ironAmount);

        // Mint PICKAXE NFT to the caller
        IERC721(pickaxeMintedNFTTokenAddress).mint(msg.sender, 1);
    }

    function burnToMintRowboat() external {
        uint256 lumberAmount = 16;
        require(IERC20(lumberERC20TokenAddress).balanceOf(msg.sender) >= lumberAmount, "Insufficient LUMBER balance");
        require(IERC721(characterNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a Character NFT");
        require(IERC721(hammerNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a HAMMER NFT");
        require(IERC721(sawNFTTokenAddress).balanceOf(msg.sender) > 0, "Must hold a SAW NFT");

        // Burn LUMBER ERC20 tokens
        IERC20(lumberERC20TokenAddress).burnFrom(msg.sender, lumberAmount);

        // Mint ROWBOAT NFT to the caller
        IERC721(rowboatMintedNFTTokenAddress).mint(msg.sender, 1);
    }
}
