// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Model.sol";
import "../interface/ICollection.sol";

contract Manager is Model {
    mapping(uint256 => uint256[]) public listTokenOfOwner;
    event createNFTEvent(
        uint256 tokenId,
        address collection,
        uint256 cccd,
        uint256 durationTime,
        string nftCID
    );

    function CreateNFT(
        address collection,
        uint256 cccd,
        uint256 durationTime,
        string memory nftCID
    ) external onlyAdmin whenNotPaused {
        require(bytes(nftCID).length > 0, "nftCID > 0");

        uint256 tokenId = ICollection(collection).safeMint(msg.sender, nftCID);

        listTokenOfOwner[cccd].push(tokenId);
        emit createNFTEvent(tokenId, collection, cccd, durationTime, nftCID);
    }

    function updateNFT(
        uint256 tokenId,
        address collection,
        uint256 cccd,
        uint256 durationTime,
        string memory nftCID
    ) external onlyAdmin whenNotPaused {
        require(bytes(nftCID).length > 0, "nftCID > 0");

        delete listTokenOfOwner[cccd][tokenId];

        uint256 tokenIdUpdate = ICollection(collection).safeMint(
            msg.sender,
            nftCID
        );

        listTokenOfOwner[cccd].push(tokenIdUpdate);
        emit createNFTEvent(
            tokenIdUpdate,
            collection,
            cccd,
            durationTime,
            nftCID
        );
    }
}
