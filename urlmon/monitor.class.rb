require 'net/http'
require 'digest/md5'
require 'pony.rb'

class Monitor
	
	def initialize(setUrls)
		@commander = Commander.new(self)
		@jobs = [];
		tag = 86400;
		
		setUrls.each { |url| 
			addUrl(url)
		}
		
		aStateCheck = Hash.new()
		aStateCheck["name"] = "SendStatusMail"
		@jobs.insert(0, Job.new(aStateCheck, tag));
		
		aCheckCommands = Hash.new()
		aCheckCommands["name"] = "checkCommands"
		@jobs.insert(0, Job.new(aCheckCommands, 10));
	end
	
	def addUrl(url)
		tag = 86400;
		
		aUrlParse = Hash.new()
		aUrlParse["name"] = "UrlParse"
		aUrlParse["url"] = url

		@jobs.insert(0, Job.new(aUrlParse, 5))
	end
	
	def start()
		while(true)
			execute()
			sleep(1)
		end
	end
	
	def execute()
		
		@jobs.each { |job| 
			if (job.isExecute?)
				case job.get("name")
					when "UrlParse": urlParse(job)
					when "SendStatusMail": 
							Pony.mail(:to => 'frank@vlatten.biz', :from => 'frank@vlatten.biz', :subject => 'Monitor Status', :body => 'läuft!')
					when "checkCommands":
							@commander.check()
				end
				
				job.restart()
			end
		}

	end
	
	def urlParse(job)
		html = Net::HTTP.get_response(URI.parse(job.get("url"))).body
		job.set('oldDigest', job.get('digest'));
		job.set('digest', Digest::MD5.hexdigest(html));
		
		oldDigest = job.get('oldDigest');
		digest = job.get('digest');
		
		puts oldDigest
    puts digest
		
		if (digest != oldDigest)
			if (oldDigest.nil?)
				puts "Die Seite " + job.get("url") + " wird jetzt überwacht."
			else
				ausgabe = "Die Seite " + job.get("url") + " hat sich geändert."
				Pony.mail(:to => 'frank@vlatten.biz', :from => 'frank@vlatten.biz', :subject => 'Monitor:' + ausgabe, :body => ausgabe)
			end
		else
			puts "Die Seite " + job.get("url") + " hat sich NICHT geändert."
		end
	end
	
	def showJobs
		@jobs.each { |job|
			job.description()
		}
	end
	
end

class Commander
	
	def initialize(mon)
		@mon = mon
		Dir.chdir("commands")
	end
	
	def check
		Dir.glob("*").each{ |file|
			case file
				when "showJobs": @mon.showJobs()
				when "addUrl":
					url = IO.read(file)
					@mon.addUrl(url.chop)
				when "exit": puts "exit Monitor"; File.unlink(file); exit(0)
			end
			File.unlink(file)
		}
	end
	
end

class Job
	
	def initialize(setParameter, resetSec)
		@executeTime = Time.now()
		@parameter   = setParameter
		@resetSec    = resetSec
	end
	
	def description()
		puts get("name") + "exec at " + @executeTime.asctime()
		if(@parameter.length() > 0)
			puts "Parameter: "
			@parameter.each {|key, value| puts "#{key} is #{value}" }
		end
	end
	
	def setExecuteTime(setExecuteTime)
		@executeTime = setExecuteTime
	end
	
	def isExecute?()
		if Time.now >= @executeTime
			true
		else
			false
		end
	end
	
	def restart()
		@executeTime = @executeTime + @resetSec
	end
	
	def get(pname)
		@parameter[pname]
	end
	
	def set(pname, pvalue)
	 @parameter[pname] = pvalue
	end
	
	
end