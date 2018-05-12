pragma solidity ^0.4.17;


contract UserInit {
    event LogNewUser   (address indexed userAddress, uint index, bytes32 userName, bytes32 userEmail, uint userAge);
    event LogUpdateUser(address indexed userAddress, uint index, bytes32 userName, bytes32 userEmail, uint userAge);
    event LogDeleteUser(address indexed userAddress, uint index);

    struct UserStruct {
        bytes32 userEmail;
        bytes32 userName;
        uint userAge;
        uint index;
    }

    mapping(address => UserStruct) private userStructs;
    address[] private userIndex;

    function isUser(address userAddress)
        public
        constant
        returns(bool isIndeed)
    {
        if(userIndex.length == 0) return false;
        return (userIndex[userStructs[userAddress].index] == userAddress);
    }

    function insertUser(
        address userAddress,
        bytes32 userName,
        uint    userAge,
        bytes32 userEmail)
        public
        returns(uint index)
    {
        if(isUser(userAddress)) throw;
        userStructs[userAddress].userEmail = userEmail;
        userStructs[userAddress].userAge   = userAge;
        userStructs[userAddress].userName  = userName;
        userStructs[userAddress].index     = userIndex.push(userAddress)-1;
        LogNewUser(
            userAddress,
            userStructs[userAddress].index,
            userName,
            userEmail,
            userAge);
        return userIndex.length-1;
    }

    function deleteUser(address userAddress)
    public
    returns(uint index)
    {
        if(!isUser(userAddress)) throw;
        uint rowToDelete = userStructs[userAddress].index;
        address keyToMove = userIndex[userIndex.length-1];
        userIndex[rowToDelete] = keyToMove;
        userStructs[keyToMove].index = rowToDelete;
        userIndex.length--;
        LogDeleteUser(
            userAddress,
            rowToDelete);
        return rowToDelete;
    }

    function getUser(address userAddress)
        public
        constant
        returns(bytes32 userName, bytes32 userEmail, uint userAge, uint index)
    {
        if(!isUser(userAddress)) throw;
        return(
        userStructs[userAddress].userName,
        userStructs[userAddress].userEmail,
        userStructs[userAddress].userAge,
        userStructs[userAddress].index);
    }

    function updateUserEmail(address userAddress, bytes32 userEmail)
        public
        returns(bool success)
    {
        if(!isUser(userAddress)) throw;
        userStructs[userAddress].userEmail = userEmail;
        LogUpdateUser(
        userAddress,
        userStructs[userAddress].index,
        userStructs[userAddress].userName,
        userEmail,
        userStructs[userAddress].userAge);
        return true;
    }

    function updateUserAge(address userAddress, uint userAge)
        public
        returns(bool success)
    {
        if(!isUser(userAddress)) throw;
        userStructs[userAddress].userAge = userAge;
        LogUpdateUser(
        userAddress,
        userStructs[userAddress].index,
        userStructs[userAddress].userName,
        userStructs[userAddress].userEmail,
        userAge);
        return true;
    }

    function getUserCount()
        public
        constant
        returns(uint count)
    {
        return userIndex.length;
    }

    function getUserAtIndex(uint index)
        public
        constant
        returns(address userAddress)
    {
        return userIndex[index];
    }

    function getAllUsers() public view returns(
        bytes32[] userNames,
        bytes32[] userEmails,
        uint[] userAges,
        uint[] userIndexes,
        address[] userAddress)
    {
        bytes32[] memory names = new bytes32[](userIndex.length);
        bytes32[] memory emails = new bytes32[](userIndex.length);
        uint[] memory ages = new uint[](userIndex.length);
        uint[] memory indexes = new uint[](userIndex.length);
        address[] memory resultAddress = new address[](userIndex.length);

        for (var index = 0; index < userIndex.length; index++) {
            var tempAddress = userIndex[index];
            resultAddress[index] = tempAddress;
            names[index] = userStructs[tempAddress].userName;
            emails[index] = userStructs[tempAddress].userEmail;
            ages[index] = userStructs[tempAddress].userAge;
            indexes[index] = userStructs[tempAddress].index;
        }

        return (names, emails, ages, indexes, resultAddress);
    }
}
