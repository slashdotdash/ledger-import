module Specifications
  class Expenses
    def self.specifications
      defaults = { 
        :rows => (80..107),
        :date => 'A',
        :description => 'B',
        :from => { 
          'D' => 'Assets:Current Account',
          'E' => 'Expenses:Cash',
          'F' => 'Liabilities:Credit Card'
        }
      }
        
      motor = Specification.new(defaults.merge({ :to => 'Expenses:Motor', :amount => 'H' }))
      travel = Specification.new(defaults.merge({ :to => 'Expenses:Travel', :amount => 'I' }))
      insurance = Specification.new(defaults.merge({ :to => 'Expenses:Insurance', :amount => 'J' }))
      
      [ motor, travel, insurance ]
    end
  end
end