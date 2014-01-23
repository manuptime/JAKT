use Rack::Static, :urls => { "/" => "index.html", "/test" => "test.html" }, :root => "client"
run Rack::Directory.new("client")
