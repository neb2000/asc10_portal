xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc root_url
    xml.changefreq 'weekly'
    xml.priority 1.0
  end
  
  xml.url do
    xml.loc forums_root_url
    xml.changefreq 'weekly'
    xml.priority 0.9
  end
  
  xml.url do
    xml.loc roster_url
    xml.changefreq 'weekly'
    xml.priority 0.9
  end
  
  xml.url do
    xml.loc new_application_form_url
    xml.changefreq 'weekly'
    xml.priority 0.9
  end

  @news_entries.each do |news_entry|
    xml.url do
      xml.loc news_entry_url(news_entry)
      xml.lastmod news_entry.updated_at.to_date
      xml.priority 0.9
    end
  end
end