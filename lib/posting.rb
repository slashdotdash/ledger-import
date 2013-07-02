## Posting
#
# Each transaction is made up of two or more postings 
# (there is a special case that allows for just one, using virtual postings).
class Posting
  attr_reader :account, :amount
  
  def initialize(account, amount=nil)
    @account, @amount = account, amount
  end
end