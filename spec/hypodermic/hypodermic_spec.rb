require File.expand_path("#{File.dirname(__FILE__)}/../helper")

module HypodermicSpecHelper
  def stub_word_document
    @word_document_path = File.expand_path("#{File.dirname(__FILE__)}/foo.docx/word/document.xml")
    @word_document = File.open(@word_document_path)
    Zip::ZipFile.stub!(:open).and_return(@word_document)
  end
  
  def stub_excel_document
    @excel_document_path = File.expand_path("#{File.dirname(__FILE__)}/foo.xlsx/xl/sharedStrings.xml")
    @excel_document = File.open(@excel_document_path)
    Zip::ZipInputStream.stub(:open).and_return(@excel_document)
  end
  
  def stub_powerpoint_document
    @powerpoint_document_path = File.expand_path("#{File.dirname(__FILE__)}/foo.pptx/ppt/presentation.xml")
    @powerpoint_document = File.open(@powerpoint_document_path)
    Zip::ZipInputStream.stub(:open).and_return(@powerpoint_document)
  end
  
  def stub_thumbnail
    @thumbnail_path = File.expand_path("#{File.dirname(__FILE__)}/w/docProps/thumbnail.jpeg")
    @thumbnail = File.open(@thumbnail_path)
    Zip::ZipFile.stub!(:open).and_return(@thumbnail)
  end
end
 
describe Hypodermic do
  include HypodermicSpecHelper
  
  describe ".extract" do
    before(:each) do
      stub_word_document
    end
    
    it "should not raise an error if you pass a path" do
      lambda { Hypodermic.extract("path") }.should_not raise_error
    end
    
    it "should not raise an error if you also want a thumbnail" do
      lambda { Hypodermic.extract("path", :thumbnail => true) }.should_not raise_error
    end
    
  end  
  
  describe ".xml_from_word" do
    before(:each) do
      stub_word_document
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
      stub_word_document
    end
    
    it "should not raise an error" do
      lambda { Hypodermic.send(:document, "path") }.should_not raise_error
    end
    
    it "should return the file without tags" do
      result = Hypodermic.send(:document, "path")
      result.should == File.read(@word_document_path).gsub(/<.*?>/, ' ')
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