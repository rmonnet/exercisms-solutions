local BankAccount = {}

BankAccount.new = function()
        
    local account = {_balance = 0, _opened = true}
        
    account.balance = function(self)
        return self._balance
    end

    account.deposit = function(self, amount)
        assert(self._opened, "can't deposit in a closed account")
        assert(amount > 0, "deposit must be positive")
        self._balance = self._balance + amount
    end

    account.withdraw = function(self, amount)
        assert(self._opened, "can't withdraw from a closed account")
        assert(amount > 0, "withdraw must be positive")
        assert(self._balance - amount > 0, "not enough funds for withdrawal")
        self._balance = self._balance - amount
    end

    account.close = function(self)
        self._opened = false
    end
    
    return account
end

return BankAccount
