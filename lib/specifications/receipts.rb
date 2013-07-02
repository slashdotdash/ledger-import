module Specifications
  class Receipts
    def self.specifications
      defaults = { 
        :rows => (17..52),
        :date => 'I',
        :description => 'J'
      }
        
      invoices = Specification.new(defaults.merge({ :to => 'Assets:Current Account', :from => 'Assets:Accounts Receivable', :amount => 'L' }))
      interest = Specification.new(defaults.merge({ :to => 'Assets:Current Account', :from => 'Income:Interest', :amount => 'M' }))
      other = Specification.new(defaults.merge({ :to => 'Assets:Current Account', :from => 'Income:Other', :amount => 'N' }))

       [ invoices, interest, other ]   
    end
  end
end