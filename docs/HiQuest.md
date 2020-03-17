# <span id="HiQuest"></span> HiQuest
> 





## Contents


- [Events](#HiQuest--Events)


  - [HiquestCreated](#HiQuest--event--HiquestCreated)


  - [HiquestManagerChanged](#HiQuest--event--HiquestManagerChanged)


  - [UserJoined](#HiQuest--event--UserJoined)


  - [Rewarded](#HiQuest--event--Rewarded)


  - [HiquestClosed](#HiQuest--event--HiquestClosed)


  - [WithDrawn](#HiQuest--event--WithDrawn)



- [Functions](#HiQuest--Functions)


  - [create(bytes32,uint256,uint256,uint256)](#HiQuest--function--create(bytes32,uint256,uint256,uint256))


  - [join(bytes32,bytes)](#HiQuest--function--join(bytes32,bytes))


  - [changeManager(bytes32,address)](#HiQuest--function--changeManager(bytes32,address))


  - [reward(bytes32,address,uint256)](#HiQuest--function--reward(bytes32,address,uint256))


  - [close(bytes32)](#HiQuest--function--close(bytes32))


  - [withdrawDeposit(bytes32)](#HiQuest--function--withdrawDeposit(bytes32))


  - [questInfo(bytes32)](#HiQuest--function--questInfo(bytes32))


  - [managingQuests(address)](#HiQuest--function--managingQuests(address))


  - [joinedUsers(bytes32)](#HiQuest--function--joinedUsers(bytes32))



## 🦄Events <a name="HiQuest--Events"></a>


<details><summary><strong>HiquestCreated <a name="HiQuest--event--HiquestCreated"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| manager | `false` | `address` |
| open | `false` | `uint256` |
| close | `false` | `uint256` |
| deposit | `false` | `uint256` |

</p>

</details>


<details><summary><strong>HiquestManagerChanged <a name="HiQuest--event--HiquestManagerChanged"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| manager | `false` | `address` |

</p>

</details>


<details><summary><strong>UserJoined <a name="HiQuest--event--UserJoined"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| user | `false` | `address` |
| desc | `false` | `bytes` |

</p>

</details>


<details><summary><strong>Rewarded <a name="HiQuest--event--Rewarded"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| to | `false` | `address` |
| amount | `false` | `uint256` |

</p>

</details>


<details><summary><strong>HiquestClosed <a name="HiQuest--event--HiquestClosed"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |

</p>

</details>


<details><summary><strong>WithDrawn <a name="HiQuest--event--WithDrawn"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| amount | `false` | `uint256` |

</p>

</details>



## 🚀Functions <a name="HiQuest--Functions"></a>
<dl>
<dt> <h3> create(bytes32,uint256,uint256,uint256) <a name="HiQuest--function--create(bytes32,uint256,uint256,uint256)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> join(bytes32,bytes) <a name="HiQuest--function--join(bytes32,bytes)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> changeManager(bytes32,address) <a name="HiQuest--function--changeManager(bytes32,address)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> reward(bytes32,address,uint256) <a name="HiQuest--function--reward(bytes32,address,uint256)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> close(bytes32) <a name="HiQuest--function--close(bytes32)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> withdrawDeposit(bytes32) <a name="HiQuest--function--withdrawDeposit(bytes32)"></a> </h3> </dt>
<dd>

 👀 `nonpayable`

#### → Returns

| Name | Type |
|:-:|:-:|
|  Not specified  | `bool` |



</dd>
<dt> <h3> questInfo(bytes32) <a name="HiQuest--function--questInfo(bytes32)"></a> </h3> </dt>
<dd>

 👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  manager  | `address` |
|  open  | `uint256` |
|  end  | `uint256` |
|  deposit  | `uint256` |
|  balance  | `uint256` |
|  closed  | `bool` |



</dd>
<dt> <h3> managingQuests(address) <a name="HiQuest--function--managingQuests(address)"></a> </h3> </dt>
<dd>

 👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  quests  | `bytes32[]` |



</dd>
<dt> <h3> joinedUsers(bytes32) <a name="HiQuest--function--joinedUsers(bytes32)"></a> </h3> </dt>
<dd>

 👀 `view`

#### → Returns

| Name | Type |
|:-:|:-:|
|  users  | `address[]` |



</dd>
</dl>
