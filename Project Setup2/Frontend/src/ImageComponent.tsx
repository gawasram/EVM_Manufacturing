// ImageComponent.tsx
import React, { useCallback } from "react";

interface ImageComponentProps {
  src: string;
  title: string;
  amount: string; // Added this property
  offer: string; // Added this property
  handleClick: (src: string, title: string, amount: string, offer: string) => void; // Updated the handleClick function signature
}

const ImageComponent: React.FC<ImageComponentProps> = ({ src, title, amount, offer, handleClick }) => {
  // Wrap handleClick inside a useCallback hook
  const handleClickCallback = useCallback(() => {
    handleClick(src, title, amount, offer);
  }, [src, title, amount, offer]);

  return (
    <div className="col-2 Card" onClick={handleClickCallback}>
      <img src={src} alt={title} />
    </div>
  );
};

export default ImageComponent;
