
contract NFTMarketplace {

    record NFT {
        id: ByteString,
        owner: PubKeyHash,
        price: Value,
        isListed: Bool,
        auctionStart: Maybe<Integer>,
        auctionEnd: Maybe<Integer>,
        currentBid: Maybe<Value>,
        currentBidder: Maybe<PubKeyHash>
    }

    const royalty_rate = 0.01;

    pub fn list_nft(nft: NFT, seller: PubKeyHash, price: Value) -> NFT {
        assert_eq(nft.owner, seller, "Only the owner can list the NFT");
        assert_eq(nft.isListed, false, "NFT is already listed");

        NFT {
            id: nft.id,
            owner: seller,
            price: price,
            isListed: true,
            auctionStart: None,
            auctionEnd: None,
            currentBid: None,
            currentBidder: None
        }
    }

    pub fn delist_nft(nft: NFT, seller: PubKeyHash) -> NFT {
        assert_eq(nft.owner, seller, "Only the owner can delist the NFT");
        assert_eq(nft.isListed, true, "NFT is not listed");

        NFT {
            id: nft.id,
            owner: seller,
            price: nft.price,
            isListed: false,
            auctionStart: None,
            auctionEnd: None,
            currentBid: None,
            currentBidder: None
        }
    }

    pub fn buy_nft(nft: NFT, buyer: PubKeyHash, payment: Value) -> NFT {
        assert_eq(nft.isListed, true, "NFT is not listed for sale");
        assert_ge(payment, nft.price, "Insufficient payment");

        let royalty_amount = nft.price * royalty_rate;
        let seller_payment = nft.price - royalty_amount;

        NFT {
            id: nft.id,
            owner: buyer,
            price: nft.price,
            isListed: false,
            auctionStart: None,
            auctionEnd: None,
            currentBid: None,
            currentBidder: None
        }
    }
}
