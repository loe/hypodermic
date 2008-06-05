require File.expand_path("#{File.dirname(__FILE__)}/../helper")

module HypodermicSpecHelper
  def stub_document
    @path = File.expand_path("#{File.dirname(__FILE__)}/document.xml")
    @mockument = File.open(@path)
    Zip::ZipFile.stub!(:open).and_return(@mockument)
  end
end
 
describe Hypodermic do
  include HypodermicSpecHelper
  
  describe '.extract' do
    # it 'should not raise an error' do
    #   lambda { Hypodermic.extract('path', :thumbnail => true) }.should_not raise_error
    # end
  end  
  
  describe ".document_xml" do
    before(:each) do
      stub_document
    end
    
    it "should not raise an error, given a path argument" do
      lambda { Hypodermic.send(:document_xml, "path") }.should_not raise_error
    end
    
    it "should return the document.xml" do
      result = Hypodermic.send(:document_xml, "path")
      result.should == File.read(@path)
    end
  end
  
  describe ".document" do
    before(:each) do
      stub_document
    end
    
    it "should not raise an error" do
      lambda { Hypodermic.send(:document, "path") }.should_not raise_error
    end
    
    it "should return the file without tags" do
      result = Hypodermic.send(:document, "path")
      result.should == File.read(@path).gsub(/<.*?>/, ' ')
    end
  end
  
end