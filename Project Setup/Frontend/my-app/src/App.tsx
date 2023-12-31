import React, { useState, useCallback, useEffect } from "react";
import "./app.css";
import { Web3ModalContext } from "./contexts/Web3ModalProvider";
import { BlockchainContext } from "./contexts/BlockchainProvider";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Button from 'react-bootstrap/Button';
import Card from 'react-bootstrap/Card';

let imgArray: { title: string; src: string; selected: boolean; }[] = [
  { title: "FORGE", src: "https://ipfs.blocksscan.io/unsafe/https://gateway.pinata.cloud/ipfs/QmaNnS2tTaP889iQewvmx3wsQ1fyZKwdLhBwxtaSzgVmPd", selected: false },
  { title: "Furnace", src: "https://ipfs.blocksscan.io/unsafe/https://gateway.pinata.cloud/ipfs/QmaNnS2tTaP889iQewvmx3wsQ1fyZKwdLhBwxtaSzgVmPd", selected: false },
  { title: "Furnace", src: "https://ipfs.blocksscan.io/unsafe/https://gateway.pinata.cloud/ipfs/QmaNnS2tTaP889iQewvmx3wsQ1fyZKwdLhBwxtaSzgVmPd", selected: false },
  { title: "Furnace", src: "https://ipfs.blocksscan.io/unsafe/https://gateway.pinata.cloud/ipfs/QmaNnS2tTaP889iQewvmx3wsQ1fyZKwdLhBwxtaSzgVmPd", selected: false },
];

interface QuerriedOffer {
  id: number;
  offerString: string | null;
  offerCrreator: string | null;
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

  const [amount, setAmount] = useState("");
  const [fetchedAmount, setFetchedAmount] = useState("1");

  const [selectedImage, setSelectedImage] = useState("");
  const [selectedImageTitle, setSelectedImageTitle] = useState("");

  const handleClick = (src, title) => {
    setSelectedImage(src);
    setSelectedImageTitle(title);
  };

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

  // This function handle the DROP ME MORE EGT! button clicks
  const handleDrop = () => {
    if (web3 && account && chainId) {
      faucetWrapper
        ?.claimTokens()
        .then(() => {
          alert("Claimed 50 EGTS!");
        })
        .then(() => {
          window.location.reload();
        })
        .catch((err) => {
          alert(`Error: ${err.message}`);
        });
    }
  };

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
                <Card
                  className="col-2 Card"
                  key={item.title + index}
                  onClick={() => {
                    handleClick(item.src, item.title);
                  }}
                >
                  <Card.Img variant="top" src={item.src} alt={item.title} />
                </Card>
              ))}
            </Row>
          </Col>
          <Col lg={4}>
              <Col xs={12}>
              {selectedImageTitle && <p className="mt-3 fs-3"><h3 className="text-center">Make {selectedImageTitle}</h3><h4 className="text-center"><div>100 BRICK make 1 FORGE</div></h4></p>}
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
                <p className="mt-3 fs-3">BRICK ERC20</p>
              </Col>
            </Row>
            <Row className="mt-4">
  
            </Row>
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
                <p className="mt-3 fs-3">FORGE ERC721</p>
              </Col>
            </Row>
            {gachaAllowance === "0" ? (
              <div className="mintButton" onClick={handleApprove}>
                APPROVE !
              </div>
            ) : (
              <div className="mintButton" onClick={handleBuyEgg}>
                CREATE FORGE
              </div>
            )}
          </Col>
        </Row>
      </Container>
    </main>
  );
};

export default App;
