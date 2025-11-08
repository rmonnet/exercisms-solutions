
export class BankAccount {
  
  constructor() {
    this._balance = 0;
    this._active = false;
  }

  open() {
    if (this._active) throw new ValueError('Account is already active');
    this._active = true;
  }

  close() {
    if (!this._active) throw new ValueError('Account is inactive');
    this._active = false;
    this._balance = 0;
  }

  deposit(amount) {
    if (!this._active) throw new ValueError('Account is inactive');
    if (amount < 0) throw new ValueError('Deposit amount must be positive');
    this._balance += amount;
  }

  withdraw(amount) {
    if (!this._active) throw new ValueError('Account is inactive');
    if (amount < 0) throw new ValueError('Withdrawal amount must be positive');
    if (amount > this._balance) throw new ValueError('Unsufficient funds for withdrawal');
    this._balance -= amount;
  }

  get balance() {
    if (!this._active) throw new ValueError('Account is inactive');
    return this._balance;
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
