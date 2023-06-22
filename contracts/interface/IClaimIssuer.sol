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

import "./IIdentity.sol";

interface IClaimIssuer is IIdentity {
    /**
     * @dev Emitted when a claim is revoked.
     *
     * Specification: MUST be triggered when revoking a claim.
     */
    event ClaimRevoked(bytes indexed signature);

    /**
     * @dev Revoke a claim previously issued, the claim is no longer considered as valid after revocation.
     * @notice will fetch the claim from the identity contract (unsafe).
     * @param _claimId the id of the claim
     * @param _identity the address of the identity contract
     * @return isRevoked true when the claim is revoked
     */
    function revokeClaim(bytes32 _claimId, address _identity) external returns (bool);

    /**
     * @dev Revoke a claim previously issued, the claim is no longer considered as valid after revocation.
     * @param signature the signature of the claim
     */
    function revokeClaimBySignature(bytes calldata signature) external;

    /**
     * @dev Returns revocation status of a claim.
     * @param _sig the signature of the claim
     * @return isRevoked true if the claim is revoked and false otherwise
     */
    function isClaimRevoked(bytes calldata _sig) external view returns (bool);

    /**
     * @dev Checks if a claim is valid.
     * @param _identity the identity contract related to the claim
     * @param claimTopic the claim topic of the claim
     * @param sig the signature of the claim
     * @param data the data field of the claim
     * @return claimValid true if the claim is valid, false otherwise
     */
    function isClaimValid(
        IIdentity _identity,
        uint256 claimTopic,
        bytes calldata sig,
        bytes calldata data
    ) external view returns (bool);

    /**
     * @dev returns the address that signed the given data
     * @param sig the signature of the data
     * @param dataHash the data that was signed
     * returns the address that signed dataHash and created the signature sig
     */
    function getRecoveredAddress(bytes calldata sig, bytes32 dataHash) external pure returns (address);
}
