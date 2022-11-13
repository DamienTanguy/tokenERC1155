// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Serum is ERC1155, Ownable, ERC1155Supply {
    constructor() ERC1155("") {}

    mapping(address => uint) public numberSFTsPerUser;

    function mint(address account, uint256 id, uint256 amount)
        public
        onlyOwner
    {   
        require(amount == 1, "Only 1 Token can be minted");
        require(id > 0 && id <= 4,"ID not valid");
        require(numberSFTsPerUser[msg.sender] == 0, "The user has already minted");
        numberSFTsPerUser[msg.sender] = 1;
        _mint(account, id, amount, " ");
    }

    function uri(uint _tokenId) override public pure returns(string memory) {
        return string(abi.encodePacked(
            "ipfs://****/", //CID of JSON Files
            Strings.toString(_tokenId),
            ".json"
        ));
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
