# encoding: utf-8

require './ledger_import'

describe LedgerWriter do
  context "when writing Ledger dat file" do
    before(:all) do
      @transaction = Transaction.new(Date.new(2013, 1, 1), 'Payment for INVOICE1')
      @transaction.postings << Posting.new(Account.new('Assets:Current Account'), 1_200)
      @transaction.postings << Posting.new(Account.new('Assets:Accounts Receivable'))
      
      @transactions = [ @transaction ]
    end
    
    subject { LedgerWriter.new(@transactions).to_s }
    specify { should == <<EXPECTED
2013/01/01 Payment for INVOICE1
  Assets:Current Account    £1,200.00
  Assets:Accounts Receivable
EXPECTED
    }
  end
end