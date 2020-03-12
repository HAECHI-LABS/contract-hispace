# <span id="HiblocksIERC20"></span> HiblocksIERC20
> 




### 🔎 Details

Interface of the ERC20 standard as defined in the EIP. Does not include the optional functions; to access them see {ERC20Detailed}.

## Contents


- [Functions](#HiblocksIERC20--Functions)


  - [totalSupply()](#HiblocksIERC20--function--totalSupply())


  - [balanceOf(address)](#HiblocksIERC20--function--balanceOf(address))


  - [transfer(address,uint256)](#HiblocksIERC20--function--transfer(address,uint256))


  - [allowance(address,address)](#HiblocksIERC20--function--allowance(address,address))


  - [approve(address,uint256)](#HiblocksIERC20--function--approve(address,uint256))


  - [transferFrom(address,address,uint256)](#HiblocksIERC20--function--transferFrom(address,address,uint256))


  - [totalBalanceOf(address)](#HiblocksIERC20--function--totalBalanceOf(address))


  - [transferWithMemo(address,uint256,bytes)](#HiblocksIERC20--function--transferWithMemo(address,uint256,bytes))


  - [isWhitelistAdmin(address)](#HiblocksIERC20--function--isWhitelistAdmin(address))



## 🚀Functions <a name="HiblocksIERC20--Functions"></a>
<dl>
<dt> <h3> totalSupply() <a name="HiblocksIERC20--function--totalSupply()"></a> </h3> </dt>
<dd>

🔨`Returns the amount of tokens in existence.` |  👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `uint256` |



</dd>
<dt> <h3> balanceOf(address) <a name="HiblocksIERC20--function--balanceOf(address)"></a> </h3> </dt>
<dd>

🔨`Returns the amount of tokens owned by `account`.` |  👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `uint256` |



</dd>
<dt> <h3> transfer(address,uint256) <a name="HiblocksIERC20--function--transfer(address,uint256)"></a> </h3> </dt>
<dd>

🔨`Moves `amount` tokens from the caller&#39;s account to `recipient`.     * Returns a boolean value indicating whether the operation succeeded.     * Emits a {Transfer} event.` |  👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> allowance(address,address) <a name="HiblocksIERC20--function--allowance(address,address)"></a> </h3> </dt>
<dd>

🔨`Returns the remaining number of tokens that `spender` will be allowed to spend on behalf of `owner` through {transferFrom}. This is zero by default.     * This value changes when {approve} or {transferFrom} are called.` |  👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `uint256` |



</dd>
<dt> <h3> approve(address,uint256) <a name="HiblocksIERC20--function--approve(address,uint256)"></a> </h3> </dt>
<dd>

🔨`Sets `amount` as the allowance of `spender` over the caller&#39;s tokens.     * Returns a boolean value indicating whether the operation succeeded.     * IMPORTANT: Beware that changing an allowance with this method brings the risk that someone may use both the old and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this race condition is to first reduce the spender&#39;s allowance to 0 and set the desired value afterwards: https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729     * Emits an {Approval} event.` |  👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> transferFrom(address,address,uint256) <a name="HiblocksIERC20--function--transferFrom(address,address,uint256)"></a> </h3> </dt>
<dd>

🔨`Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism. `amount` is then deducted from the caller&#39;s allowance.     * Returns a boolean value indicating whether the operation succeeded.     * Emits a {Transfer} event.` |  👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> totalBalanceOf(address) <a name="HiblocksIERC20--function--totalBalanceOf(address)"></a> </h3> </dt>
<dd>

🔨`Returns total tokens held by an address (transferable + locked + staked)` |  👀 `view`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _addr | `address` | The address to query the total balance of |


#### → Returns

| Name | Type |
|:-:|:-:|
|  amount  | `uint256` |
|  token  | `uint256` |
|  locked  | `uint256` |
|  staked  | `uint256` |



</dd>
<dt> <h3> transferWithMemo(address,uint256,bytes) <a name="HiblocksIERC20--function--transferWithMemo(address,uint256,bytes)"></a> </h3> </dt>
<dd>

🔨`Transfer token for a specified address with memo` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| to | `address` | The address to transfer to. |
| value | `uint256` | The amount to be transferred. |
| memo | `bytes` | The memo to be saved. |


#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> isWhitelistAdmin(address) <a name="HiblocksIERC20--function--isWhitelistAdmin(address)"></a> </h3> </dt>
<dd>

🔨`Check for administrator privileges.` |  👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
</dl>
