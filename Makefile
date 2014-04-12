console:
	bundle exec rails c

server:
	torquebox run -b 0.0.0.0

spec:
	bundle exec rake db:test:prepare
	bundle exec rspec

.PHONY: spec
