# Author:: W. Andrew Loe II (<loe@onehub.com>)
# Moral Support:: Leigh Caplan (<lcaplan@onehub.com>)
# Copyright:: Copyright (c) 2008 Onehub, Inc.
# License:: GNU General Public License version 2 or later
# 
# This program and entire repository is free software; you can
# redistribute it and/or modify it under the terms of the GNU 
# General Public License as published by the Free Software 
# Foundation; either version 2 of the License, or any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

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
    d = Zip::ZipFile.open(path) { |z| z.read('word/document.xml') }
    d.read
  end
  
  def self.document(path)
    doc_xml = self.document_xml(path)
    doc_xml.gsub(/<.*?>/, ' ')
  end
  
  def self.thumbnail(path)
    t = Zip::ZipFile.open(path) { |z| z.read('docProps/thumbnail.jpeg') }
    t.read
  end
      
end
