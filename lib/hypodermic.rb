require 'rubygems'
require 'zip/zip'
require 'hypodermic/version'

class Hypodermic

  def self.extract(path, opts = {})
    document = self.document(path)
    
    if opts[:thumbnail]
      thumbnail = self.thumbnail(path)
    end
    
    return document, thumbnail
  end
  
  private
  
  def self.document_xml(path)
    Zip::ZipFile.open(path) { |z| z.read('word/document.xml') }
  end
  
  def self.document(path)
    doc_xml = self.document_xml(path)
    doc_xml.gsub(/<.*?>/, ' ')
  end
  
  def self.thumbnail(path)
    Zip::ZipFile.open(path) { |z| z.read('docProps/thumbnail.jpeg') }
  end
      
end
