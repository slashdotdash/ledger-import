## Transaction
#
# A transaction represents something that you want to enter into your journal. 
#
# For example, if you just cashed a paycheck from your employer by depositing it into your bank account, 
# this entire action is called an "transaction". 
#
# The total cost of every transaction must balance to zero. 
# This guarantee that no amounts can be lost due to balancing errors.
class Transaction
  attr_reader :postings, :date, :description
  
  def initialize(date, description)
    @date, @description = date, description
    @postings = []
  end
end