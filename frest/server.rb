module Frest
  module Server
    def self.start
      require 'rack'
      require 'json'

      require_relative 'settings'

      app = Proc.new do |env|
        req = Rack::Request.new(env)
        sql = <<~SQL
          SELECT request(
            $1::json
          )
        SQL
        result = Frest::database.exec_params(
          sql, [{
            meth:     req.request_method,
            path:     req.path,
            headers:  env['HTTP_Variables'],
            params:   req.params,
            body:     req.body.read,
            session:  req.session,
            cookies:  req.cookies
          }.to_json],
        )
        result = result.first['request']
        
        results = JSON.parse(result).first['request']
        [results['status'], results['headers'], results['body']]
      end

      Rack::Handler::WEBrick.run app
    end
  end
end
