# <span id="SaveBox"></span> SaveBox
> 





## Contents


- [Events](#SaveBox--Events)


  - [BoxCreated](#SaveBox--event--BoxCreated)


  - [BoxDestroyed](#SaveBox--event--BoxDestroyed)


  - [Stake](#SaveBox--event--Stake)


  - [Unstake](#SaveBox--event--Unstake)



- [Functions](#SaveBox--Functions)


  - [createBox()](#SaveBox--function--createBox())


  - [stakeTo(bytes32,uint256)](#SaveBox--function--stakeTo(bytes32,uint256))


  - [unstakeFrom(bytes32)](#SaveBox--function--unstakeFrom(bytes32))


  - [destroyBox(bytes32)](#SaveBox--function--destroyBox(bytes32))


  - [stake(uint256)](#SaveBox--function--stake(uint256))


  - [unstake()](#SaveBox--function--unstake())


  - [boxId(address,uint256)](#SaveBox--function--boxId(address,uint256))


  - [stakeAmount(bytes32,address)](#SaveBox--function--stakeAmount(bytes32,address))


  - [boxInfo(bytes32)](#SaveBox--function--boxInfo(bytes32))



## 🦄Events <a name="SaveBox--Events"></a>


<details><summary><strong>BoxCreated <a name="SaveBox--event--BoxCreated"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |
| creator | `false` | `address` |

</p>

</details>


<details><summary><strong>BoxDestroyed <a name="SaveBox--event--BoxDestroyed"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |

</p>

</details>


<details><summary><strong>Stake <a name="SaveBox--event--Stake"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |
| staker | `false` | `address` |
| amount | `false` | `uint256` |

</p>

</details>


<details><summary><strong>Unstake <a name="SaveBox--event--Unstake"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |
| staker | `false` | `address` |
| amount | `false` | `uint256` |

</p>

</details>



## 🚀Functions <a name="SaveBox--Functions"></a>
<dl>
<dt> <h3> createBox() <a name="SaveBox--function--createBox()"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  _boxId  | `bytes32` |



</dd>
<dt> <h3> stakeTo(bytes32,uint256) <a name="SaveBox--function--stakeTo(bytes32,uint256)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> unstakeFrom(bytes32) <a name="SaveBox--function--unstakeFrom(bytes32)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> destroyBox(bytes32) <a name="SaveBox--function--destroyBox(bytes32)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> stake(uint256) <a name="SaveBox--function--stake(uint256)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> unstake() <a name="SaveBox--function--unstake()"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> boxId(address,uint256) <a name="SaveBox--function--boxId(address,uint256)"></a> </h3> </dt>
<dd>

 👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bytes32` |



</dd>
<dt> <h3> stakeAmount(bytes32,address) <a name="SaveBox--function--stakeAmount(bytes32,address)"></a> </h3> </dt>
<dd>

 👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `uint256` |



</dd>
<dt> <h3> boxInfo(bytes32) <a name="SaveBox--function--boxInfo(bytes32)"></a> </h3> </dt>
<dd>

 👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  creator  | `address` |
|  createdAt  | `uint256` |
|  balance  | `uint256` |
|  destroyed  | `bool` |



</dd>
</dl>
