pragma solidity ^0.4.15;

import "./AuctionInterface.sol";

/** @title BadAuction */
contract BadAuction is AuctionInterface {
	/* Bid function, vulnerable to attack
	 * Must return true on successful send and/or bid,
	 * bidder reassignment
	 * Must return false on failure and send people
	 * their funds back
	 */
	function bid() payable external returns (bool) {
		// YOUR CODE HERE
		if (msg.value <= highestBid) {
			msg.sender.transfer(msg.value);
			return false;
		}

		if (highestBidder != 0) {
			if (!highestBidder.send(highestBid)) {
				msg.sender.transfer(msg.value);
				return false;
			}
		}

		highestBid = msg.value;
		highestBidder = msg.sender;
		return true;

	}

	/* Give people their funds back */
	function () payable {
		// YOUR CODE HERE
		msg.sender.transfer(msg.value);
	}
}
