#!/usr/bin/env ruby -w

require 'socket'

ip_addr = `ifconfig en1`.match(/inet (\d*\.\d*\.\d*\.\d*)/)[1]


server = TCPServer.new(ip_addr, 8000)

while (session = server.accept)
	request = session.gets
	puts request
	session.print "HTTP/1.1 200/OK\rContent-type: text/html\r\n\r\n"
	session.print "<html><head><title>Response from Ruby Web server</title></head>\r\n"
	session.print "<body>request was:"
	session.print request
	session.print "</body></html>"

	if found = request.match(/%22(.*)%22/)
		puts found
		output = found.captures[0].gsub(/%20/,' ')
		puts output
		`say -v Daniel \"#{output}\"`
	end

	session.close
end