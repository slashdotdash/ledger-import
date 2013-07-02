require './ledger_import'

describe ExcelImporter do
  context "when parsing transactions" do
    before(:all) do
      file = File.expand_path('../data/SJD-Spreadsheet-2013-2014.xls', __FILE__)
      @transactions = ExcelImporter.new(file).read
    end
    
    subject { @transactions }
    specify { should_not be_empty }

    context "sales invoices" do
      subject { @transactions[0] }
      specify { subject.description.should == 'Contracting Services' }
      specify { subject.date.should == Date.new(2013, 1, 1) }
      specify { subject.postings.length.should == 2 }
      
      context "to" do
        subject { @transactions[0].postings[0] }
        specify { subject.account.name.should == 'Assets:Accounts Receivable'  }
        specify { subject.amount.should == 1_200 }
      end

      context "from" do
        subject { @transactions[0].postings[1] }
        specify { subject.account.name.should == 'Income:Sales'  }
        specify { subject.amount.should be_nil }
      end      
    end
    
    context "receipts" do
      subject { @transactions[1] }
      specify { subject.description.should == 'Payment for INVOICE1' }
      specify { subject.date.should == Date.new(2013, 1, 10) }
      specify { subject.postings.length.should == 2 }
      
      context "to" do
        subject { @transactions[1].postings[0] }
        specify { subject.account.name.should == 'Assets:Current Account' }
        specify { subject.amount.should == 1_200 }
      end

      context "from" do
        subject { @transactions[1].postings[1] }
        specify { subject.account.name.should == 'Assets:Accounts Receivable' }
        specify { subject.amount.should be_nil }
      end      
    end
    
    context "expenses" do
      context "motor" do
        subject { @transactions[2] }
        specify { subject.description.should == 'Car fuel' }
        specify { subject.date.should == Date.new(2013, 1, 11) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @transactions[1].postings[0] }
          specify { subject.account.name.should == 'Expenses:Motor' }
          specify { subject.amount.should == 50 }
        end

        context "from" do
          subject { @transactions[1].postings[1] }
          specify { subject.account.name.should == 'Expenses:Cash' }
          specify { subject.amount.should be_nil }
        end
      end
    end
  end
end