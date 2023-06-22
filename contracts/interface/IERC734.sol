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

/**
 * @dev interface of the ERC734 (Key Holder) standard as defined in the EIP.
 */
interface IERC734 {
    /**
     * @dev Emitted when an execution request was approved.
     *
     * Specification: MUST be triggered when approve was successfully called.
     */
    event Approved(uint256 indexed executionId, bool approved);

    /**
     * @dev Emitted when an execute operation was approved and successfully performed.
     *
     * Specification: MUST be triggered when approve was called and the execution was successfully approved.
     */
    event Executed(uint256 indexed executionId, address indexed to, uint256 indexed value, bytes data);

    /**
     * @dev Emitted when an execution request was performed via `execute`.
     *
     * Specification: MUST be triggered when execute was successfully called.
     */
    event ExecutionRequested(uint256 indexed executionId, address indexed to, uint256 indexed value, bytes data);

    /**
     * @dev Emitted when an execute operation was called and failed
     *
     * Specification: MUST be triggered when execute call failed
     */
    event ExecutionFailed(uint256 indexed executionId, address indexed to, uint256 indexed value, bytes data);

    /**
     * @dev Emitted when a key was added to the Identity.
     *
     * Specification: MUST be triggered when addKey was successfully called.
     */
    event KeyAdded(bytes32 indexed key, uint256 indexed purpose, uint256 indexed keyType);

    /**
     * @dev Emitted when a key was removed from the Identity.
     *
     * Specification: MUST be triggered when removeKey was successfully called.
     */
    event KeyRemoved(bytes32 indexed key, uint256 indexed purpose, uint256 indexed keyType);

    /**
     * @dev Adds a _key to the identity. The _purpose specifies the purpose of the key.
     *
     * Triggers Event: `KeyAdded`
     *
     * Specification: MUST only be done by keys of purpose 1, or the identity
     * itself. If it's the identity itself, the approval process will determine its approval.
     */
    function addKey(
        bytes32 _key,
        uint256 _purpose,
        uint256 _keyType
    ) external returns (bool success);

    /**
     * @dev Approves an execution.
     *
     * Triggers Event: `Approved`
     * Triggers on execution successful Event: `Executed`
     * Triggers on execution failure Event: `ExecutionFailed`
     */
    function approve(uint256 _id, bool _approve) external returns (bool success);

    /**
     * @dev Removes _purpose for _key from the identity.
     *
     * Triggers Event: `KeyRemoved`
     *
     * Specification: MUST only be done by keys of purpose 1, or the identity itself.
     * If it's the identity itself, the approval process will determine its approval.
     */
    function removeKey(bytes32 _key, uint256 _purpose) external returns (bool success);

    /**
     * @dev Passes an execution instruction to an ERC734 identity.
     * How the execution is handled is up to the identity implementation:
     * An execution COULD be requested and require `approve` to be called with one or more keys of purpose 1 or 2 to
     * approve this execution.
     * Execute COULD be used as the only accessor for `addKey` and `removeKey`.
     *
     * Triggers Event: ExecutionRequested
     * Triggers on direct execution Event: Executed
     */
    function execute(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external payable returns (uint256 executionId);

    /**
     * @dev Returns the full key data, if present in the identity.
     */
    function getKey(bytes32 _key)
        external
        view
        returns (
            uint256[] memory purposes,
            uint256 keyType,
            bytes32 key
        );

    /**
     * @dev Returns the list of purposes associated with a key.
     */
    function getKeyPurposes(bytes32 _key) external view returns (uint256[] memory _purposes);

    /**
     * @dev Returns an array of public key bytes32 held by this identity.
     */
    function getKeysByPurpose(uint256 _purpose) external view returns (bytes32[] memory keys);

    /**
     * @dev Returns TRUE if a key is present and has the given purpose. If the key is not present it returns FALSE.
     */
    function keyHasPurpose(bytes32 _key, uint256 _purpose) external view returns (bool exists);
}
