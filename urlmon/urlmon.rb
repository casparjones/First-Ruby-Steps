require 'monitor.class.rb'

urls = ['http://twitter.com', 'http://google.de']
mon = Monitor.new(urls)
mon.start();
