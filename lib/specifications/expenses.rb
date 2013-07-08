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
          'E' => 'Expenses:Cash',
          'F' => 'Liabilities:Credit Card'
        }
      }
        
      motor = Specification.new(defaults.merge({ :to => 'Expenses:Motor', :amount => 'H' }))
      travel = Specification.new(defaults.merge({ :to => 'Expenses:Travel', :amount => 'I' }))
      insurance = Specification.new(defaults.merge({ :to => 'Expenses:Insurance', :amount => 'J' }))
      pension = Specification.new(defaults.merge({ :to => 'Expenses:Pension', :amount => 'K' }))
      salary = Specification.new(defaults.merge({ :to => 'Expenses:Salary', :amount => 'L' }))
      paye_ni = Specification.new(defaults.merge({ :to => 'Expenses:Tax:PAYE/NI', :amount => 'M' }))
      dividend = Specification.new(defaults.merge({ :to => 'Expenses:Dividend', :amount => 'N' }))
      cost_of_goods_sold = Specification.new(defaults.merge({ :to => 'Expenses:Goods Sold', :amount => 'O' }))
      stationery = Specification.new(defaults.merge({ :to => 'Expenses:Stationery', :amount => 'P' }))
      internet = Specification.new(defaults.merge({ :to => 'Expenses:Internet', :amount => 'Q' }))
      assets_purchased = Specification.new(defaults.merge({ :to => 'Expenses:Assets Purchased', :amount => 'R' }))
      computer = Specification.new(defaults.merge({ :to => 'Expenses:Computer', :amount => 'S' }))
      subscriptions = Specification.new(defaults.merge({ :to => 'Expenses:Subscriptions', :amount => 'T' }))
      accountancy = Specification.new(defaults.merge({ :to => 'Expenses:Accountancy', :amount => 'U' }))
      bank_charges = Specification.new(defaults.merge({ :to => 'Expenses:Bank Charges', :amount => 'V' }))
      home_use = Specification.new(defaults.merge({ :to => 'Expenses:Home', :amount => 'W' }))
      deposit_account = Specification.new(defaults.merge({ :to => 'Assets:Deposit Account', :amount => 'X' }))
      vat = Specification.new(defaults.merge({ :to => 'Expenses:Tax:VAT', :amount => 'Y' }))
      corporation_tax = Specification.new(defaults.merge({ :to => 'Expenses:Tax:Corporation', :amount => 'Z' }))
      directors_loan = Specification.new(defaults.merge({ :to => 'Expenses:Directors Loan', :amount => 'AA' }))
      entertainment = Specification.new(defaults.merge({ :to => 'Expenses:Entertainment', :amount => 'AB' }))
      sundries = Specification.new(defaults.merge({ :to => 'Expenses:Sundries', :amount => 'AC' }))
      
      # reclaimed expenses
      reimbursed_cash = Specification.new(defaults.merge({ :to => 'Expenses:Cash', :from => 'Assets:Current Account', :amount => ['D', 'E'] }))
      reimbursed_credit_card = Specification.new(defaults.merge({ :to => 'Liabilities:Credit Card', :from => 'Assets:Current Account', :amount => ['D', 'F'] }))
      
      [ 
        motor, 
        travel, 
        insurance, 
        pension, 
        salary, 
        paye_ni, 
        dividend, 
        cost_of_goods_sold, 
        stationery, 
        internet, 
        assets_purchased,
        computer,
        subscriptions,
        accountancy,
        bank_charges,
        home_use,
        deposit_account,
        vat,
        corporation_tax,
        directors_loan,
        entertainment,
        sundries,
        reimbursed_cash,
        reimbursed_credit_card
      ]
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
  end
end