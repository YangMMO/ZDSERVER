require 'readline'

def help
	puts "你可以输入以下命令:#{LIST}"
end

def history
	puts Readline::HISTORY.to_a[-2]
end

trap('INT', 'SIG_IGN')


LIST = [
  'help', 'history', 'exit' ,'Log','Container::Box','Container::Box.put','Container::Box.get','Container::Box.box',
  'DataBase._redis_'
].sort

comp = proc { |s| LIST.grep( /^#{Regexp.escape(s)}/ ) }

Readline.completion_append_character = " "
Readline.completion_proc = comp

CONSOLE = Thread.new do 
	cb = {}
	loop do 
        begin
			input = Readline.readline('> ', true).chomp
			ret = eval input
			puts ret if ret!=nil
		rescue => exception
			puts exception.message
			puts exception.backtrace.join("\n")
		rescue SyntaxError => e
			puts e
		end
	end
end

