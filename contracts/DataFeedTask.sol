// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/*
 * 任务 1：
 * 通过 Chainlink Data Feed 获得 link，eth 和 btc 的 usd 价格
 * 参考视频教程：https://www.bilibili.com/video/BV1ed4y1N7Uv?p=3
*/

contract DataFeedTask {
    
    AggregatorV3Interface internal linkPriceFeed;
    AggregatorV3Interface internal btcPriceFeed;
    AggregatorV3Interface internal ethPriceFeed;
    
    /**
     * 步骤 1 - 在构造这里初始化 3 个 Aggregator
     * 查看 aggregator 的地址 https://docs.chain.link/docs/ethereum-addresses/#Goerli%20Testnet 
     * （使用 goerli 网络，Rinkeby 和 Kovan 已经 deprecated）
     *  */
    constructor() {
        linkPriceFeed = AggregatorV3Interface(0x48731cF7e84dc94C5f84577882c14Be11a5B7456);
        btcPriceFeed = AggregatorV3Interface(0xA39434A63A52E749F02807ae27335515BA4b07F7);
        ethPriceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    /**
     * 步骤 2 - 完成 getLinkPrice 函数 
     * 获得 link/usd 的价格数据
     */
    function getLinkPrice() public view returns (int256) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = linkPriceFeed.latestRoundData();
        return price;
    }

    /**
     * 步骤 3 - 完成 getBtcPrice 函数
     * 获得 btc/usd 的价格数据
     */    
    function getBtcPrice() public view returns (int256) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = btcPriceFeed.latestRoundData();
        return price;
    }

    /**
     * 步骤 4 - 完成 getEthPrice 函数
     * 获得 eth/usd 的价格数据
     */
    function getEthPrice() public view returns (int256) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = ethPriceFeed.latestRoundData();
        return price;
    }

    /**
     * 步骤 5 - 通过 Remix 将合约部署合约（使用 goerli 网络）
     * 
     * 任务成功标志：
     * 合约部署成功
     * 获取 link/usd, btc/usd, eth/usd 价格
     */
}
