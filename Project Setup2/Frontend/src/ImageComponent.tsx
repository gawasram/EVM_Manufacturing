// ImageComponent.tsx
import React, { useCallback, useState } from "react";

interface ImageComponentProps {
  src: string;
  title: string;
  amount: string;
  offer: string;
  handleClick: (src: string, title: string, amount: string) => void;
}

const ImageComponent: React.FC<ImageComponentProps> = ({ src, title, amount, offer, handleClick }) => {
  const [showOffer, setShowOffer] = useState(false); // Local state to control Offer visibility

  const handleClickCallback = useCallback(() => {
    handleClick(src, title, amount);
    setShowOffer(true); // Show Offer when the button is clicked
  }, [src, title, amount, handleClick]);

  return (
    <>
      <div className="col-2 Card" onClick={handleClickCallback}>
        <img src={src} alt={title} />
      </div>
      {showOffer && (
        <div>
          <p>{offer}</p>
        </div>
      )}
    </>
  );
};

export default ImageComponent;
