class NumberFormatter
  # Formats a +number+ into a currency string. You can customize the format
  # in the +options+ hash.
  # * <tt>:precision</tt>  -  Sets the level of precision, defaults to 2
  # * <tt>:unit</tt>  - Sets the denomination of the currency, defaults to "$"
  # * <tt>:separator</tt>  - Sets the separator between the units, defaults to "."
  # * <tt>:delimiter</tt>  - Sets the thousands delimiter, defaults to ","
  #
  #  number_to_currency(1234567890.50)     => $1,234,567,890.50
  #  number_to_currency(1234567890.506)    => $1,234,567,890.51
  #  number_to_currency(1234567890.506, :precision => 3)    => $1,234,567,890.506
  #  number_to_currency(1234567890.50, :unit => "&pound;", :separator => ",", :delimiter => "") 
  #     => &pound;1234567890,50
  def number_to_currency(number, options = {})
    options   = stringify_keys(options)
    precision = options["precision"] || 2
    unit      = options["unit"] || "$"
    separator = precision > 0 ? options["separator"] || "." : ""
    delimiter = options["delimiter"] || ","
  
    begin
      parts = number_with_precision(number, precision).split('.')
      unit + number_with_delimiter(parts[0], delimiter) + separator + parts[1].to_s
    rescue
      number
    end
  end
    
  # Formats a +number+ with grouped thousands using +delimiter+. You
  # can customize the format in the +options+ hash.
  # * <tt>:delimiter</tt>  - Sets the thousands delimiter, defaults to ","
  # * <tt>:separator</tt>  - Sets the separator between the units, defaults to "."
  #
  #  number_with_delimiter(12345678)      => 12,345,678
  #  number_with_delimiter(12345678.05)   => 12,345,678.05
  #  number_with_delimiter(12345678, :delimiter => ".")   => 12.345.678
  def number_with_delimiter(number, delimiter=",", separator=".")
    begin
      parts = number.to_s.split(separator)
      parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
      parts.join separator
    rescue
      number
    end
  end


  # Formats a +number+ with the specified level of +precision+. The default
  # level of precision is 3.
  #
  #  number_with_precision(111.2345)    => 111.235
  #  number_with_precision(111.2345, 2) => 111.24
  def number_with_precision(number, precision=3)
    "%01.#{precision}f" % number
  rescue
    number
  end
  
private

  
  # Return a new hash with all keys converted to strings.
  def stringify_keys(hash)
    stringify_keys!(hash.dup)
  end

  # Destructively convert all keys to strings.
  def stringify_keys!(hash)
    hash.keys.each do |key|
      hash[key.to_s] = hash.delete(key)
    end
    hash
  end
end