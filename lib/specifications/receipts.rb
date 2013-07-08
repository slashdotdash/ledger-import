module Specifications
  class Receipts
    def self.for(format)
      Receipts.new(format).specifications
    end
    
    def initialize(format)
      @format = format
    end
    
    def specifications
      defaults = { 
        :rows => rows,
        :date => 'I',
        :description => 'J'
      }
        
      invoices = Specification.new(defaults.merge({ :to => 'Assets:Current Account', :from => 'Assets:Accounts Receivable', :amount => 'L' }))
      interest = Specification.new(defaults.merge({ :to => 'Assets:Current Account', :from => 'Income:Interest', :amount => 'M' }))
      other = Specification.new(defaults.merge({ :to => 'Assets:Current Account', :from => 'Income:Other', :amount => 'N' }))

       [ invoices, interest, other ]   
    end
  
  private
    def rows
      case @format 
        when '2013-14', '2012-13'
          (17..52)
        when '2011-12', '2010-11', '2009-10', '2008-09'
          (17..41)
        else 
          throw 'Format not recognised'
      end
    end
  end
end