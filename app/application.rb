class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apples"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length >0
     @@cart.each {|item|
      resp.write "#{item}\n"}
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      add_item = req.params["item"]
      found = false
      #items.include?()
      @@items.each { |item|
        if item == add_item 
        found = true
        end
        }

      if found==true
        @@cart << add_item
        resp.write "added #{add_item}"
        
      else
        resp.write "We don't have that item"

        
      end

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
