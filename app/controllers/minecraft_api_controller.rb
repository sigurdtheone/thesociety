class MinecraftApiController < ActionController::API
  def show
    begin
      @server_info = Glowstone::Server.new("gm.cph.nodescloud.com",
                            :name => 'Nodes', # you can put any arbitrary string here
                            :port => 2500,
                            :timeout => 5 # seconds before we give up on the socket connection
      )
      
      render json: @server_info
      
    rescue Exception
    else
    end

  end
end
