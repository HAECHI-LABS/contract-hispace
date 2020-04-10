# <span id="ISaveBox"></span> ISaveBox
> 👤 taek lee &lt;taeklee@haechi.io>

```
SaveBox Contract for staking
```



### 📋 Notice

Staking by individual and by Box is available on this Contract


### 🔎 Details

bytes32(0) is boxId of individual stake

## Contents


- [Events](#ISaveBox--Events)


  - [BoxCreated](#ISaveBox--event--BoxCreated)


  - [BoxDestroyed](#ISaveBox--event--BoxDestroyed)


  - [Stake](#ISaveBox--event--Stake)


  - [Unstake](#ISaveBox--event--Unstake)



- [Functions](#ISaveBox--Functions)


  - [createBox()](#ISaveBox--function--createBox())


  - [stakeTo(bytes32,uint256)](#ISaveBox--function--stakeTo(bytes32,uint256))


  - [unstakeFrom(bytes32)](#ISaveBox--function--unstakeFrom(bytes32))


  - [destroyBox(bytes32)](#ISaveBox--function--destroyBox(bytes32))


  - [stake(uint256)](#ISaveBox--function--stake(uint256))


  - [unstake()](#ISaveBox--function--unstake())


  - [boxId(address,uint256)](#ISaveBox--function--boxId(address,uint256))


  - [stakeAmount(bytes32,address)](#ISaveBox--function--stakeAmount(bytes32,address))


  - [boxInfo(bytes32)](#ISaveBox--function--boxInfo(bytes32))



## 🦄Events <a name="ISaveBox--Events"></a>


<details><summary><strong>BoxCreated <a name="ISaveBox--event--BoxCreated"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |
| creator | `false` | `address` |

</p>

</details>


<details><summary><strong>BoxDestroyed <a name="ISaveBox--event--BoxDestroyed"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |

</p>

</details>


<details><summary><strong>Stake <a name="ISaveBox--event--Stake"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |
| staker | `false` | `address` |
| amount | `false` | `uint256` |

</p>

</details>


<details><summary><strong>Unstake <a name="ISaveBox--event--Unstake"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| boxId | `false` | `bytes32` |
| staker | `false` | `address` |
| amount | `false` | `uint256` |

</p>

</details>



## 🚀Functions <a name="ISaveBox--Functions"></a>
<dl>
<dt> <h3> createBox() <a name="ISaveBox--function--createBox()"></a> </h3> </dt>
<dd>

>creates box

🔨`anyone can call this function` |  👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  boxId  | `bytes32` |

boxId : keccak256(msg.sender, nonce[creator])

</dd>
<dt> <h3> stakeTo(bytes32,uint256) <a name="ISaveBox--function--stakeTo(bytes32,uint256)"></a> </h3> </dt>
<dd>

>stake `_amount` of token to `_boxId`

🔨`_boxId cannot be bytes32(0) it is assigned to individual staking` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _boxId | `bytes32` | id of staking box |
| _amount | `uint256` | amount to stake |


#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |

success true if succeeded

</dd>
<dt> <h3> unstakeFrom(bytes32) <a name="ISaveBox--function--unstakeFrom(bytes32)"></a> </h3> </dt>
<dd>

>unstake from `_boxId` box

🔨`_boxId cannot be bytes32(0) it is assigned to individual staking` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _boxId | `bytes32` | id of unstaking box |


#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |

success true if succeeded

</dd>
<dt> <h3> destroyBox(bytes32) <a name="ISaveBox--function--destroyBox(bytes32)"></a> </h3> </dt>
<dd>

>destroy `_boxId` box

🔨`cannot destroy if there is stake left` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _boxId | `bytes32` | id of box to destroy |


#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |

succeess true if succeeded

</dd>
<dt> <h3> stake(uint256) <a name="ISaveBox--function--stake(uint256)"></a> </h3> </dt>
<dd>

>stake `_amount` token for individual staking

 👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _amount | `uint256` | amount to stake |


#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |

success true if succeeded

</dd>
<dt> <h3> unstake() <a name="ISaveBox--function--unstake()"></a> </h3> </dt>
<dd>

>unstake all token staked as individual staking

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |

success true if succeeded

</dd>
<dt> <h3> boxId(address,uint256) <a name="ISaveBox--function--boxId(address,uint256)"></a> </h3> </dt>
<dd>

>get boxId using creator address and nonce

 👀 `view`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _creator | `address` | creator address |
| _nonce | `uint256` | nonce used to create box |


#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bytes32` |

boxId as bytes32

</dd>
<dt> <h3> stakeAmount(bytes32,address) <a name="ISaveBox--function--stakeAmount(bytes32,address)"></a> </h3> </dt>
<dd>

>returns stake amount of `_staker` at `_boxId`

🔨`_boxId is bytes32(0), for individual staking` |  👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `uint256` |

amount of stake

</dd>
<dt> <h3> boxInfo(bytes32) <a name="ISaveBox--function--boxInfo(bytes32)"></a> </h3> </dt>
<dd>

>returns save box info of `_boxId` box

 👀 `view`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _boxId | `bytes32` | id of box to query |


#### → Returns

| Name | Type |
|:-:|:-:|
|  creator  | `address` |
|  createdAt  | `uint256` |
|  balance  | `uint256` |
|  destroyed  | `bool` |

creator : address of box creatorcreatedAt : second of created time as unix timestampbalance : total amount of stakedestroyed : true if destroyed

</dd>
</dl>
