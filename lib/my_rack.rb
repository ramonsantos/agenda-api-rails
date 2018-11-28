require 'rack'

app = proc do |env|
  ['200', { 'Content-Type' => 'text/html' }, [env.to_s]]
end

Rack::Handler::WEBrick.run(app, Port: 3000, Host: '0.0.0.0')