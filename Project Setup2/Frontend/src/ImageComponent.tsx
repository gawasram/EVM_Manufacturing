import React, { useCallback } from "react";

interface ImageComponentProps {
  src: string;
  title: string;
  amount: string;
  offer: string;
  handleClick: () => void; 
  isShowOffer: boolean;
  setShowOffer: React.Dispatch<React.SetStateAction<boolean>>;
}

const ImageComponent: React.FC<ImageComponentProps> = ({
  src,
  title,
  amount,
  offer,
  handleClick,
  isShowOffer,
  setShowOffer,
}) => {
  const handleClickCallback = useCallback(() => {
    handleClick();
    setShowOffer(true); // Since isShowOffer is not being passed directly, use the setter function here
  }, [handleClick, setShowOffer]);

  return (
    <div className="col-2 Card" onClick={handleClickCallback}>
      <img src={src} alt={title} />
    </div>
  );
};

export default ImageComponent;
