class OneHundBrand < ActiveRecord::Base
    has_many :bags
    has_many :baged_users, through: :bags, source: :user
    validates_uniqueness_of :brand_title
        
  def self.stock 
    agent = Mechanize.new
        for i in 1..10
            page = agent.get"http://finance.naver.com/sise/entryJongmok.nhn?order=now_val&isRightDirection=true&page=#{i}"
            one_hund_brand_list = page.search('td.ctg').map(&:text)
            ko = Array.new 
             for j in 0..9
                ko << page.search('td.ctg')[j].children[0].attributes["href"].value.split('=')[1]
             end
            one_hund_brand_number = ko
            one_hund_brand_list.zip(one_hund_brand_number).each do |f, k|
                OneHundBrand.create(brand_title: f, brand_number: k)
            end
        end
        
        for i in 0..100 
          begin
            item = OneHundBrand.all.to_a[i]
            pricepage = agent.get"http://finance.naver.com/item/sise_day.nhn?code=#{OneHundBrand.all[i].brand_number}&page=1"
              price = pricepage.search('tr[3] td[2]').children.text.delete(',')
              item.brand_price = price
              item.save
              
            infopage = agent.get"http://companyinfo.stock.naver.com/v1/company/c1010001.aspx?cmp_cd=#{OneHundBrand.all[i].brand_number}"
              eps = infopage.search('b.num')[1].children.text.delete(',')
              item.brand_eps = eps
              item.save
              
              bps = infopage.search('b.num')[2].children.text.delete(',')
              item.brand_bps = bps
              item.save
              
              per = infopage.search('b.num')[3].children.text.to_f
              item.brand_per = per
              item.save
              
              bizper = infopage.search('b.num')[4].children.text.to_f #업종per
              item.brand_bizper = bizper
              item.save
              
              pbr = infopage.search('b.num')[5].children.text.to_f
              item.brand_pbr = pbr
              item.save
              
              cashprofitratio = infopage.search('b.num')[6].children.text.match(/\d+\.\d+/)[0].to_f #현금배당수익률
              item.brand_cashprofitratio = cashprofitratio
              item.save
              
              beta = infopage.search('td.num')[5].children.text.match(/\d+\.\d+/)[0].to_f
              item.brand_beta = beta
              item.save
              
            ajaxpage = agent.get"http://companyinfo.stock.naver.com/v1/company/ajax/cF1001.aspx?cmp_cd=#{OneHundBrand.all[i].brand_number}&fin_typ=0&freq_typ=A"
              bizprofitratio = ajaxpage.search('tr[19] td.num')[2].children.text.match(/\d+\.\d+/)[0].to_f #영업이익률
              item.brand_bizprofitratio = bizprofitratio
              item.save
              
              netincomeratio = ajaxpage.search('tr[20] td.num')[2].children.text.match(/\d+\.\d+/)[0].to_f #순이익률
              item.brand_netincomeratio = netincomeratio
              item.save
              
              roe = ajaxpage.search('tr[21] td.num')[2].children.text.match(/\d+\.\d+/)[0].to_f
              item.brand_roe = roe
              item.save
              
              
              dps2014 = ajaxpage.search('tr[29] td.num')[0].children.text.delete(',').to_f
              dps2015 = ajaxpage.search('tr[29] td.num')[1].children.text.delete(',').to_f
              dps2016 = ajaxpage.search('tr[29] td.num')[2].children.text.delete(',').to_f
            
              if dps2014&&dps2015 == 0
                item.brand_dpsr = 0
                item.save
              elsif dps2014 == 0
                dpsr = (dps2016-dps2015)/dps2015 +1
                item.brand_dpsr = dpsr
                item.save
              elsif dps2015 == 0
                dpsr = (dps2016-dps2014)/dps2014 +1
                item.brand_dpsr = dpsr
                item.save
              else
                dpsr1415 = ((dps2015-dps2014)/dps2014) +1
                dpsr1516 = ((dps2016-dps2015)/dps2015) +1
                dpsr = (dpsr1415 * dpsr1516) ** 0.5
                item.brand_dpsr = dpsr
                item.save
              end
          rescue NoMethodError
            
          end
          
        end

  end
  def self.brand_image 
      agent = Mechanize.new
        for i in 0..100 #Stock.all.to_a.length 활용하면 더 좋을듯
            # begin
                puts i
                item = OneHundBrand.all.to_a[i]
            
            # Stock.all.each do |item|
                target = item.brand_title 
                page = agent.get"http://terms.naver.com/search.nhn?query=#{target}&subject=1300"
                @brand_image_src = page.at('a > img')['data-src']
                item.brand_img_src = @brand_image_src
                item.save
            # rescue Mechanize::ResponseCodeError
          
            # end
        end
  end
  
  def self.search(name)
    if name
        EasyTranslate.api_key = 'AIzaSyBWo2VQJ5G8a202gNlv1zAtk968b1a2XTc'
        ename = EasyTranslate.translate(name, :to => :en)
        kname = EasyTranslate.translate(name, :to => :ko)
        where('brand_title LIKE? OR brand_title LIKE? OR brand_title LIKE?', "%#{name}%", "%#{ename}%", "%#{kname}%") 
    else
      all
    end
  end  
end