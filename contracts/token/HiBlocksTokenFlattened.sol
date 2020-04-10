
// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Detailed.sol

pragma solidity ^0.5.0;


/**
 * @dev Optional functions from the ERC20 standard.
 */
contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

// File: @openzeppelin/contracts/GSN/Context.sol

pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they not should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, with should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.
     * @dev Get it via `npm install @openzeppelin/contracts@next`.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.

     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.
     * @dev Get it via `npm install @openzeppelin/contracts@next`.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.
     * @dev Get it via `npm install @openzeppelin/contracts@next`.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.5.0;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20Mintable}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(_msgSender(), spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `value`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

     /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _balances[account] = _balances[account].sub(value, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(value);
        emit Transfer(account, address(0), value);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
    }
}

// File: @openzeppelin/contracts/access/Roles.sol

pragma solidity ^0.5.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}

// File: @openzeppelin/contracts/access/roles/WhitelistAdminRole.sol

pragma solidity ^0.5.0;



/**
 * @title WhitelistAdminRole
 * @dev WhitelistAdmins are responsible for assigning and removing Whitelisted accounts.
 */
contract WhitelistAdminRole is Context {
    using Roles for Roles.Role;

    event WhitelistAdminAdded(address indexed account);
    event WhitelistAdminRemoved(address indexed account);

    Roles.Role private _whitelistAdmins;

    constructor () internal {
        _addWhitelistAdmin(_msgSender());
    }

    modifier onlyWhitelistAdmin() {
        require(isWhitelistAdmin(_msgSender()), "WhitelistAdminRole: caller does not have the WhitelistAdmin role");
        _;
    }

    function isWhitelistAdmin(address account) public view returns (bool) {
        return _whitelistAdmins.has(account);
    }

    function addWhitelistAdmin(address account) public onlyWhitelistAdmin {
        _addWhitelistAdmin(account);
    }

    function renounceWhitelistAdmin() public {
        _removeWhitelistAdmin(_msgSender());
    }

    function _addWhitelistAdmin(address account) internal {
        _whitelistAdmins.add(account);
        emit WhitelistAdminAdded(account);
    }

    function _removeWhitelistAdmin(address account) internal {
        _whitelistAdmins.remove(account);
        emit WhitelistAdminRemoved(account);
    }
}

// File: contracts/roles/AdminRole.sol

pragma solidity ^0.5.6;


contract AdminRole is WhitelistAdminRole {

  address[] private _adminList;

  function _addWhitelistAdmin(address account) internal {
    super._addWhitelistAdmin(account);
    _adminList.push(account);
  }

  function _removeWhitelistAdmin(address account) internal {
    require(_adminList.length > 1, "At lease 1 Admin");
    super._removeWhitelistAdmin(account);
    uint256 s = getIndexOfAdmin(account);
    _adminList[s] = _adminList[_adminList.length - 1];
    _adminList.pop();
  }

  function getIndexOfAdmin(address account) public view returns(uint256) {
    uint256 s = 0;
    for (s; s < _adminList.length; s += 1) {
      if (account == _adminList[s])
        return s;
    }
    return 0;
  }

  function getAdminList() public view onlyWhitelistAdmin returns(address[] memory) {
    return _adminList;
  }
}

// File: contracts/token/PausableToken.sol

pragma solidity ^0.5.6;



/**
 * @title Pausable token
 * @dev ERC20 with pausable transfers and allowances.
 *
 * Useful if you want to stop trades until the end of a crowdsale, or have
 * an emergency switch for freezing all token transfers in the event of a large
 * bug.
 */
contract PausableToken is ERC20, AdminRole {
  /**
  * @dev Emitted when the pause is triggered by a whitelistAdmin (`account`).
  */
  event Paused(address account);

  /**
  * @dev Emitted when the pause is lifted by a whitelistAdmin (`account`).
  */
  event Unpaused(address account);

  bool private _paused;

  /**
  * @dev Initializes the contract in unpaused state. Assigns the whitelistAdmin role
  * to the deployer.
  */
  constructor () internal {
    _paused = false;
  }

  /**
  * @dev Returns true if the contract is paused, and false otherwise.
  */
  function paused() public view returns (bool) {
    return _paused;
  }

  /**
  * @dev Modifier to make a function callable only when the contract is not paused.
  */
  modifier whenNotPaused() {
    require(!_paused, "Pausable: paused");
    _;
  }

  /**
  * @dev Modifier to make a function callable only when the contract is paused.
  */
  modifier whenPaused() {
    require(_paused, "Pausable: not paused");
    _;
  }

  /**
  * @dev Called by a whitelistAdmin to pause, triggers stopped state.
  */
  function pause() public onlyWhitelistAdmin whenNotPaused {
    _paused = true;
    emit Paused(_msgSender());
  }

  /**
  * @dev Called by a whitelistAdmin to unpause, returns to normal state.
  */
  function unpause() public onlyWhitelistAdmin whenPaused {
    _paused = false;
    emit Unpaused(_msgSender());
  }

  /**
  * @dev set modifier is paused to transfer function

  * @param to address
  * @param value uint256
  */
  function transfer(address to, uint256 value) public whenNotPaused returns (bool) {
    return super.transfer(to, value);
  }

  /**
  * @dev set modifier is paused to transferFrom function

  * @param from address
  * @param to address
  * @param value uint256
  */
  function transferFrom(address from, address to, uint256 value) public whenNotPaused returns (bool) {
    return super.transferFrom(from, to, value);
  }

  /**
  * @dev set modifier is paused to approve function

  * @param spender address
  * @param value uint256
  */
  function approve(address spender, uint256 value) public whenNotPaused returns (bool) {
    return super.approve(spender, value);
  }

  /**
  * @dev set modifier is paused to increaseAllowance function

  * @param spender address
  * @param addedValue uint256
  */
  function increaseAllowance(address spender, uint256 addedValue) public whenNotPaused returns (bool) {
    return super.increaseAllowance(spender, addedValue);
  }

  /**
  * @dev set modifier is paused to decreaseAllowance function

  * @param spender address
  * @param subtractedValue uint256
  */
  function decreaseAllowance(address spender, uint256 subtractedValue) public whenNotPaused returns (bool) {
    return super.decreaseAllowance(spender, subtractedValue);
  }
}

// File: contracts/erc/ERC1132.sol

pragma solidity ^0.5.6;

/**
* @title ERC1132 interface
* @dev see https://github.com/ethereum/EIPs/issues/1132
*/

contract ERC1132 {
  /**
  * @dev Reasons why a user's tokens have been locked
  */
  mapping(address => bytes32[]) public lockReason;

  /**
  * @dev locked token structure
  */
  struct LockToken {
    uint256 amount;
    uint256 validity;
    bool claimed;
  }

  /**
  * @dev Holds number & validity of tokens locked for a given reason for
  *      a specified address
  */
  mapping(address => mapping(bytes32 => LockToken)) public locked;

  /**
  * @dev Records data of all the tokens Locked
  */
  event Locked(
    address indexed _of,
    bytes32 indexed _reason,
    uint256 _amount,
    uint256 _validity
  );

  /**
  * @dev Records data of all the tokens unlocked
  */
  event Unlocked(
    address indexed _of,
    bytes32 indexed _reason,
    uint256 _amount
  );

  // /**
  //  * @dev Locks a specified amount of tokens against an address,
  //  *      for a specified reason and time
  //  * @param _reason The reason to lock tokens
  //  * @param _amount Number of tokens to be locked
  //  * @param _time Lock time in seconds
  //  */
  // function lock(bytes32 _reason, uint256 _amount, uint256 _time)
  //     internal returns (bool);

  /**
  * @dev Returns tokens locked for a specified address for a
  *      specified reason
  *
  * @param _of The address whose tokens are locked
  * @param _reason The reason to query the lock tokens for
  */
  function tokensLocked(address _of, bytes32 _reason)
    public view returns (uint256 amount);

  /**
  * @dev Returns tokens locked for a specified address for a
  *      specified reason at a specific time
  *
  * @param _of The address whose tokens are locked
  * @param _reason The reason to query the lock tokens for
  * @param _time The timestamp to query the lock tokens for
  */
  function tokensLockedAtTime(address _of, bytes32 _reason, uint256 _time)
    public view returns (uint256 amount);

  /**
  * @dev Returns tokens validity for a specified address for a specified reason
  *
  * @param _of The address whose tokens are locked
  * @param _reason The reason to query the lock tokens for
  */
  function tokensValidity(address _of, bytes32 _reason)
    public view returns (uint256 validity);

  /**
  * @dev Returns total tokens held by an address (locked + transferable)
  * @param _of The address to query the total balance of
  */
  function lockBalanceOf(address _of)
    public view returns (uint256 amount);

  /**
  * @dev Extends lock for a specified reason and time
  * @param _to adress to which tokens are to be extended lock
  * @param _reason The reason to lock tokens
  * @param _time Lock extension time in seconds
  */
  function extendLock(address _to, bytes32 _reason, uint256 _time)
    public returns (bool);

  /**
  * @dev Increase number of tokens locked for a specified reason
  * @param _to adress to which tokens are to be increased
  * @param _reason The reason to lock tokens
  * @param _amount Number of tokens to be increased
  */
  function increaseLockAmount(address _to, bytes32 _reason, uint256 _amount)
    public returns (bool);

  /**
  * @dev Returns unlockable tokens for a specified address for a specified reason
  * @param _of The address to query the the unlockable token count of
  * @param _reason The reason to query the unlockable tokens for
  */
  function tokensUnlockable(address _of, bytes32 _reason)
    public view returns (uint256 amount);

  /**
  * @dev Unlocks the unlockable tokens of a specified address
  * @param _of Address of user, claiming back unlockable tokens
  */
  function unlock(address _of)
    public returns (uint256 unlockableTokens);

  /**
  * @dev Gets the unlockable tokens of a specified address
  * @param _of The address to query the the unlockable token count of
  */
  function getUnlockableTokens(address _of)
    public view returns (uint256 unlockableTokens);

}

// File: contracts/token/LockableToken.sol

pragma solidity ^0.5.6;



contract LockableToken is PausableToken, ERC1132 {

  /**
  * @dev Error messages for require statements
  */
  string internal constant ALREADY_LOCKED = "Tokens already locked";
  string internal constant NOT_LOCKED = "No tokens locked";
  string internal constant AMOUNT_ZERO = "Amount can not be 0";

  /**
  * @dev is msg.sender or shitelistadmin
  * @param _address address
  */
  modifier isAdminOrSelf(address _address) {
    require(_address == msg.sender || isWhitelistAdmin(msg.sender), "tokens are unlockable by owner or admin");
    _;
  }

  /**
  * @dev Returns tokens locked for a specified address for a specified reason
  * @param _of The address whose tokens are locked
  * @param _reason The reason to query the lock tokens for
  */
  function tokensLocked(address _of, bytes32 _reason)
      public
      view
      returns (uint256 amount)
  {
    if (!locked[_of][_reason].claimed)
        amount = locked[_of][_reason].amount;
  }

  /**
  * @dev Returns tokens locked for a specified address for a
  *      specified reason at a specific time
  * @param _of The address whose tokens are locked
  * @param _reason The reason to query the lock tokens for
  * @param _time The timestamp to query the lock tokens for
  */
  function tokensLockedAtTime(address _of, bytes32 _reason, uint256 _time)
      public
      view
      returns (uint256 amount)
  {
    if (locked[_of][_reason].validity > _time)
        amount = locked[_of][_reason].amount;
  }

  /**
  * @dev Returns tokens validity for a specified address for a specified reason
  * @param _of The address whose tokens are locked
  * @param _reason The reason to query the lock tokens for
  */
  function tokensValidity(address _of, bytes32 _reason)
      public
      view
      returns (uint256 validity)
  {
    validity = locked[_of][_reason].validity;
  }

  /**
  * @dev Returns total tokens held by an address (locked + transferable)
  * @param _of The address to query the total balance of
  */
  function lockBalanceOf(address _of)
      public
      view
      returns (uint256 amount)
  {
    amount = 0;
    uint256 i = 0;
    for ( i ; i < lockReason[_of].length; i++) {
      amount = amount.add(tokensLocked(_of, lockReason[_of][i]));
    }
  }

  /**
  * @dev Returns unlockable tokens for a specified address for a specified reason
  * @param _of The address to query the the unlockable token count of
  * @param _reason The reason to query the unlockable tokens for
  */
  function tokensUnlockable(address _of, bytes32 _reason)
      public
      view
      returns (uint256 amount)
  {
      if (locked[_of][_reason].validity <= now && !locked[_of][_reason].claimed) //solium-disable-line
          amount = locked[_of][_reason].amount;
  }

  /**
  * @dev Unlocks the unlockable tokens of a specified address
  * @param _of Address of user, claiming back unlockable tokens
  */
  function unlock(address _of)
      public
      isAdminOrSelf(_of)
      returns (uint256 unlockableTokens)
  {
    uint256 lockedTokens;
    uint256 i = 0;
    for ( i ; i < lockReason[_of].length; i++) {
      lockedTokens = tokensUnlockable(_of, lockReason[_of][i]);
      if (lockedTokens > 0) {
        unlockableTokens = unlockableTokens.add(lockedTokens);
        locked[_of][lockReason[_of][i]].claimed = true;
        emit Unlocked(_of, lockReason[_of][i], lockedTokens);
      }
    }

    if (unlockableTokens > 0) {
      _transfer(address(this), _of, unlockableTokens);
    }
  }

  /**
  * @dev Gets the unlockable tokens of a specified address
  * @param _of The address to query the the unlockable token count of
  */
  function getUnlockableTokens(address _of)
      public
      view
      returns (uint256 unlockableTokens)
  {
    uint256 i = 0;
    for ( i ; i < lockReason[_of].length; i++) {
      unlockableTokens = unlockableTokens.add(tokensUnlockable(_of, lockReason[_of][i]));
    }
  }

  /**
  * @dev Transfers and Locks a specified amount of tokens,
  *      for a specified reason and time
  * @param _to adress to which tokens are to be transfered
  * @param _reason The reason to lock tokens
  * @param _amount Number of tokens to be transfered and locked
  * @param _time Lock time in seconds
  */
  function transferWithLock(address _to, bytes32 _reason, uint256 _amount, uint256 _time) public onlyWhitelistAdmin returns (bool) {
    require(_to != address(0), "Zero address not allowed");
    require(_amount != 0, AMOUNT_ZERO);
    require(tokensLocked(_to, _reason) == 0, ALREADY_LOCKED);
    require(balanceOf(msg.sender) > _amount);

    uint256 validUntil = now.add(_time); //solium-disable-line

    // not allowed duplicate reason for address
    if (locked[_to][_reason].amount == 0)
      lockReason[_to].push(_reason);

    _transfer(msg.sender, address(this), _amount);

    locked[_to][_reason] = LockToken(_amount, validUntil, false);

    emit Locked(_to, _reason, _amount, validUntil);
    return true;
  }

  /**
  * @dev Extends lock for a specified reason and time
  * @param _to adress to which tokens are to be extended lock
  * @param _reason The reason to lock tokens
  * @param _time Lock extension time in seconds
  */
  function extendLock(address _to, bytes32 _reason, uint256 _time) public onlyWhitelistAdmin returns (bool) {
    require(_to != address(0), "Zero address not allowed");
    require(tokensLocked(_to, _reason) > 0, NOT_LOCKED);

    locked[_to][_reason].validity = locked[_to][_reason].validity.add(_time);

    emit Locked(_to, _reason, locked[_to][_reason].amount, locked[_to][_reason].validity);
    return true;
  }

  /**
  * @dev Increase number of tokens locked for a specified reason
  * @param _to adress to which tokens are to be increased
  * @param _reason The reason to lock tokens
  * @param _amount Number of tokens to be increased
  */
  function increaseLockAmount(address _to, bytes32 _reason, uint256 _amount) public onlyWhitelistAdmin returns (bool) {
    require(_to != address(0), "Zero address not allowed");
    require(tokensLocked(_to, _reason) > 0, NOT_LOCKED);

    _transfer(msg.sender, address(this), _amount);

    locked[_to][_reason].amount = locked[_to][_reason].amount.add(_amount);

    emit Locked(_to, _reason, locked[_to][_reason].amount, locked[_to][_reason].validity);
    return true;
  }

  /**
  * @dev get length of lockReason array
  * @param _of address
  */
  function getSizeOfLockReason(address _of) public view returns (uint256) {
    return lockReason[_of].length;
  }
}

// File: contracts/token/StakingToken.sol

pragma solidity ^0.5.6;

/**
 * @title Staking Token (STK)
 * @author Alberto Cuesta Canada
 * @dev Implements a basic ERC20 staking token with incentive distribution.
 */
contract StakingToken is LockableToken {
  /**
  * @dev Emitted when user staked token.
  */
  event Staked(address account, uint256 amount);

  /**
  * @dev Emitted when user unstaked token.
  */
  event Unstaked(address account, uint256 amount);

  /**
  * @dev Emitted when user unstaked token.
  */
  event validStakePeriod(uint256 _startTime, uint256 _duration, bool stakeFlag);

  /**
  * @dev We usually require to know who are all the stakeholders.
  */
  address[] internal stakeholders;

  /**
  * @dev The stakes for each stakeholder.
  */
  mapping(address => uint256) internal stakes;

  uint256 private secondsInterval;
  uint256 private validStakeDuration;
  uint256 private validStakeStartTime;
  bool private stakeFlag;

  /**
  * @dev Initializes the contract in stake state.
  * to the deployer.
  */
  constructor () internal {
    secondsInterval = 60*60*24*7; // default : interval 7 days
    validStakeDuration = 32400;  // default : 60*60*9 ( 9hours )
    validStakeStartTime = now - validStakeDuration;  //solium-disable-line
    stakeFlag = false;
  }

  // ---------- SET TIME ----------
  modifier isvalidStakePeriod() {
    require(stakeFlag, "stake is disabled");
    require(isAbleToStake(), "It's not valid time to stake"); //solium-disable-line
    _;
  }

  /**
  * @dev Set period of able to stake. (It is automatically set to the same day each week.)
  * @param _startTime uint256 available start time to set stake/unstake
  * @param _duration uint256 duration second to set stake/unstake
  */
  function setvalidStakePeriod(uint256 _startTime, uint256 _duration) public onlyWhitelistAdmin returns (uint256, uint256){
    validStakeStartTime = _startTime;
    validStakeDuration = _duration;
    stakeFlag = true;

    emit validStakePeriod(_startTime, _duration, stakeFlag);

    return stakePeriod();
  }

  /**
  * @dev change the stakeFlag state.
  * @param _stakeFlag bool stakeFlag state
  */
  function setStakeFlag(bool _stakeFlag) public onlyWhitelistAdmin returns (bool) {
    stakeFlag = _stakeFlag;
    return stakeFlag;
  }

  /**
  * @dev A method for check is able to stake
  */
  function isAbleToStake() public view returns (bool){
    if(!stakeFlag || now < validStakeStartTime) { //solium-disable-line
      return false;
    }
    uint256 validTime = now.sub(validStakeStartTime).mod(secondsInterval); //solium-disable-line
    return (validTime >= 0 && validTime < validStakeDuration);
  }

  /**
  * @dev A method for check period for stake
  */
  function stakePeriod() public view returns (uint256 validStakePeriodStart, uint256 validStakePeriodEnd){
    if(now < validStakeStartTime) { //solium-disable-line
      validStakePeriodStart = validStakeStartTime;
      validStakePeriodEnd = validStakePeriodStart.add(validStakeDuration);
    }else{
      uint256 week = now.sub(validStakeStartTime).div(secondsInterval); //solium-disable-line

      if(isAbleToStake()){
        validStakePeriodStart = validStakeStartTime.add(secondsInterval.mul(week));
      }else{
        validStakePeriodStart = validStakeStartTime.add(secondsInterval.mul(week.add(1)));
      }
      validStakePeriodEnd = validStakePeriodStart.add(validStakeDuration);
    }
  }
  // ---------- STAKES ----------
  /**
  * @dev A method for a stakeholder to create a stake.
  * @param _stake The size of the stake to be created.
  */
  function createStake(uint256 _stake) external isvalidStakePeriod {
    require(transfer(address(this), _stake), "Token transfer failed");
    if(stakes[msg.sender] == 0) _addStakeholder(msg.sender);
    stakes[msg.sender] = stakes[msg.sender].add(_stake);

    emit Staked(msg.sender,_stake);
  }

  /**
  * @dev A method for a stakeholder to remove a stake.
  * @param _stake The size of the stake to be removed.
  */
  function removeStake(uint256 _stake) external isvalidStakePeriod {
    require(_stake <= stakes[msg.sender], "insufficient stake balance");
    stakes[msg.sender] = stakes[msg.sender].sub(_stake);
    if(stakes[msg.sender] == 0) _removeStakeholder(msg.sender);

    _transfer(address(this), msg.sender, _stake);
    emit Unstaked(msg.sender,_stake);
  }

  /**
  * @dev A method to retrieve the stake for a stakeholder.
  * @param _stakeholder The stakeholder to retrieve the stake for.
  * @return uint256 The amount of wei staked.
  */
  function stakeOf(address _stakeholder) public view returns(uint256) {
    return stakes[_stakeholder];
  }

  /**
  * @dev A method to the aggregated stakes from all stakeholders.
  * @return uint256 The aggregated stakes from all stakeholders.
  */
  function totalStakes() public view returns(uint256) {
    uint256 _totalStakes = 0;
    uint256 s = 0;
    for ( s ; s < stakeholders.length; s += 1){
      _totalStakes = _totalStakes.add(stakes[stakeholders[s]]);
    }
    return _totalStakes;
  }

  // ---------- STAKEHOLDERS ----------
  /**
  * @dev A method to check if an address is a stakeholder.
  * @param _address The address to verify.
  * @return bool, uint256 Whether the address is a stakeholder,
  * and if so its position in the stakeholders array.
  */
  function isStakeholder(address _address) public view returns(bool, uint256) {
    uint256 s = 0;
    for ( s ; s < stakeholders.length; s += 1){
      if (_address == stakeholders[s]) return (true, s);
    }
    return (false, 0);
  }

  /**
  * @dev A method to add a stakeholder.
  * @param _stakeholder The stakeholder to add.
  */
  function _addStakeholder(address _stakeholder) internal {
    (bool _isStakeholder, ) = isStakeholder(_stakeholder);
    if(!_isStakeholder) stakeholders.push(_stakeholder);
  }

  /**
  * @dev A method to remove a stakeholder.
  * @param _stakeholder The stakeholder to remove.
  */
  function _removeStakeholder(address _stakeholder) internal {
    (bool _isStakeholder, uint256 s) = isStakeholder(_stakeholder);
    if(_isStakeholder){
      stakeholders[s] = stakeholders[stakeholders.length - 1];
      stakeholders.pop();
    }
  }

  /**
  * @dev A method to get stake holders
  */
  function stakeholderList() external view returns (address[] memory) {
    return stakeholders;
  }
}

// File: contracts/HiblocksToken.sol

pragma solidity ^0.5.6;



contract HiblocksToken is ERC20Detailed, StakingToken {

  mapping(address => mapping(uint => bytes)) public memos;

  /**
  * @dev constructor to mint initial tokens
  * @param name string
  * @param symbol string
  * @param decimals uint8
  * @param initialSupply uint256
  */
  constructor(string memory name, string memory symbol, uint8 decimals, uint256 initialSupply)
    public
    ERC20Detailed(name, symbol, decimals)
  {
    // Mint the initial supply
    require(initialSupply > 0, "initialSupply must be greater than zero.");
    _mint(_msgSender(), initialSupply * (10 ** uint256(decimals)));
  }

  /**
  * @dev Transfer token for a specified address with memo
  * @param to The address to transfer to.
  * @param value The amount to be transferred.
  * @param memo The memo to be saved.
  */
  function transferWithMemo(address to, uint256 value, bytes memory memo) public returns (bool) {
    require(transfer(to, value), "Token transfer failed");
    memos[to][block.number] = memo;
    return true;
  }

  /**
  * @dev Gets the memo of the specified address and block number.
  * @param addr The address to query the memo of.
  * @param blockNumber The block number to query the memo of.
  * @return An bytes representing the memo writed by the passed address.
  */
  function memoOf(address addr, uint blockNumber) external view returns (bytes memory) {
    return(memos[addr][blockNumber]);
  }

  /**
  * @dev Destroys `amount` tokens from the caller.
  *
  * See {ERC20-_burn}.
  */
  function burn(uint256 amount) public onlyWhitelistAdmin {
    super._burn(_msgSender(), amount);
  }

  /**
  * @dev Destroys `amount` tokens from the address.
  *
  * See {ERC20-_burnFrom}.
  */
  function burnFrom(address addr, uint256 amount) public onlyWhitelistAdmin {
    super._burnFrom(addr, amount);
  }

  /**
  * @dev Returns total tokens held by an address (transferable + locked)
  * @param _addr The address to query the total balance of
  */
  function totalBalanceOf(address _addr) external view returns (uint256 amount, uint256 token, uint256 locked, uint256 staked) {
    token = balanceOf(_addr);
    locked = lockBalanceOf(_addr);
    staked = stakeOf(_addr);
    amount = token.add(locked).add(staked);
  }
}
