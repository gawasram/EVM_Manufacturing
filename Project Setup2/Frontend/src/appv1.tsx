import React, { useState, useCallback, useEffect } from "react";
import "./app.css";
import { Web3ModalContext } from "./contexts/Web3ModalProvider";
import { BlockchainContext } from "./contexts/BlockchainProvider";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import ImageComponent from "./ImageComponent";
import { imgArray } from "./imageData";
import { useHandleClick, ImageInfo } from "./useHandleClick";
import { HashLoader } from "react-spinners";


interface HandleClickProps {
  setSelectedImage: (src: string) => void;
  setSelectedImageTitle: (title: string) => void;
  setSelectedOffer: (offer: string) => void;
  setAmount: (amount: string) => void;
  setFetchedAmount: (amount: string) => void;
  setTokenBurned: (token: string) => void;
  setTokenReturned: (token: string) => void;
  setCreateText: (text: string) => void;
}

const App: React.FC = () => {
  const [slide, setSlide] = useState(0);

  const { web3, account, connect, disconnect, chainId } =
    React.useContext(Web3ModalContext);

  const {
    woodInTheBlockchainLand: WoodInTheBlockchainLandWrapper,
    rockInTheBlockchainLand: RockInTheBlockchainLandWrapper,
    CLAYInTheBlockchainLand: CLAYInTheBlockchainLandWrapper,
    woolInTheBlockchainLand: WoolInTheBlockchainLandWrapper,
    fishInTheBlockchainLand: FishInTheBlockchainLandWrapper,
    ropeToken: ropeTokenWrapper,
    clothToken: clothTokenWrapper,
    brickToken: brickTokenWrapper,
    ironToken: ironTokenWrapper,
    lumberToken: lumberTokenWrapper
  } = React.useContext(BlockchainContext);

  const [selectedImage, setSelectedImage] = useState<string>("");
  const [selectedImageTitle, setSelectedImageTitle] = useState<string>("");
  const [selectedOffer, setSelectedOffer] = useState<string>("");
  const [amount, setAmount] = useState<string>("");
  const [fetchedAmount, setFetchedAmount] = useState<string>("");
  const [tokenBurned, setTokenBurned] = useState<string>("");
  const [tokenReturned, setTokenReturned] = useState<string>("");
  const [createText, setCreateText] = useState<string>("");
  const { handleClick, selectOffer } = useHandleClick({
    setSelectedImage,
    setSelectedImageTitle,
    setSelectedOffer,
    setAmount,
    setFetchedAmount,
    setTokenBurned,
    setTokenReturned,
    setCreateText,
  });

  const [isShowOffer, setIsShowOffer] = useState(false);

  // We need to create our balance states and gachaAllowance state:
  const [egtTokenBalance, setEgtTokenBalance] = useState("");
  const [egtNftBalance, setEgtNftBalance] = useState("");

  //approvals for tokens to burn
  const [isApproved, setIsApproved] = useState({
    WOOD: false,
    ROCK: false,
    CLAY: false,
    WOOL: false,
    FISH: false,
    ROPE: false,
    CLOTH: false,
    BRICK: false,
    IRON: false,
    LUMBER: false
  });

  //allowance status
  const [woodAllowance, setWoodAllowance] = useState("");
  const [rockAllowance, setRockAllowance] = useState("");
  const [clayAllowance, setClayAllowance] = useState("");
  const [woolAllowance, setWoolAllowance] = useState("");
  const [fishAllowance, setFishAllowance] = useState("");
  const [ropeAllowance, setRopeAllowance] = useState("");
  const [clothAllowance, setClothAllowance] = useState("");
  const [brickAllowance, setBrickAllowance] = useState("");
  const [ironAllowance, setIronAllowance] = useState("");
  const [lumberAllowance, setLumberAllowance] = useState("");


  //Loading state
  const [loading, setLoading] = useState<boolean>(false)

  const [currentIndex, setCurrentIndex] = useState(0);

  const [buttonName, setButtonName] = useState("Mint");


  // // A getBalance function that will get our EGT and EGG token balances
  // const getBalances = async () => {
  //   if (web3 && account && chainId) {
  //     const _egtBalance = await eggTokenWrapper?.balanceOf();
  //     const _eggBalance = await eggNFTWrapper?.balanceOf();

  //     setEgtTokenBalance(String(Number(_egtBalance) / 10 ** 18) || "0");
  //     setEgtNftBalance(String(_eggBalance) || "0");
  //   }
  // };

  const getTokenAllowances = async () => {
    if (web3 && account && chainId) {
      if (web3 && account && chainId) {
        const _woodAllowance = await WoodInTheBlockchainLandWrapper?.allowance(1);
        setWoodAllowance(String(Number(_woodAllowance) / 10 ** 18) || "0");

        const _rockAllowance = await RockInTheBlockchainLandWrapper?.allowance(1);
        setRockAllowance(String(Number(_rockAllowance) / 10 ** 18) || "0");

        const _clayAllowance = await CLAYInTheBlockchainLandWrapper?.allowance(1);
        setClayAllowance(String(Number(_clayAllowance) / 10 ** 18) || "0");

        const _woolAllowance = await WoolInTheBlockchainLandWrapper?.allowance(1);
        setWoolAllowance(String(Number(_woolAllowance) / 10 ** 18) || "0");

        const _fishAllowance = await FishInTheBlockchainLandWrapper?.allowance(1);
        setFishAllowance(String(Number(_fishAllowance) / 10 ** 18) || "0");

        const _ropeAllowance = await ropeTokenWrapper?.allowance(1);
        setRopeAllowance(String(Number(_ropeAllowance) / 10 ** 18) || "0");

        const _clothAllowance = await clothTokenWrapper?.allowance(1);
        setClothAllowance(String(Number(_clothAllowance) / 10 ** 18) || "0");

        const _brickAllowance = await brickTokenWrapper?.allowance(1);
        setBrickAllowance(String(Number(_brickAllowance) / 10 ** 18) || "0");

        const _ironAllowance = await ironTokenWrapper?.allowance(1);
        setIronAllowance(String(Number(_ironAllowance) / 10 ** 18) || "0");

        const _lumberAllowance = await lumberTokenWrapper?.allowance(1);
        setLumberAllowance(String(Number(_lumberAllowance) / 10 ** 18) || "0");
      }
    }
  }



  // This useEffect will update our balances and allowance
  // so we can update our UI
  useEffect(() => {
    // getBalances();
    getTokenAllowances();
  }, [web3, account, chainId]);

  // This function handle the MINT NEW EGG! button clicks
  const handleMint = (_index) => {
    if (web3 && account && chainId) {
      console.log(_index);

      // eggNFTWrapper
      //   ?.buyEgg()
      //   .then(() => {
      //     alert("Minted FORGE!");
      //   })
      //   .then(() => {
      //     window.location.reload();
      //   })
      //   .catch((err) => {
      //     alert(`Error: ${err.message}`);
      //   });
    }
  };

  // This function handle the APPROVE GACHA! button clicks
  // const handleApprove = () => {
  //   if (web3 && account && chainId) {
  //     eggTokenWrapper
  //       ?.approve()
  //       .then(() => {
  //         alert("Approved!");
  //       })
  //       .then(() => {
  //         window.location.reload();
  //       })
  //       .catch((err) => {
  //         alert(`Error: ${err.message}`);
  //       });
  //   }
  // };

  const handleConnectWallet = useCallback(() => {
    connect();
  }, [connect]);

  const handleDisconnectWallet = useCallback(() => {
    disconnect();
  }, [disconnect]);

  function ellipseAddress(address: string = "", width: number = 4): string {
    return `xdc${address.slice(2, width + 2)}...${address.slice(-width)}`;
  }

  return (
    <main className="main">
      <div className="button-container">
        {!account ? (
          <div className={"connect"} onClick={handleConnectWallet}>
            CONNECT WALLET
          </div>
        ) : (
          <div className={"connect"} onClick={handleDisconnectWallet}>
            {ellipseAddress(account)}
          </div>
        )}
      </div>
      <Container>
        <Row>
          <Col lg={8}>
            <h1>Manufacturing (List of Build Options)</h1>
            <Row>
              {imgArray.map((item, index) => (
                <ImageComponent
                  key={item.title + index}
                  src={item.src}
                  title={item.title}
                  amount={amount}
                  offer={item.offer}
                  handleClick={() => handleClick(item.src, item.title, item.amount, item.offer)}
                  isShowOffer={isShowOffer}
                  setShowOffer={setIsShowOffer}
                />
              ))}
            </Row>
          </Col>
          <Col lg={4}>
            <Col xs={12}>
              {selectedImageTitle && (
                <div className="mt-3 fs-3">
                  <h3 className="text-center">Make {selectedImageTitle}</h3>
                </div>
              )}

            </Col>
            {isShowOffer && (
              <div>
                <h5><p>{selectedOffer}</p></h5>
              </div>
            )}
            <Row className="mt-4">
              <Col xs={6}>
                <h6>
                  <label htmlFor="amount" className="d-block fs-4">
                    Amount
                  </label>
                </h6>
                <input
                  type="number"
                  id="amount"
                  className="form-control py-4 ps-3 pe-0 border-dark w-50"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                />
              </Col>
              <Col xs={6}>
                <h6 className="fs-4">Token burned</h6>
                <p className="mt-3 fs-3">{tokenBurned}</p>
              </Col>
            </Row>
            <Row className="mt-4"></Row>
            <Row className="mt-4">
              <Col xs={6}>
                <h6>
                  <label htmlFor="amount" className="d-block fs-4">
                    Amount
                  </label>
                </h6>
                <span className="fs-3 ms-4">&nbsp;&nbsp;{fetchedAmount}</span>
              </Col>
              <Col xs={6}>
                <h6 className="fs-4">Token Returned</h6>
                <p className="mt-3 fs-3">{tokenReturned}</p>
              </Col>
            </Row>
            <div>
              {
                loading ? <HashLoader color="#0ca02c" /> : <button className="mintButton" id="create-offer" onClick={() => {
                  buttonName === "Mint" ? handleMint(currentIndex) :
                    // buttonName === 'Approve WOOD' ? handleApproveWood(index) :
                    //   buttonName === 'Approve ROCK' ? handleApproveRock(index) :
                    //     buttonName === 'Approve CLAY' ? handleApproveClay(index) :
                    //       buttonName === 'Approve WOOL' ? handleApproveWool(index) :
                    //         buttonName === 'Approve FISH' ? handleApproveFish(index) :
                    //           buttonName === 'Approve CLOTH' ? handleApproveCloth(index) :
                    //             buttonName === 'Approve BRICK' ? handleApproveBrick(index) :
                    //               buttonName === 'Approve ROPE' ? handleApproveRope(index) :
                    //                 buttonName === 'Approve IRON' ? handleApproveIron(index) :
                    //                   buttonName === 'Approve LUMBER' ? handleApproveLumber(index) :
                    //                     buttonName === 'transact' ? handleMint(index) :
                    console.log("")
                }}
                >
                  {buttonName}
                </button>
              }
            </div>
          </Col>
        </Row>
      </Container>
    </main>
  );
};

export default App;