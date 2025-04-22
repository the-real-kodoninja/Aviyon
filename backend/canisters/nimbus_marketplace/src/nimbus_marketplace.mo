import Buffer "mo:base/Buffer";
import Time "mo:base/Time";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Float "mo:base/Float";

actor {
    type NFT = {
        id: Nat;
        name: Text;
        creator: Text;
        price: Float;
        currency: Text;
        createdAt: Text;
        modelUrl: Text;
        description: Text;
    };

    stable var nftStore: [NFT] = [];
    let nfts = Buffer.Buffer<NFT>(0);

    public func createNFT(nft: NFT): async () {
        nfts.add(nft);
    };

    public query func getNFTs(): async [NFT] {
        Buffer.toArray(nfts)
    };

    public func buyNFT(id: Nat, buyer: Text): async Bool {
        // Implement purchase logic (e.g., transfer tokens)
        true
    };
};
