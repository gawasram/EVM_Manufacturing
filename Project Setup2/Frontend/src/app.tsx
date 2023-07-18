import React, { useState, useCallback, useEffect } from "react";
import "./app.css";
import { Web3ModalContext } from "./contexts/Web3ModalProvider";
import { BlockchainContext } from "./contexts/BlockchainProvider";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import ImageComponent from "./ImageComponent";
import { imgArray } from "./imageData";
import { useHandleClick } from "./useHandleClick";


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
    eggNFT: eggNFTWrapper,
    eggToken: eggTokenWrapper,
    faucet: faucetWrapper,
    EGGS,
  } = React.useContext(BlockchainContext);

    const [selectedImage, setSelectedImage] = useState<string>("");
    const [selectedImageTitle, setSelectedImageTitle] = useState<string>("");
    const [selectedOffer, setSelectedOffer] = useState<string>(""); // Corrected name to 'selectedOffer'
    const [amount, setAmount] = useState<string>("");
    const [fetchedAmount, setFetchedAmount] = useState<string>("");
    const [tokenBurned, setTokenBurned] = useState<string>("");
    const [tokenReturned, setTokenReturned] = useState<string>("");
    const [createText, setCreateText] = useState<string>("");

    const { handleClick } = useHandleClick({
      setSelectedImage,
      setSelectedImageTitle,
      setSelectedOffer, // Corrected the name here
      setAmount,
      setFetchedAmount,
      setTokenBurned,
      setTokenReturned,
      setCreateText,
    });
  
  //console.log("selectedImage:", selectedImage);
  //console.log("selectedImageTitle:", selectedImageTitle);
  //console.log("amount:", amount);
  //console.log("fetchedAmount:", fetchedAmount);
 // console.log("tokenBurned:", tokenBurned);
  //console.log("tokenReturned:", tokenReturned);
 // console.log("createText:", createText);
  //console.log("SelectedOffer:", selectedOffer);
  
  // We need to create our balance states and gachaAllowance state:
  const [egtTokenBalance, setEgtTokenBalance] = useState("");
  const [egtNftBalance, setEgtNftBalance] = useState("");
  const [gachaAllowance, setGachaAllowance] = useState("");

  // A getBalance function that will get our EGT and EGG token balances
  const getBalances = async () => {
    if (web3 && account && chainId) {
      const _egtBalance = await eggTokenWrapper?.balanceOf();
      const _eggBalance = await eggNFTWrapper?.balanceOf();

      setEgtTokenBalance(String(Number(_egtBalance) / 10 ** 18) || "0");
      setEgtNftBalance(String(_eggBalance) || "0");
    }
  };

  // And a getGachaAllowance function to check whether
  // the EggNFT contract is allowed to spend our EGT tokens
  const getGachaAllowance = async () => {
    if (web3 && account && chainId) {
      const _gachaAllowance = await eggTokenWrapper?.allowance();
      setGachaAllowance(String(Number(_gachaAllowance) / 10 ** 18) || "0");
    }
  };

  // This useEffect will update our balances and allowance
  // so we can update our UI
  useEffect(() => {
    getBalances();
    getGachaAllowance();
  }, [web3, account, chainId]);

  // This function handle the MINT NEW EGG! button clicks
  const handleBuyEgg = () => {
    if (web3 && account && chainId) {
      eggNFTWrapper
        ?.buyEgg()
        .then(() => {
          alert("Minted FORGE!");
        })
        .then(() => {
          window.location.reload();
        })
        .catch((err) => {
          alert(`Error: ${err.message}`);
        });
    }
  };

  // This function handle the APPROVE GACHA! button clicks
  const handleApprove = () => {
    if (web3 && account && chainId) {
      eggTokenWrapper
        ?.approve()
        .then(() => {
          alert("Approved!");
        })
        .then(() => {
          window.location.reload();
        })
        .catch((err) => {
          alert(`Error: ${err.message}`);
        });
    }
  };

  // <=== This section of the code is pretty much left unchanged ===>

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
                offer={item.offer} // Update the prop name to 'offer'
                handleClick={() => {
                  handleClick(item.src, item.title, amount);
                }}
              />
              ))}
            </Row>
          </Col>
          <Col lg={4}>
            <Col xs={12}>
            {selectedImageTitle && (
  <div className="mt-3 fs-3">
    <h3 className="text-center">Make {selectedImageTitle} {selectedOffer}</h3>
                  <h4 className="text-center">
                    <div>
                      {amount}
                    </div>
                  </h4>
                </div>
              )}
            </Col>
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
                <span className="fs-3 ms-4">&nbsp;&nbsp;{amount}</span> {/* Use 'amount' here instead of 'fetchedAmount' */}
              </Col>
              <Col xs={6}>
                <h6 className="fs-4">Token Returned</h6>
                <p className="mt-3 fs-3">{tokenReturned}</p>
              </Col>
            </Row>
            {gachaAllowance === "0" ? (
              <div className="mintButton" onClick={handleApprove}>
                APPROVE !
              </div>
            ) : (
              <div className="mintButton" onClick={handleBuyEgg}>
                {createText}
              </div>
            )}
          </Col>
        </Row>
      </Container>
    </main>
  );
};

export default App;