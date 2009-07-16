class RubyamfController < ActionController::Base

  include RubyAMF::App
  
  def gateway      
    RequestStore.rails_authentication = nil #clear auth hash
    RequestStore.rails_request = request
    RequestStore.rails_response = response
          
    #Compress the amf output for smaller data transfer over the wire
    RequestStore.gzip = request.env['ACCEPT_ENCODING'].to_s.match(/gzip,[\s]{0,1}deflate/)
    
    #if not flash user agent, send some html content
    amf_response = if request.env['CONTENT_TYPE'].to_s.match(/x-amf/) 
        headers['Content-Type'] = "application/x-amf"
        RailsGateway.new.service(request.raw_post) #send the raw data throught the rubyamf gateway and create the response
      else 
        headers['Content-Type'] = "text/html"
        welcome_screen_html # load in some stub html
      end

    # this is a fugly patch, but I'm not sure what the real problem is. Content-Type is set for gateway requests
    # and type is set for other requests.
    headers['Content-Type'] ||= headers['type']
            
    #render the AMF
    send_data(amf_response, {:type => headers['Content-Type'], :disposition => 'inline'})
  rescue Exception => e #only errors in this scope will ever be rescued here, see BatchFiler
    STDOUT.puts e.to_s
    STDOUT.puts e.backtrace
  end
  
  
  def rescue_action(e)
    #There are a couple things that will trigger this rescue_action. Which aren't
    #ever returned to the flash player. be ware. but I will put a fix for this in.
    puts "/rubyamf/gateway/render_action"
    puts e.message
    puts e.backtrace
  end
  
  
  def controllers
    @controllers = Array.new
    
    files = Dir.new("#{RAILS_ROOT}/app/controllers").entries
    files.each do |controller|
      if controller =~ /_controller/ 
        cont = {}
        cont[:name] = controller.camelize.gsub(".rb","")
        if cont[:name] != "ApplicationController" && cont[:name] != "RubyamfController"
          cont[:label] = cont[:name].gsub("Controller", "")
          cont[:methods] = Array.new

          (eval("#{ cont[:name] }.new.methods") - 
            ApplicationController.methods - 
            Object.methods -  
            ApplicationController.new.methods).sort.each {|met| 
              cont[:methods].push(met)
            }
            @controllers.push(cont)
        end
      end
    end
    render :amf => @controllers
  end
  
  def browser
    render :file => "#{RAILS_ROOT}/public/rubyamf/Index.html" 
  end
  
  private
  def welcome_screen_html
    "<html>
      <head>
        <title>RubyAMF Gateway</title>
        <style>body{margin:0;padding:0;font:12px sans-serif;color:#c8c8c8}td{font:12px sans-serif}</style>
      </head>
      <body bgcolor='#222222'>
      <table width='100%' align=center valign=middle height='100%'><tr><td width=100 align=center>
        <a href='http://blog.rubyamf.org'><img border=0 src='http://blog.rubyamf.org/images/gateway.png' /></a>"
  end
  
end