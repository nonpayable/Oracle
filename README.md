# Oracle
Just like $LINK but won't scale.

# <h3>Configuration</h3>
1. Deploy oracle.sol<br>
2. Put deployed oracle address in <b>config/default.json</b><br>
3. Create new account (metamask or others) put in (ETH, AVAX, SOL or native token of your choice of chain) for gas<br>
4. Get ^'s address and privateKey put in <b>config/default.json</b> and do not leak it<br>
5. Call <b>auth(^)</b> on oracle's contract<br>
6. Auth contract from <b>auth()</b><br>
7. Change <b>callback_address</b> in handle.js<br>
8. Run node handle.js<br>

<h3>See <a href="https://github.com/nonpayable/Oracle/tree/main/example">Example</a></h3>
