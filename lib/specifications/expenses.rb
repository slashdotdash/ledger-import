module Specifications
  class Expenses
    def self.for(format)
      Expenses.new(format).specifications
    end
    
    def initialize(format)
      @format = format
    end
    
    def specifications
      defaults = { 
        :rows => rows,
        :date => 'A',
        :description => 'B',
        :from => { 
          'D' => 'Assets:Current Account',
          'E' => 'Liabilities:Reimbursements:Expenses',
          'F' => 'Liabilities:Credit Card'
        }
      }
      
      expenses = expenses_for_format(defaults)
      
      # reclaimed expenses
      expenses << Specification.new(defaults.merge({ :to => 'Liabilities:Reimbursements:Expenses', :from => 'Assets:Current Account', :amount => ['D', 'E'] }))
      expenses << Specification.new(defaults.merge({ :to => 'Liabilities:Credit Card', :from => 'Assets:Current Account', :amount => ['D', 'F'] }))
      
      expenses
    end
  
  private
    def rows
      case @format 
        when '2013-14', '2012-13'
          (80..196)
        when '2011-12', '2010-11', '2009-10', '2008-09'
          (69..99)
        else 
          throw 'Format not recognised'
      end
    end
    
    def expenses_for_format(defaults)
      case @format
        when '2013-14', '2012-13', '2011-12', '2010-11'
          [ 
            Specification.new(defaults.merge({ :to => 'Expenses:Motor', :amount => 'H' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Travel', :amount => 'I' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Insurance', :amount => 'J' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Pension', :amount => 'K' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Salary', :amount => 'L' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Tax:PAYE/NI', :amount => 'M' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Dividend', :amount => 'N' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Goods Sold', :amount => 'O' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Stationery', :amount => 'P' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Internet', :amount => 'Q' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Assets Purchased', :amount => 'R' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Computer', :amount => 'S' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Subscriptions', :amount => 'T' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Accountancy', :amount => 'U' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Bank Charges', :amount => 'V' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Home', :amount => 'W' })),
            Specification.new(defaults.merge({ :to => 'Assets:Deposit Account', :amount => 'X' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Tax:VAT', :amount => 'Y' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Tax:Corporation', :amount => 'Z' })),
            Specification.new(defaults.merge({ :to => 'Assets:Directors Loan', :amount => 'AA' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Entertainment', :amount => 'AB' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Sundries', :amount => 'AC' })),
          ]
        when '2009-10', '2008-09'
          [
            Specification.new(defaults.merge({ :to => 'Expenses:Motor', :amount => 'H' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Travel', :amount => 'I' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Accommodation', :amount => 'J' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Insurance', :amount => 'K' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Pension', :amount => 'L' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Goods Sold', :amount => 'M' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Salary', :amount => 'N' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Tax:PAYE/NI', :amount => 'O' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Salary', :amount => 'P' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Stationery', :amount => 'Q' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Internet', :amount => 'R' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Assets Purchased', :amount => 'S' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Computer', :amount => 'T' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Tax:VAT', :amount => 'U' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Subscriptions', :amount => 'V' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Dividend', :amount => 'W' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Accountancy', :amount => 'X' })),
            Specification.new(defaults.merge({ :to => 'Assets:Deposit Account', :amount => 'Y' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Bank Charges', :amount => 'Z' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Home', :amount => 'AA' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Tax:Corporation', :amount => 'AB' })),
            Specification.new(defaults.merge({ :to => 'Assets:Directors Loan', :amount => 'AC' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Entertainment', :amount => 'AD' })),
            Specification.new(defaults.merge({ :to => 'Expenses:Sundries', :amount => 'AE' })),
          ]
        else 
          throw 'Format not recognised'
      end
    end
  end
end