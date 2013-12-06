# require 'rexml/document'
# file = File.new( "cia-1996.xml" )
# doc = REXML::Document.new file

class String

  def name_format
    downcase.gsub(/\s|\//, "_").to_sym
  end

end

def population(docu)
  hash = Hash.new
  final_hash = Hash.new
  docu.elements.each("cia/country") do |element|
    hash[element.attributes["name"].name_format] = element.attributes["population"].to_i
  end
  arrays = hash.sort_by {|key, val| val}
  arrays.reverse.each do |array|
    final_hash[array[0]] = array[1]
  end
  final_hash
end

def inflation_rates(docu)
  hash = Hash.new
  final_hash = Hash.new
  docu.elements.each("cia/country") do |element|
    hash[element.attributes["name"].name_format] = element.attributes["inflation"].to_f
  end
  arrays = hash.sort_by {|key, val| val}
  arrays.reverse.each do |array|
    final_hash[array[0]] = array[1]
  end
  final_hash
end

def continent_hash(docu)
  hash = Hash.new
  final_hash = Hash.new
  docu.elements.each("cia/continent") do |element|
    hash[element.attributes["name"].name_format] = []
  end
  docu.elements.each("cia/country") do |element|
    hash[element.attributes["continent"].name_format] <<  element.attributes["name"].name_format
  end
  hash
end