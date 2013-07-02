## Account
#
# An account is any place that accumulates quantities, of any meaning. 
#
# They can be named anything, the names can even contain spaces, and they can mean whatever you want. 
#
# Students of accounting will use five top-level names: Equity, Assets, Liabilities, Expenses, Income. 
# All other accounts are specified as children of these accounts. 
# This is not required by Ledger, however, nor does it even know anything about what these names mean. That’s all left up to the user.  
class Account
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end