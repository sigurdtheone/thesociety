class MinecraftApiController < ActionController::API
  def show
    begin

      @server_info = Glowstone::Server.new("gm.cph.nodescloud.com",
                            :name => 'Nodes', # you can put any arbitrary string here
                            :port => 2500,
                            :timeout => 5 # seconds before we give up on the socket connection
      )

      @server_info.players.each do |player|
        @players = "#{@players}" + "#{player}\n"
      end
      
      response ={
          'text' => '',
          'attachments' => [
              'color' => 'good',
              'text' => "*Server*: #{@server_info.name} - #{@server_info.motd}\n*Address*: #{@server_info.host}:#{@server_info.port}\n *Version*: #{@server_info.version}\n *Players*: #{@server_info.num_players}/#{@server_info.max_players}\n *Online*: #{@players}",
          ]
      }

      render json: response
      
    rescue Exception
    else
    end
  end
end
