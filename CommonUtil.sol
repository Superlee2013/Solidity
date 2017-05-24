library CommonUtil {

    // 合并两个bytes
    function combineBytes(bytes _a, bytes _b, bytes1 separator)  returns (bytes _result){
        uint _len1 = _a.length;
        uint _len2 = _b.length;
        _result = new bytes(_len1 + _len2 + 1);
        for (uint i = 0; i < _len1; ++i) {
            _result[i] = _a[i];
        }
        _result[_len1] = separator;
        for (i = 1; i <= _len2; ++i) {
            _result[_len1 + i] = _b[i - 1];
        }
    }

    // 合并两个数组
    function combineBytes32Arr(bytes32[] _arr1,bytes32[] _arr2) internal returns (bytes32[]){
        uint len1 = _arr1.length;
        uint len2 = _arr2.length;
        bytes32[] memory result = new bytes32[](len1+len2);
        for(uint i = 0;i<len1;++i){
            result[i] = _arr1[i];
        }
        for(i = 0;i<len2;++i){
            result[len1+i] = _arr2[i];
        }
        return result;
    }

    // 从bytes32数组移除相应bytes32元素
    function removeTargetFromBytes32Array(bytes32[] storage origin, bytes32 target) internal {
        uint len = origin.length;
        for (uint i = 0; i < len; i++) {
            if (origin[i] == target) {
                origin[i] = origin[len - 1];
                origin.length = len - 1;
                break;
            }
        }
    }

    // 将bytes32元素加入到bytes32数组中，判断是否有重复
    function addTargetToBytes32Array(bytes32[] storage origin, bytes32 target) internal {
        uint len = origin.length;
        for (uint i = 0; i < len; i++) {
            if (origin[i] == target) {
                return;
            }
        }
        origin.push(target);
    }


    // uint转bytes32
    function uintToBytes(uint v) constant returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        }
        else {
            while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }

    // bytes转uint
    function bytesToUInt(bytes32 v) constant returns (uint ret) {
        if (v == 0x0) {
            throw;
        }

        uint digit;

        for (uint i = 0; i < 32; i++) {
            digit = uint((uint(v) / (2 ** (8 * (31 - i)))) & 0xff);
            if (digit == 0) {
                break;
            }
            else if (digit < 48 || digit > 57) {
                throw;
            }
            ret *= 10;
            ret += (digit - 48);
        }
        return ret;
    }
}