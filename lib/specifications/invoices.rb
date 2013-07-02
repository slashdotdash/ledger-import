module Specifications
  class Invoices
    def self.specifications
      defaults = { 
        :rows => (17..52),
        :date => 'A',
        :description => 'B'
      }
        
      invoices = Specification.new(defaults.merge({ 
        :to => 'Assets:Accounts Receivable', 
        :from => 'Income:Sales', 
        :amount => 'F' }))

       [ invoices ]   
    end
  end
end