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
 * @dev Version contract gives the versioning information of the implementation contract
 */
contract Version {
    /**
     * @dev Returns the string of the current version.
     */
    function version() external pure returns (string memory) {
        // version 2.0.0
        return "2.0.0";
    }
}
