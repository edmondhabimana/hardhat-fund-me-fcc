//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        //ABI
        //this is the address of the contract we want to work with ETH/USD
        //Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        (, int256 price, , , ) = priceFeed.latestRoundData();
        //return ETH in terms of USD
        //3000.00000000
        return uint256(price * 1e10); // 1**10 = 10000000000
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        //3000_000000000000000000 = ETH / USD price
        //1_000000000000000000 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
