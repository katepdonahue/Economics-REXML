require 'rexml/document'
file = File.new( "cia-1996.xml" )
doc = REXML::Document.new file

class String

  def name_format
    downcase.gsub(/\s|\//, "_").to_sym
  end

end

def country_access(docu, info, style)
  hash = Hash.new
  final_hash = Hash.new
  docu.elements.each("cia/country") do |element|
    data = element.attributes[info]
    hash[element.attributes["name"].name_format] = data.send(style)
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

class Hash
  
  def print_continents
    self.each do |key, val|
      puts "#{key}:"
      val.each do |country|
        puts "        #{country}"
      end
      puts
    end
  end

end

# what is the population of the country with the most people?
puts country_access(doc, "population", :to_i).first

# what are the five countries with the highest inflation rates?
puts country_access(doc, "inflation", :to_f).first(5)

# What are the continents and their countries in alphabetical order?
continent_hash(doc).print_continents

