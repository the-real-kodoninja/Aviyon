export const idlFactory = ({ IDL }) => {
  const NFT = IDL.Record({
    'id' : IDL.Nat,
    'creator' : IDL.Text,
    'name' : IDL.Text,
    'createdAt' : IDL.Text,
    'description' : IDL.Text,
    'currency' : IDL.Text,
    'price' : IDL.Float64,
    'modelUrl' : IDL.Text,
  });
  return IDL.Service({
    'buyNFT' : IDL.Func([IDL.Nat, IDL.Text], [IDL.Bool], []),
    'createNFT' : IDL.Func([NFT], [], []),
    'getNFTs' : IDL.Func([], [IDL.Vec(NFT)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
