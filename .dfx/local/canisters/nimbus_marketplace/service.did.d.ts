import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface NFT {
  'id' : bigint,
  'creator' : string,
  'name' : string,
  'createdAt' : string,
  'description' : string,
  'currency' : string,
  'price' : number,
  'modelUrl' : string,
}
export interface _SERVICE {
  'buyNFT' : ActorMethod<[bigint, string], boolean>,
  'createNFT' : ActorMethod<[NFT], undefined>,
  'getNFTs' : ActorMethod<[], Array<NFT>>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
