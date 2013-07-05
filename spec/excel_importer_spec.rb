$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)) + '/../')

require './ledger_import'

describe ExcelImporter do
  context "when parsing transactions" do
    before(:all) do
      file = File.expand_path('../data/SJD-Spreadsheet-2013-2014.xls', __FILE__)
      @transactions = ExcelImporter.parse(:filename => file, :format => '2013-14')
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
        before(:each) { @motor = @transactions[2] }
        subject { @motor }
        specify { subject.description.should == 'Car Fuel' }
        specify { subject.date.should == Date.new(2013, 1, 11) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @motor.postings[0] }
          specify { subject.account.name.should == 'Expenses:Motor' }
          specify { subject.amount.should == 50 }
        end

        context "from" do
          subject { @motor.postings[1] }
          specify { subject.account.name.should == 'Expenses:Cash' }
          specify { subject.amount.should be_nil }
        end
      end
    
      context "travel" do
        before(:each) { @travel = @transactions[3] }
        subject { @travel }
        specify { subject.description.should == 'Train Ticket' }
        specify { subject.date.should == Date.new(2013, 1, 12) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @travel.postings[0] }
          specify { subject.account.name.should == 'Expenses:Travel' }
          specify { subject.amount.should == 100 }
        end

        context "from" do
          subject { @travel.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end
      
      context "insurance" do
        before(:each) { @insurance = @transactions[4] }
        subject { @insurance }
        specify { subject.description.should == 'Insurance' }
        specify { subject.date.should == Date.new(2013, 1, 13) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @insurance.postings[0] }
          specify { subject.account.name.should == 'Expenses:Insurance' }
          specify { subject.amount.should == 200 }
        end

        context "from" do
          subject { @insurance.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end
      
      context "pension" do
        before(:each) { @pension = @transactions[5] }
        subject { @pension }
        specify { subject.description.should == 'Pension Contribution' }
        specify { subject.date.should == Date.new(2013, 1, 14) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @pension.postings[0] }
          specify { subject.account.name.should == 'Expenses:Pension' }
          specify { subject.amount.should == 75 }
        end

        context "from" do
          subject { @pension.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end          

      context "salary" do
        before(:each) { @salary = @transactions[6] }
        subject { @salary }
        specify { subject.description.should == 'Salary' }
        specify { subject.date.should == Date.new(2013, 1, 15) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @salary.postings[0] }
          specify { subject.account.name.should == 'Expenses:Salary' }
          specify { subject.amount.should == 250 }
        end

        context "from" do
          subject { @salary.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end          

      context "PAYE/NI" do
        before(:each) { @tax = @transactions[7] }
        subject { @tax }
        specify { subject.description.should == 'PAYE/NI' }
        specify { subject.date.should == Date.new(2013, 1, 16) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @tax.postings[0] }
          specify { subject.account.name.should == 'Expenses:Tax:PAYE/NI' }
          specify { subject.amount.should == 50 }
        end

        context "from" do
          subject { @tax.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end

      context "dividend" do
        before(:each) { @transaction = @transactions[8] }
        subject { @transaction }
        specify { subject.description.should == 'Dividend' }
        specify { subject.date.should == Date.new(2013, 1, 17) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @transaction.postings[0] }
          specify { subject.account.name.should == 'Expenses:Dividend' }
          specify { subject.amount.should == 100 }
        end

        context "from" do
          subject { @transaction.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end

      context "dividend" do
        before(:each) { @transaction = @transactions[8] }
        subject { @transaction }
        specify { subject.description.should == 'Dividend' }
        specify { subject.date.should == Date.new(2013, 1, 17) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @transaction.postings[0] }
          specify { subject.account.name.should == 'Expenses:Dividend' }
          specify { subject.amount.should == 100 }
        end

        context "from" do
          subject { @transaction.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end

      context "cost of goods sold" do
        before(:each) { @transaction = @transactions[9] }
        subject { @transaction }
        specify { subject.description.should == 'Cost of Goods Sold' }
        specify { subject.date.should == Date.new(2013, 1, 18) }
        specify { subject.postings.length.should == 2 }
      
        context "to" do
          subject { @transaction.postings[0] }
          specify { subject.account.name.should == 'Expenses:Goods Sold' }
          specify { subject.amount.should == 10 }
        end

        context "from" do
          subject { @transaction.postings[1] }
          specify { subject.account.name.should == 'Assets:Current Account' }
          specify { subject.amount.should be_nil }
        end
      end
    end
  
    context "expenses reclaimed" do
      before(:each) do
        @transaction = @transactions.find {|transaction| transaction.description == 'Expenses Reclaimed' }
      end
      subject { @transaction }
      specify { should_not be_nil }
      
      specify { subject.description.should == 'Expenses Reclaimed' }
      specify { subject.date.should == Date.new(2013, 1, 31) }
      specify { subject.postings.length.should == 2 }
      
      context "to" do
        subject { @transaction.postings[0] }
        specify { subject.account.name.should == 'Expenses:Cash'  }
        specify { subject.amount.should == 90 }
      end

      context "from" do
        subject { @transaction.postings[1] }
        specify { subject.account.name.should == 'Assets:Current Account'  }
        specify { subject.amount.should be_nil }
      end
    end
  end
end