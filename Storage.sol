// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Storage {
    struct CustomData {
        uint256 integerValue;
        string stringValue;
        bytes32 bytes32Value;
        bool booleanValue;
    }

    mapping(bytes32 => CustomData) public dataMapping;

    event CustomDataUpdated(bytes32 indexed key, uint256 integerValue, string stringValue, bytes32 bytes32Value, bool booleanValue);
    event CustomDataDeleted(bytes32 indexed key);

    function convertStringToBytes32(string memory _str) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_str));
    }

    function setCustomDataByKey(
        string memory key,
        uint256 _integerValue,
        string memory _stringValue,
        string memory _bytes32Value, // Используем строку вместо bytes32
        bool _booleanValue
    ) public {
        bytes32 convertedKey = convertStringToBytes32(key);
        bytes32 convertedBytes32Value = convertStringToBytes32(_bytes32Value);

        CustomData storage newData = dataMapping[convertedKey];
        newData.integerValue = _integerValue;
        newData.stringValue = _stringValue;
        newData.bytes32Value = convertedBytes32Value;
        newData.booleanValue = _booleanValue;

        emit CustomDataUpdated(convertedKey, _integerValue, _stringValue, convertedBytes32Value, _booleanValue);
    }

    function getCustomDataByKey(string memory key) public view returns (CustomData memory) {
        bytes32 convertedKey = convertStringToBytes32(key);
        return dataMapping[convertedKey];
    }

    function deleteCustomDataByKey(string memory key) public {
        bytes32 convertedKey = convertStringToBytes32(key);
        delete dataMapping[convertedKey];
        emit CustomDataDeleted(convertedKey);
    }
}
