# encoding: utf-8

class LedgerWriter
  def initialize(transactions)
    @transactions = transactions
    @number_formatter = NumberFormatter.new
  end

  # 
  # 2013/01/01 Payment for INVOICE1
  #   Assets:Current Account    £1,200.00
  #   Assets:Accounts Receivable
  # 
  def to_s
    builder = []
    
    @transactions.each do |transaction|
      builder << "#{formatted_date(transaction.date)} #{transaction.description}"
      
      transaction.postings.each do |posting|
        builder << "  #{posting.account.name}#{formatted_amount(posting.amount)}"
      end
    end
    
    builder.join("\n")
  end
  
private
  
  def formatted_date(date)
    date.strftime '%Y/%m/%d'
  end
  
  def formatted_amount(amount)
    return '' if amount.nil?
    
    "\t\t" + @number_formatter.number_to_currency(amount, :unit => '£')
  end
end