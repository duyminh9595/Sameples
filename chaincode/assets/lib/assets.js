'use strict';

// SDK Library to asset with writing the logic 
const { Contract } = require('fabric-contract-api');

class Cs01Contract extends Contract {

  constructor() {
    super('CC');
    this.TxId = ''
  }




  //register user
  async registerUser(ctx, email, password, username, ngaysinh) {
    const user = {
      email,
      password,
      username,
      ngaysinh,
      balance: "0"
    };
    await ctx.stub.putState(email, Buffer.from(JSON.stringify(user)));
    console.info('============= END : Create User ===========');
  }
}

module.exports = Cs01Contract