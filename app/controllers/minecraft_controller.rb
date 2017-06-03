class MinecraftController < ApplicationController
  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "Minecraft", '/minecraft'

    @server_info = Glowstone::Server.new("127.0.0.1",
                          :name => 'The Society', # you can put any arbitrary string here
                          :port => 2501,
                          :timeout => 5 # seconds before we give up on the socket connection
    )

  end
end
