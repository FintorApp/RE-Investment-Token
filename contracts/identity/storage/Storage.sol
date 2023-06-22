// SPDX-License-Identifier: GPL-3.0
//
/**
 *     NOTICE
 *
 *     The software for Fintor Protocol is licensed under GPL v.3.
 *     If you choose to receive it under the GPL v.3 license, the following applies:
 *
 *     Fintor Protocol comprises of smart contracts designed to enable issuance,
 *     management, and transfer of permissioned tokens for Real Estate related assets
 *     on blockchain networks that are compatible with Ethereum Virtual Machine.
 *     It uses an implementation of ERC-3643 proposed by Tokeny.
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
pragma solidity 0.8.17;
import "./Structs.sol";

contract Storage is Structs {
    // nonce used by the execute/approve function
    uint256 internal _executionNonce;

    // keys as defined by IERC734
    mapping(bytes32 => Key) internal _keys;

    // keys for a given purpose
    // purpose 1 = MANAGEMENT
    // purpose 2 = ACTION
    // purpose 3 = CLAIM
    mapping(uint256 => bytes32[]) internal _keysByPurpose;

    // execution data
    mapping(uint256 => Execution) internal _executions;

    // claims held by the IdentityID
    mapping(bytes32 => Claim) internal _claims;

    // array of claims for a given topic
    mapping(uint256 => bytes32[]) internal _claimsByTopic;

    // status on initialization
    bool internal _initialized = false;

    // status on potential interactions with the contract
    bool internal _canInteract = false;

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     */
    uint256[49] private __gap;
}
