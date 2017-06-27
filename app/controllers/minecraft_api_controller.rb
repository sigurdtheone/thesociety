class MinecraftApiController < ActionController::API
  def show
    begin

      @server_info = Glowstone::Server.new('gm.cph.nodescloud.com',
                            :name => 'Nodes', # you can put any arbitrary string here
                            :port => 2500,
                            :timeout => 5 # seconds before we give up on the socket connection
      )

      @server_info.players.each do |player|
        @players = "#{@players}" + "#{player}\n"
      end

      payload ={
          'channel' => 'testest',
          #'user_name' => "#{params[:user_name]}",
          'attachments' => [
              'color' => 'good',
              'title' => "#{@server_info.name} - #{@server_info.motd}",
              'text' => "*Address*: #{@server_info.host}:#{@server_info.port}\n *Version*: #{@server_info.version}\n *Players*: #{@server_info.num_players}/#{@server_info.max_players}\n *Online*: #{@players}",
          ]
      }.to_json

      uri = URI.parse("#{params[:response_url]}")
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.body = payload
      res = https.request(req)

      if @res.kind_of? Net::HTTPSuccess
      else
        return_error(res)
      end
      
    rescue Exception
    else
    end
  end
end
