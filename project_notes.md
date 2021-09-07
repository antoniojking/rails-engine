# Project Notes

Error:
```
/Users/antonioking/.rbenv/versions/2.7.2/lib/ruby/2.7.0/json/version.rb:4: warning: already initialized constant JSON::VERSION
/Users/antonioking/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/json-2.5.1/lib/json/version.rb:4: warning: previous definition of VERSION was
 here
/Users/antonioking/.rbenv/versions/2.7.2/lib/ruby/2.7.0/json/version.rb:5: warning: already initialized constant JSON::VERSION_ARRAY
/Users/antonioking/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/json-2.5.1/lib/json/version.rb:5: warning: previous definition of VERSION_ARR
AY was here
```
Fixed by running:
```
bundle clean --force
bundle
bundle update
```
