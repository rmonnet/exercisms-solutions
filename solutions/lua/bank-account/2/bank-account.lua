local BankAccount = {}
BankAccount.__index = BankAccount

function BankAccount:balance()
    return self._balance
end

function BankAccount:deposit(amount)
    assert(self._opened, "can't deposit in a closed account")
    assert(amount > 0, "deposit must be positive")
    self._balance = self._balance + amount
end

function BankAccount:withdraw(amount)
    assert(self._opened, "can't withdraw from a closed account")
    assert(amount > 0, "withdraw must be positive")
    assert(self._balance - amount > 0, "not enough funds for withdrawal")
    self._balance = self._balance - amount
end    

function BankAccount:close()
    self._opened = false
end

function BankAccount.new()
        
    local account = {_balance = 0, _opened = true}
    setmetatable(account, BankAccount)        
    return account
end

return BankAccount
