module Specifications
  class Specification
    # top-level accounts: Equity, Assets, Liabilities, Expenses, Income
    def initialize(configuration)
      @configuration = configuration
    end
    
    def each_row(&blk)
      @configuration[:rows].each do |row|
        yield row
      end
    end
    
    def to_account
      @configuration[:to]
    end

    def from_account
      @configuration[:from]
    end
    
    def date_cell
      @configuration[:date]
    end
    
    def description_cell
      @configuration[:description]
    end
    
    def amount_cell
      @configuration[:amount]
    end
  end
end