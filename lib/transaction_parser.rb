require 'date'

class TransactionParser
  def initialize(workbook, format)
    @workbook, @format = workbook, format
  end
  
  def extract_transactions
    transactions = []
    
    each_specification do |spec|
      spec.each_row do |row|
        if value_present?(row, spec.amount_column)
          transactions << create_transaction(spec, row)
        end
      end
    end
    
    transactions
  end
  
private
  
  def value_present?(row, column_or_array)
    if column_or_array.is_a?(Array)
      column_or_array.all? {|column| value_present?(row, column) }
    else
      !@workbook.celltype(row, column_or_array).to_s.empty? && @workbook.cell(row, column_or_array).to_f != 0
    end
  end
  
  def cell_converted_from_type(row, column, conversions)
    value = @workbook.cell(row, column)
    type = @workbook.celltype(row, column)
    
    if conversions.has_key?(type)
      conversions[type].call(value)
    else
      throw "No conversion for cell type: '#{type}' (in sheet '#{@workbook.default_sheet}', cell #{row}#{column})"
    end
  end
  
  def ensure_cell_type_is(row, column, type)
    actual_type = @workbook.celltype(row, column)
    throw "Expected cell type: '#{type}' but found: '#{actual_type}' (#{@workbook.default_sheet} #{row}#{column})" unless actual_type == type
  end
  
  def each_specification(&blk)
    specs = Specifications::Receipts.for(@format) + 
      Specifications::Invoices.for(@format) + 
      Specifications::Expenses.for(@format)
    
    specs.each do |spec|
      yield spec
    end
  end
  
  def create_transaction(spec, row)
    date = parse_date(row, spec.date_column)
    
    description = @workbook.cell(row, spec.description_column)
    amount = @workbook.cell((spec.amount_column.is_a?(Array) ? spec.amount_column[0] : spec.amount_column), row).to_f
    
    Transaction.new(date, description).tap do |transaction|
      transaction.postings << Posting.new(create_account(spec.to_account, row), amount)
      transaction.postings << Posting.new(create_account(spec.from_account, row))
    end
  end
  
  def parse_date(row, column)
    date = cell_converted_from_type(row, column, {
      :date => Proc.new {|cell| cell },
      :string => Proc.new {|cell| Date.parse(cell) }
      })

    throw "Invalid date (#{row}#{column})" if date.nil?
    date
  end
  
  def create_account(name_or_hash, row)
    if name_or_hash.is_a?(Hash)
      key = name_or_hash.keys.detect {|column| value_present?(row, column) }
      Account.new(name_or_hash[key])
    else
      Account.new(name_or_hash)
    end
  end
end