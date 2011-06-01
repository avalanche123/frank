# Frank #

Work in progress
A no nonsense dsl for making http requests in ruby

## Usage ##

### GET ###

``` ruby
require 'frank'

request = get '/' do
  host 'www.example.com'
  accept 'application/xml'
  user_agent 'Frank Demo'
end

puts request.to_s
```

results in:

```
GET / HTTP/1.1
Host: www.example.com
Accept: application/xml
User-Agent: Frank Demo
```

### POST ###

``` ruby
require 'frank'

request = post '/log-in' do
  host 'www.example.com'
  accept 'application/xml', 'application/xhtml+xml', h('text/html', :q => 0.9), h('text/plain', :q => 0.8), 'image/png', h('*/*', :q => 0.5)
  content_type 'application/x-www-form-urlencoded'
  user_agent 'Frank Demo'

  { :login => 'username', :password => 'password' }
end

puts request.to_s
```

results in:

```
POST /log-in HTTP/1.1
Host: www.example.com
Accept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Type: application/x-www-form-urlencoded
User-Agent: Frank Demo

login=username&password=password
```

Happy Coding!