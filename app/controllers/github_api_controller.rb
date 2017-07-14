class GithubApiController < ActionController::API

  def return_error(res)
    puts  "Something went wrong, API returned error: #{res.code} - #{res.body}"
  end

  def show     
      channel = "github-updates"

      sender = JSON.parse(params[:sender].to_json)

      if request.method == "POST"
        action = request.request_parameters['action']
      else
        action = request.query_parameters['action']
      end

      repo_name = JSON.parse(params[:repository].to_json)

      organization = JSON.parse(params[:organization].to_json)

      payload ={
	  'response_type': 'in_channel',
          'channel_id' => "#{channel}",
          'text' => "#{sender["login"]} #{action} #{repo_name["name"]} in #{organization["login"]}"
      }.to_json

      uri = URI.parse("https://hooks.slack.com/services/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")
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.body = payload
      res = https.request(req)

      if res.kind_of? Net::HTTPSuccess
	render status: 200, html: res
      else
	render status: 500, html: res
      end
  end
end
