/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Interface, type ContractRunner } from "ethers";
import type {
  IOFTReceiverV2,
  IOFTReceiverV2Interface,
} from "../../../contracts/interfaces/IOFTReceiverV2";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint16",
        name: "_srcChainId",
        type: "uint16",
      },
      {
        internalType: "bytes",
        name: "_srcAddress",
        type: "bytes",
      },
      {
        internalType: "uint64",
        name: "_nonce",
        type: "uint64",
      },
      {
        internalType: "bytes32",
        name: "_from",
        type: "bytes32",
      },
      {
        internalType: "uint256",
        name: "_amount",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "_payload",
        type: "bytes",
      },
    ],
    name: "onOFTReceived",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

export class IOFTReceiverV2__factory {
  static readonly abi = _abi;
  static createInterface(): IOFTReceiverV2Interface {
    return new Interface(_abi) as IOFTReceiverV2Interface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): IOFTReceiverV2 {
    return new Contract(address, _abi, runner) as unknown as IOFTReceiverV2;
  }
}