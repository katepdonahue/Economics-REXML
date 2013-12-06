require './economics'
require 'rexml/document'

file = File.new( "test.xml" )
doc = REXML::Document.new file


describe "#population" do
  it "should return a sorted hash with country keys and population values" do
    pop_hash = { :argentina => 34672997,
                 :algeria => 29183032,
                 :afghanistan => 22664136, 
                 :australia => 18260863,
                 :angola => 10342899, 
                 :bolivia => 7165257,
                 :armenia => 3463574, 
                 :albania => 3249136, 
                 :andorra => 72766, 
                 :antigua_and_barbuda => 65647, 
                 :american_samoa => 59566, 
                 :anguilla => 10424 }
    expect(country_access(doc, "population", "integer")).to eq(pop_hash)
  end
end

describe "#inflation_rates" do
  it "should return a sorted hash with country keys and inflation rates values" do
    inflation_hash = { :armenia => 32.2, 
                       :algeria => 28,
                       :angola => 20, 
                       :albania => 16, 
                       :bolivia => 12,
                       :australia => 4.75,
                       :anguilla => 4,
                       :antigua_and_barbuda => 3.5, 
                       :argentina => 1.7,
                       :afghanistan => 0, 
                       :american_samoa => 0, 
                       :andorra => 0 }
    expect(country_access(doc, "inflation", "float")).to eq(inflation_hash)
  end
end

describe "#continent_hash" do
  it "should return a sorted hash with continent keys and country array values" do
    continents = { :europe => [:albania, :andorra],
                   :asia => [:afghanistan, :armenia],
                   :north_america => [:anguilla, :antigua_and_barbuda],
                   :australia_oceania => [:american_samoa, :australia],
                   :south_america => [:argentina, :bolivia],
                   :africa => [:algeria, :angola] }
    expect(continent_hash(doc)).to eq(continents)
  end
end

describe String do

  describe "#name_format" do
    it "should turn a string into a symbol with underscores instead of spaces and no capitals" do
      expect("Antigua and Barbuda".name_format).to eq(:antigua_and_barbuda)
    end
  end

end

