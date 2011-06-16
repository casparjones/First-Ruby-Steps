#!/usr/bin/env ruby
require 'cgi'

params = cgi.params

cgi.out() do
	puts params
end
