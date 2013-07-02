class TransactionParser
  def initialize(workbook)
    @workbook = workbook
  end
  
  def extract_transactions
    transactions = []
    
    each_specification do |spec|
      spec.each_row do |row|
        if value_present?(spec.amount_cell, row)
          value = @workbook.cell(spec.amount_cell, row)
          transactions << create_transaction(spec, row)
        end
      end
    end
    
    transactions
  end
  
private
  
  def value_present?(column, row)
    ! @workbook.celltype(column, row).to_s.empty?
  end
  
  def each_specification(&blk)
    specs = Specifications::Receipts.specifications + Specifications::Invoices.specifications + Specifications::Expenses.specifications
    
    specs.each do |spec|
      yield spec
    end
  end
  
  def create_transaction(spec, row)
    date = @workbook.cell(spec.date_cell, row)
    description = @workbook.cell(spec.description_cell, row)
    amount = @workbook.cell(spec.amount_cell, row).to_f
    
    Transaction.new(date, description).tap do |transaction|
      transaction.postings << Posting.new(Account.new(spec.to_account), amount)
      transaction.postings << Posting.new(Account.new(spec.from_account))
    end
  end
end