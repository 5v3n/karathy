require 'karakuri'
page_title = Karakuri::seo_friendly_title(@path, title, '5v3n.com')
xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do

  xml.title page_title
  xml.link "rel" => "self", "type" => "application/atom+xml", "href"=>"#{@config[:url]}index.xml"
  xml.id @config[:url]
  xml.updated articles.first[:date].iso8601 unless articles.empty?
  xml.author { xml.name @config[:author] }
  xml.link "rel" => "image_src", "href"=>"#{@config[:url]}favicon.ico"
  
  articles.reverse[0...10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article[:date].iso8601
      xml.updated article[:date].iso8601
      xml.author { xml.name @config[:author] }
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end

