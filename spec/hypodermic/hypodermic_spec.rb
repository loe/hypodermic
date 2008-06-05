require File.expand_path("#{File.dirname(__FILE__)}/../helper")

module HypodermicSpecHelper
  def stub_document
    @document_path = File.expand_path("#{File.dirname(__FILE__)}/foo/word/document.xml")
    @mockument = File.open(@document_path)
    Zip::ZipFile.stub!(:open).and_return(@mockument)
  end
  
  def stub_thumbnail
    @thumbnail_path = File.expand_path("#{File.dirname(__FILE__)}/foo/docProps/thumbnail.jpeg")
    @mocknail = File.open(@thumbnail_path)
    Zip::ZipFile.stub!(:open).and_return(@mocknail)
  end
end
 
describe Hypodermic do
  include HypodermicSpecHelper
  
  describe ".extract" do
    before(:each) do
      stub_document
    end
    
    it "should not raise an error if you pass a path" do
      lambda { Hypodermic.extract("path") }.should_not raise_error
    end
    
    it "should not raise an error if you also want a thumbnail" do
      lambda { Hypodermic.extract("path", :thumbnail => true) }.should_not raise_error
    end
    
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
      result.should == File.read(@document_path)
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
      result.should == File.read(@document_path).gsub(/<.*?>/, ' ')
    end
  end
  
  describe ".thumbnail" do
    before(:each) do
      stub_thumbnail
    end
    
    it "should not raise an error, given the path argument" do
      lambda { Hypodermic.send(:thumbnail, "path") }
    end
    
    it "should return thumbnail.jpeg" do
      result = Hypodermic.send(:thumbnail, "path")
      result.should == File.read(@thumbnail_path)
    end
  end
  
end