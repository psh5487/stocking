class Logo < ActiveRecord::Base
  def self.famousfirm_logo
    agent = Mechanize.new
    for i in 1..241
        page = agent.get"http://terms.naver.com/list.nhn?cid=43167&page=#{i}&categoryId=43167"
            for a in 3..(page.search('img').length - 1)
                begin
                    famousfirm_logo = page.search('img')[a].attributes["data-src"].value
                    famousfirm_title = page.search('img')[a].attributes["alt"].value
                    Logo.create(logo_src: famousfirm_logo, firm_title: famousfirm_title)
                rescue
                    nil
                end
            end
    end    
  end
  
  def self.delete_even_number
      i = 2
      while i < 5419 do 
         Logo.delete(i)
         i = i + 2
      end    
  end
end
