require 'rubygems'
require 'bluecloth'
require 'open-uri'
require 'json'
require 'hpricot'

def escape_xml(s)
  escaped = s.dup
  
  escaped.gsub!("&", "&amp;")
  escaped.gsub!("<", "&lt;")
  escaped.gsub!(">", "&gt;")
          
  return escaped
end
  
url = "http://ckan.net/api/rest/package"

data = open(url).read()
pkglist = JSON.parse( data )

f = File.open("ckan.rdf", "w")
f.puts "\
<rdf:RDF     
 xmlns:dc=\"http://purl.org/dc/terms/\"\n\
 xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\"\n\
 xmlns:foaf=\"http://xmlns.com/foaf/0.1/\"\n\
 xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n\
 xmlns:cc=\"http://creativecommons.org/ns#\"\n\
 xmlns:ckan=\"http://ckan.net/ontology/\">\n\n"    

#name = "patent-nber"
pkglist.each do |name|
  if name != nil && name != "patent-nber" && name != "esfdb" && name != "hapmap"
    
    api_request = "http://ckan.net/api/rest/package/#{name}/"
    data = open(api_request).read()
    json = JSON.parse( data )
    
    f.puts "<ckan:Package rdf:about=\"http://ckan.net/package/rdf/#{name}/\">"
    
    if json["title"] != nil && json["title"] != ""
      f.puts "<dc:title>#{escape_xml( json["title"])}</dc:title>"  
    end
    
    if json["url"] != nil && json["url"] != ""
      f.puts "<foaf:homepage rdf:resource=\"#{escape_xml( json["url"] ) }\"/>"  
    end
    
    f.puts "<foaf:isPrimaryTopicOf rdf:resource=\"http://ckan.net/package/#{name}\"/>"
    if json["download_url"] != nil && json["download_url"] != ""
      f.puts "<ckan:downloadURL rdf:resource=\"#{escape_xml( json["download_url"] )}\"/>"  
    end
      
    json["tags"].each do |tag|
      f.puts "<dc:subject>#{escape_xml(tag)}</dc:subject>"
    end
    
    if json["notes"] != nil && json["notes"] != ""
      f.puts "<dc:description rdf:parseType=\"Literal\">"
      bc = BlueCloth.new( json["notes"])
      doc = Hpricot( bc.to_html() )
      f.puts doc
      f.puts "</dc:description>"
      
    end
    f.puts "</ckan:Package>"
        
  end  
  
end

f.puts "\n\n</rdf:RDF>"
f.close()  

