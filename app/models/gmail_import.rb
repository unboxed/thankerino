module GmailImport

  def self.import!(file)
    require 'fastercsv'
    # require 'iconv'
    # lines = []
    file_content = file.read
    # content = Iconv.iconv('utf-8//IGNORE', 'cp1250//IGNORE', file_content)
    raw_statement = []

    FasterCSV.parse(file_content, :col_sep => ',', :row_sep => "\r\n") do |row|
      raw_statement << row
    end
    require 'ruby-debug'
    debugger
    :a
    # raw_statement.delete_at(0)
    # raw_statement.delete_at(0)
    # raw_statement.delete_at(raw_statement.length - 1)
    # raw_statement.each do |statement|
    #   
    #   transaction = Transaction.new(
    #     :name => statement[2],
    #     :amount => parse_price(statement[6]),
    #     :spent_at => parse_date(statement[0]),
    #     :autocategorization => true,
    #     :account => account,
    #     :import => self,
    #     :user => user || account.user
    #   )
    # 
    #   transaction.included = transaction.unique?
    #   transaction.save!
    # end
    # 
    # self.data_to_import = nil
  end

  private

    def parse_date(date_string)
      day, month, year = date_string.split('-')
      Date.civil(year.to_i, month.to_i, day.to_i)
    end

    def parse_price(price_string)
      BigDecimal.new(price_string.sub(',','.').sub('CZK','').gsub(' ',''))
    end

    def self.parse_csv_file(path_to_csv)
      lines = []
      FasterCSV.foreach(path_to_csv) do |row|
        lines << row
      end
      lines
    end

end