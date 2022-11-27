// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Chat {
    uint256 private _postNonce;

    constructor() {
        _postNonce = 0;
    }

    struct Post {
        address owner;
        uint id;
        string text;
        string img;
        uint256 timestamp;
    }

    struct User {
        string name;
        string profileImg;
    }

    mapping(uint256 => Post) posts;
    mapping(uint256 => User) users;

    bytes32[] storage recentPostIds = new bytes32[100];

    event post(
        address owner,
        uint256 id,
        string text,
        uint256 timestamp
    );

    function newPost(string memory text, string memory img) public {
        Post storage post = posts[id];
        post.owner = msg.sender;
        post.id = generateId(msg.data);
        post.text = text;
        post.img = img;
        post.timestamp = block.timestamp;

        insertNewPostId(post.id);

        emit post(
            post.owner,
            post.id,
            post.text,
            post.timestamp
        );
    }

    function getRecentPosts() public view returns (Post[] memory) {
        Post[] memory recentPosts = new Post[recentPostIds.length];

        for (uint i = 0; i < recentPostIds.length - 1; i++) {
            recentPosts[i] = posts[recentPostIds[i]];
        }

        return recentPosts;
    }

    function insertNewPostId(bytes32 id) private {
        bytes32 set = id;
        bytes32 swap = recentPostIds[0];

        for (uint i = 0; i < recentPostIds.length - 1; i++) {
            recentPostIds[i] = set;
            set = swap;
            swap = recentPostIds[i + 1];
        }
    }

    function generateId(bytes32 data) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(block.number, data, _postNonce++));
    }
}
