require 'rubygems'
require 'roo'

class ExcelImporter
  def self.parse(options)
    filename = options[:filename]
    format = options[:format] || '2013-14'
    
    ExcelImporter.new(filename, format).read
  end
  
  def initialize(filename, format)
    @filename, @format = filename, format
    @transactions = []
  end
  
  # Open the Excel file and extract all transactions
  def read
    open_file
    
    parser = TransactionParser.new(@workbook, @format)
    
    each_monthly_sheet do |sheet|
      @transactions += parser.extract_transactions
    end

    @transactions.sort_by {|transaction| transaction.date }
  end
  
private

  def open_file
    @workbook = Roo::Excel.new(@filename)
  end

  def each_monthly_sheet(&blk)
    @workbook.sheets[2..13].each do |sheet|
      @workbook.default_sheet = sheet
      yield sheet
    end
  end
end