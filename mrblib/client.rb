#
# PlatoSim::Client class
#
# IP addresses
SENDADDR = '127.0.0.1'
RECVADDR = '0.0.0.0'
# ports
port_udp_c2s = 30001 # SimClient -> SimServer
port_udp_s2c = 30002 # SimServer -> SimClient

module PlatoSim
  class Client
    # attr_reader :snd, :rcv, :th, :que
    def initialize(sp, rp)
      @sport, @rport = sp, rp
      @snd = UDPSocket.new
      @snd.connect(SENDADDR, @sport)
      @rcv = UDPSocket.new
      @rcv.bind(RECVADDR, @rport)
    end

    def cmd(c, tmo=100)
      # discard remain data
      loop {
        begin
          @rcv.recvfrom_nonblock(65535)
        rescue
          break
        end
      }
      # send command
      puts c if $DEBUG
      @snd.puts c + "\n"
      # wait response
      t = Plato::Machine.millis + tmo
      rsp = ""
      loop {
        begin
          r = @rcv.recvfrom_nonblock(65535)
          rsp += r[0]
        rescue
          break if rsp.size > 0
        end
        break if Plato::Machine.millis >= t
        Plato::Machine.delay 1
      }
      rsp.lines[-1].chomp
    end
  end
end

$sim = PlatoSim::Client.new(port_udp_c2s, port_udp_s2c)
