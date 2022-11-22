require "socket"

module UdpTest
  VERSION = "0.1.0"

  class Server
    property server = UDPSocket.new

    def run(args)
      addr = (args[0]? || "").split(":")
      addr.delete("")
      @server.bind(addr[0]? || "localhost", (addr[1]? || 3000).to_i)
      puts "bound to #{addr[0]? || "localhost"}:#{(addr[1]? || "3000").to_i}"
      loop do
        message, client_addr = @server.receive
        puts "[#{client_addr}] #{message}"
      end
    end
  end

  class Client
    property client = UDPSocket.new

    def run(args)
      addr = (args[0]? || "").split(":")
      addr.delete("")
      @client.connect(addr[0]? || "localhost", (addr[1]? || "3000").to_i)
      loop do
        print "#{addr[0]? || "localhost"}:#{(addr[1]? || "3000").to_i}> "
        message = gets || ""
        @client.send(message.strip)
      end
    end
  end

end
