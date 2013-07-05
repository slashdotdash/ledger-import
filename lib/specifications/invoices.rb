module Specifications
  class Invoices
    def self.for(format)
        Invoices.new(format).specifications
    end
    
    def initialize(format)
      @format = format
    end
    
    def specifications
      defaults = { 
        :rows => rows,
        :date => 'A',
        :description => 'B'
      }
        
      invoices = Specification.new(defaults.merge({ 
        :to => 'Assets:Accounts Receivable', 
        :from => 'Income:Sales', 
        :amount => 'F' }))

       [ invoices ]   
    end
    
  private
    def rows
      case @format
        when '2013-14'
          (17..52)
        when '2012-13'
          (17..52)
        when '2011-12'
          (17..41)
        else 
          throw 'Format not recognised'
      end
    end
  end
end