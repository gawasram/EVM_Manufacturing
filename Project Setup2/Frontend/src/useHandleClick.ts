import { useState } from "react";

interface HandleClickProps {
  setSelectedImage: (src: string) => void;
  setSelectedImageTitle: (title: string) => void;
  setSelectOffer: (offer: string) => void;
  setAmount: (amount: string) => void;
  setFetchedAmount: (amount: string) => void;
  setTokenBurned: (token: string) => void;
  setTokenReturned: (token: string) => void;
  setCreateText: (text: string) => void;
}

interface ImageInfo {
  title: string;
  tokenBurned: string;
  tokenReturned: string;
  createText: string;
  fetchedAmount: (amount: number) => string;
}

const imageInfoMap: Record<string, ImageInfo> = {
  NAILS: {
    title: "NAILS",
    tokenBurned: "BRICK ERC20",
    tokenReturned: "NAILS NFT",
    createText: "CREATE NAILS",
    fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
  },
  CLOTH: {
    title: "CLOTH",
    tokenBurned: "BRICK ERC20",
    tokenReturned: "CLOTH NFT",
    createText: "CREATE CLOTH",
    fetchedAmount: (amount: number) => (amount * 2).toString(), // Add fetched amount calculation
  },
  BRICK: {
    title: "BRICK",
    tokenBurned: "BRICK ERC20",
    tokenReturned: "BRICK NFT",
    createText: "CREATE BRICK",
    fetchedAmount: (amount: number) => (amount + 10).toString(), // Add fetched amount calculation
  },
  // Add more images here with their corresponding details and fetched amount calculations
};

const useHandleClick = ({
  setSelectedImage,
  setSelectedImageTitle,
  setSelectOffer,
  setAmount,
  setFetchedAmount,
  setTokenBurned,
  setTokenReturned,
  setCreateText,
}: HandleClickProps) => {
  const handleClick = (src: string, title: string, amount: string) => {
    setSelectedImage(src);
    setSelectedImageTitle(title);

    const imageInfo = imageInfoMap[title];

    if (imageInfo) {
      setTokenBurned(imageInfo.tokenBurned);
      setTokenReturned(imageInfo.tokenReturned);
      setCreateText(imageInfo.createText);
    } else {
      setTokenBurned("");
      setTokenReturned("");
      setCreateText("");
    }

    const parsedAmount = parseFloat(amount);
    if (!isNaN(parsedAmount)) {
      setAmount(amount);
      setFetchedAmount(imageInfo.fetchedAmount(parsedAmount));
      setSelectOffer(selectOffer(title, amount, imageInfo.offer)); // Update the offer for the selected image
    } else {
      setAmount("");
      setFetchedAmount("");
      setSelectOffer(""); // Clear the offer if the amount is not valid
    }
  };

  const selectOffer = (title: string, amount: string, offer: string) => {
    const imageInfo = imageInfoMap[title];
    if (imageInfo) {
      const parsedAmount = parseFloat(amount);
      if (!isNaN(parsedAmount)) {
        // Calculate the offer based on the selected image and amount
        return imageInfo.fetchedAmount(parsedAmount) + " " + imageInfo.offer;
      }
    }
    return "";
  };

  return { handleClick, selectOffer };
};


export default useHandleClick;