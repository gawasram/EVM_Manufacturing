import { useState } from "react";

export interface ImageInfo {
  title: string;
  tokenBurned: string;
  tokenReturned: string;
  createText: string;
  fetchedAmount: (amount: number) => string;
  offer: string;
}
  
  const imageInfoMap: Record<string, ImageInfo> = {
    CLOTH: {
      title: "CLOTH",
      tokenBurned: "WOOL ERC20",
      tokenReturned: "CLOTH ERC20",
      createText: "CREATE CLOTH",
      fetchedAmount: (amount: number) => (amount / 8).toString(), // Add fetched amount calculation
      offer: "800 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    BRICK: {
      title: "BRICK",
      tokenBurned: "CLAY ERC20",
      tokenReturned: "BRICK ERC20",
      createText: "CREATE BRICK",
      fetchedAmount: (amount: number) => (amount / 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    ROPE: {
      title: "ROPE",
      tokenBurned: "WOOL ERC20",
      tokenReturned: "ROPE ERC20",
      createText: "CREATE ROPE",
      fetchedAmount: (amount: number) => (amount / 3).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    IRON: {
      title: "IRON",
      tokenBurned: "ROCK ERC20 + Burn 1 WOOD",
      tokenReturned: "IRON ERC20",
      createText: "CREATE IRON",
      fetchedAmount: (amount: number) => (amount / 3).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    LUMBER: {
      title: "LUMBER",
      tokenBurned: "WOOD ERC20",
      tokenReturned: "LUMBER ERC20",
      createText: "CREATE LUMBER",
      fetchedAmount: (amount: number) => (amount / 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    FORGE: {
      title: "FORGE",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "FORGE NFT",
      createText: "CREATE FORGE",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    HAMMER: {
      title: "HAMMER",
      tokenBurned: "WOOD ERC20 & IRON ERC20 ",
      tokenReturned: "HAMMER NFT",
      createText: "CREATE HAMMER",
      fetchedAmount: (amount: number) => (amount / 1).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    ANVIL: {
      title: "ANVIL",
      tokenBurned: " IRON ERC20 & WOOD",
      tokenReturned: "ANVIL NFT",
      createText: "CREATE ANVIL",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    NET: {
      title: "NAILS",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "NET NFT",
      createText: "CREATE NET",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    AXE: {
      title: "BRICK",
      tokenBurned: "WOOD & IRON",
      tokenReturned: "AXE NFT",
      createText: "CREATE AXE",
      fetchedAmount: (amount: number) => (amount / 1).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    SAW: {
      title: "SAW",
      tokenBurned: " WOOD & IRON",
      tokenReturned: "SAW NFT",
      createText: "CREATE SAW",
      fetchedAmount: (amount: number) => (amount / 1).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    PICKAXE: {
      title: "PICKAXE",
      tokenBurned: "WOOD & IRON",
      tokenReturned: "PICKAXE NFT",
      createText: "CREATE PICKAXE",
      fetchedAmount: (amount: number) => (amount / 1).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },

    // Add more images here with their corresponding details and fetched amount calculations
  };
  
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
  
  
  export function useHandleClick({
    setSelectedImage,
    setSelectedImageTitle,
    setSelectedOffer,
    setAmount,
    setFetchedAmount,
    setTokenBurned,
    setTokenReturned,
    setCreateText,
  }: HandleClickProps) {
    const handleClick = (src: string, title: string, amount: string, offer: string) => {
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
        setFetchedAmount(imageInfo.fetchedAmount(parsedAmount).toString());
        setSelectedOffer(offer);
  
        console.log("selectedOffer:", offer);
        console.log("fetchedAmount:", imageInfo.fetchedAmount(parsedAmount).toString());
      } else {
        setAmount("");
        setFetchedAmount("");
        setSelectedOffer("");
  
        console.log("selectedOffer:", "");
        console.log("fetchedAmount:", "");
      }
    }
  const selectOffer = (title: string, amount: string) => {
    const imageInfo = imageInfoMap[title];
    if (imageInfo) {
      const parsedAmount = parseFloat(amount);
      if (!isNaN(parsedAmount)) {
        return imageInfo.fetchedAmount(parsedAmount) + " " + imageInfo.offer;
      }
    }
    return "";
  };

  return { handleClick, selectOffer };
}