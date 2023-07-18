// ImageComponent.tsx
import React, { useCallback } from "react";

interface ImageComponentProps {
  src: string;
  title: string;
  amount: string;
  offer: string;
  handleClick: (src: string, title: string, amount: string) => void; // Updated the handleClick function signature
}

const ImageComponent: React.FC<ImageComponentProps> = ({ src, title, amount, offer, handleClick }) => {
  // Wrap handleClick inside a useCallback hook
  const handleClickCallback = useCallback(() => {
    handleClick(src, title, amount);
  }, [src, title, amount]);

  return (
    <div className="col-2 Card" onClick={handleClickCallback}>
      <img src={src} alt={title} />
    </div>
  );
};

export default ImageComponent;
