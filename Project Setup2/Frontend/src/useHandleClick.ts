import { useState } from "react";


interface ImageInfo {
  title: string;
  tokenBurned: string;
  tokenReturned: string;
  createText: string;
  fetchedAmount: (amount: number) => string;
  offer: string;
}
  
  const imageInfoMap: Record<string, ImageInfo> = {
    NAILS: {
      title: "NAILS",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "NAILS NFT",
      createText: "CREATE NAILS",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    CLOTH: {
      title: "CLOTH",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "CLOTH NFT",
      createText: "CREATE CLOTH",
      fetchedAmount: (amount: number) => (amount * 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    BRICK: {
      title: "BRICK",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "BRICK NFT",
      createText: "CREATE BRICK",
      fetchedAmount: (amount: number) => (amount + 10).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    ROPE: {
      title: "ROPE",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "ROPE NFT",
      createText: "CREATE ROPE",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    LUMBER: {
      title: "LUMBER",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "LUMBER NFT",
      createText: "CREATE LUMBER",
      fetchedAmount: (amount: number) => (amount * 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    FORGE: {
      title: "FORGE",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "FORGE NFT",
      createText: "CREATE FORGE",
      fetchedAmount: (amount: number) => (amount + 10).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    HAMMER: {
      title: "HAMMER",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "HAMMER NFT",
      createText: "CREATE HAMMER",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    ANVIL: {
      title: "ANVIL",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "ANVIL NFT",
      createText: "CREATE ANVIL",
      fetchedAmount: (amount: number) => (amount * 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    BOAT: {
      title: "BOAT",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "BOAT NFT",
      createText: "CREATE BOAT",
      fetchedAmount: (amount: number) => (amount + 10).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    NET: {
      title: "NAILS",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "NET NFT",
      createText: "CREATE NET",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    SHEARS: {
      title: "CLOTH",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "SHEARS NFT",
      createText: "CREATE SHEARS",
      fetchedAmount: (amount: number) => (amount * 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    AXE: {
      title: "BRICK",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "AXE NFT",
      createText: "CREATE AXE",
      fetchedAmount: (amount: number) => (amount + 10).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 BRICK NFT", // Add the 'offer' property here
    },
    SHOVEL: {
      title: "NAILS",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "SHOVEL NFT",
      createText: "CREATE SHOVEL",
      fetchedAmount: (amount: number) => (amount / 100).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 NAILS NFT", // Add the 'offer' property here
    },
    HANDSAW: {
      title: "CLOTH",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "HANDSAW NFT",
      createText: "CREATE HANDSAW",
      fetchedAmount: (amount: number) => (amount * 2).toString(), // Add fetched amount calculation
      offer: "100 BRICK ERC20 Make 1 CLOTH NFT", // Add the 'offer' property here
    },
    PICKAXE: {
      title: "PICKAXE",
      tokenBurned: "BRICK ERC20",
      tokenReturned: "PICKAXE NFT",
      createText: "CREATE PICKAXE",
      fetchedAmount: (amount: number) => (amount + 10).toString(), // Add fetched amount calculation
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
        setFetchedAmount(imageInfo.fetchedAmount(parsedAmount).toString());
        setSelectedOffer(imageInfo.offer);
  
        // Add console.log statements to log selectedOffer and fetchedAmount
        
      } else {
        setAmount("");
        setFetchedAmount("");
        setSelectedOffer("");
      }
    };
  
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