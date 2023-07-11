import React, { useState, useCallback } from 'react';
import { Container, Row, Col, Card } from 'react-bootstrap';

interface Image {
  title: string;
  src: string;
}

const imgArray: Image[] = [
  // Image array code...
];

function App() {
  const [selectedImage, setSelectedImage] = useState<string | null>(null);

  const handleImageClick = useCallback((title: string) => {
    setSelectedImage(title);
  }, []);

  return (
    <main className="main">
      <div className="button-container">
        {!account ? (
          <button className="addbtn connect" onClick={handleConnectXDCPay}>
            Connect XDCPay
          </button>
        ) : (
          <button className="addbtn connected" onClick={handleDisconnectWallet}>
            {ellipseAddress(account)}
          </button>
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
                  onClick={() => handleImageClick(item.title)}
                >
                  <Card.Img variant="top" src={item.src} alt={item.title} />
                </Card>
              ))}
            </Row>
          </Col>
          <Col lg={4}>
            <h3 className="text-center">Make {selectedImage}</h3>
            <h4 className="text-center">100 BRICK make 1 FORGE</h4>
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
            <div className="text-center">
              <span className="py-2 px-5 bg-success rounded text-white text-uppercase">CREATE FORGE</span>
            </div>
          </Col>
        </Row>
      </Container>
    </main>
  );
}

export default App;