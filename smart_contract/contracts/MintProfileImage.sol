// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ProfileImageNFT is ERC721, Ownable {
    uint256 private _tokenId;

    mapping(uint256 => string) _tokenURIs;

    struct RenderToken {
        uint256 id;
        string uri;
        string space;
    }

    constructor(address initialOwner) ERC721("ProfileImageNFT", "PIN") Ownable(initialOwner) {
        require(initialOwner != address(0), "Initial owner address cannot be zero address");
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        _tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(ownerOf(tokenId) != address(0), "URI not exist on that ID");
        string memory _Uri = _tokenURIs[tokenId];
        return _Uri;
    }

    function getAllToken() public view returns (RenderToken[] memory) {
        RenderToken[] memory res = new RenderToken[](_tokenId);
        for (uint256 i = 0; i <= _tokenId; i++) {
            if (ownerOf(i) != address(0)) {
                string memory uri = tokenURI(i);
                res[i] = RenderToken(i, uri, " ");
            }
        }

        return res;
    }

    function mint(address recipents, string memory _uri) public returns (uint256) {
        uint256 newId = _tokenId;
        _mint(recipents, newId);
        _setTokenURI(newId, _uri);
        _tokenId++;
        return newId;
    }
}