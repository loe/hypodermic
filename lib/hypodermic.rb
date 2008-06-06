require 'rubygems'
require 'zip/zip'
require 'hypodermic/version'

class Hypodermic

  MIME_TYPES = {
    '.docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    '.xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    '.pptx' => 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
  }

  def self.extract(path, opts = {})
    mime_type = opts[:mime_type] || MIME_TYPES[File.extname(path).downcase]
    document = self.document(path, mime_type)
    
    if opts[:thumbnail]
      thumbnail = self.thumbnail(path)
    end
    
    return document, thumbnail
  end
  
  private
  
  def self.document(path, mime_type)
    case mime_type
    when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      doc_xml = self.xml_from_word(path)
    when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      doc_xml = self.xml_from_excel(path)
    when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
      doc_xml = self.xml_from_powerpoint(path)
    else
      raise ArugmentError, "Invalid file!"
    end
    doc_xml.gsub(/<.*?>/, ' ')
  end
  
  def self.xml_from_word(path)
    Zip::ZipFile.open(path) { |z| z.read('word/document.xml') }
  end
  
  def self.xml_from_excel(path)
    Zip::ZipInputStream::open(path) { |io| while(entry = io.get_next_entry); xml = io.read if entry.name =~ /(xl\/worksheets\/)|(xl\/sharedStrings.xml)/; end; xml }      
  end
  
  def self.xml_from_powerpoint(path)
    Zip::ZipInputStream::open(path) { |io| while(entry = io.get_next_entry); xml = io.read if entry.name =~ /(ppt\/slides\/)|(ppt\/presentation.xml)/; end; xml }
  end
  
  def self.thumbnail(path)
    Zip::ZipFile.open(path) { |z| z.read('docProps/thumbnail.jpeg') }
  end
      
end
