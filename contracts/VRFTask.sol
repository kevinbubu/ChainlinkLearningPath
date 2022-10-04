// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

/*
 * 任务 2：
 * 通过 requestRandomWords 函数，从 Chainlink VRF 获得随机数
 * 通过 fulfillRandomWords 函数给 s_randomness[] 填入 5 个随机数
 * 保证 5 个随机数为 1000 以内，不重复
 * 参考视频教程： https://www.bilibili.com/video/BV1ed4y1N7Uv
*/

contract VRFTask is VRFConsumerBaseV2 {

    VRFCoordinatorV2Interface COORDINATOR;
    /* 
     * 步骤 1 - 获得 VRFCoordinator 合约的地址和所对应的 keyHash
     * 相关参数请查看 https://docs.chain.link/docs/vrf/v2/supported-networks/
     * 修改 vrfCoordinatorAddr 和 keyHash 两个变量
     */ 
    address vrfCoordinatorAddr = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D; // Goerli
    bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15; // Goerli
    address owner;

    /**
     * 步骤 2 - 初始化 requestRandomWords 中所需的参数
     * requestConformations， callbackGasLimit， numWords
     * 分别查看这 3 个参数的定义并且定义他们
     *  */
    uint64 s_subId = 2945; // Goerli
    uint16 requestConformations = 3; // The default is 3, but you can set this higher.
    uint32 callbackGasLimit = 1000000;
    uint32 numWords = 5;

    uint256 requestId;
    uint256[] public s_randomWords;

    /**  
     * 步骤 3 - 在构造函数中，初始化相关变量
     * 初始化接口 VRFCoordinatorV2Interface
     * 初始化 s_subId 和 owner 
     * */
    constructor() VRFConsumerBaseV2(vrfCoordinatorAddr) {
        owner = msg.sender;
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinatorAddr);
    }

    /** 
     * 步骤 4 - 发送随机数请求
     * */ 
    function requestRandomWords() external {
        require(msg.sender == owner);
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subId,
            requestConformations,
            callbackGasLimit,
            numWords
        );
    }

    /**
     * 步骤 5 - 接受随机数，完成逻辑获取 5 个 1000 以内不同的随机数
     * 参考 https://ethereum.stackexchange.com/questions/132960/how-to-guarantee-unique-number-combinations-based-on-chainlink-vrfv2
     *  */ 
    function fulfillRandomWords(uint256, uint256[] memory randomWords) internal override {
        s_randomWords = randomWords;
        for(uint256 i = 0; i < s_randomWords.length;i++){
            s_randomWords[i] = (s_randomWords[i] % 999) + 1;
        }
    }

    /**
     * 步骤 6 - 通过 Chainlink VRF 页面注册 VRF subscription（使用 goerli 网络）
     * 
     * 步骤 7 - 使用刚才的 subscription ID 在 Remix 中部署合约（使用 goerli 网络）
     * 
     * 步骤 8 - 通过合约的请求随机数
     * 
     * 任务成功标志：
     * 检测是否收到 s_randomWords 中是否有 5 个 1000 以内的随机数
     * */
    
}
