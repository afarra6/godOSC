@icon("res://addons/godOSC/images/OSCServer.svg")
class_name OSCServer
extends Node
## Server for recieving Open Sound Control messages over UDP. 


## The port over which to recieve messages
@export var port = 4646

## A dictionary containing all recieved messages.
var incoming_messages := {}

## The amount of OSC packets to parse per frame. Higher parse rates are more responsive
## but require more calculations per frame. The default rate should work for most use cases.
## A simple way to determine
## a reasonable parse rate would be to use the following equation:
## amount of recieved messages * average message rate / 60.
#@export var parse_rate = 10 deprecated
var server = UDPServer.new()
var peers: Array[PacketPeerUDP] = []

func _ready():
	server.listen(port)

## Sets the port for the server to listen on. Can only listen to one port at a time.
func listen(new_port):
	port = new_port
	server.listen(port)

func _process(_delta):
	server.poll()
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)
	
	parse()


## Parses an OSC packet. This is not intended to be called directly outside of the OSCServer
func parse():
	for peer in peers:
		for l in range(peer.get_available_packet_count()):
			var packet = peer.get_packet()
			parse_message(packet)

func parse_message(packet: PackedByteArray):
	var comma_index = packet.find(44)
	var address = packet.slice(0, comma_index).get_string_from_ascii()
	var args = packet.slice(comma_index, packet.size())
	var tags = args.get_string_from_ascii()
	var vals = []

	args = args.slice(ceili((tags.length() + 1) / 4.0) * 4, args.size())
	
	for tag in tags.to_ascii_buffer():
		match tag:
			44: #,: comma
				pass
			105: #i: int32
				var val = args.slice(0, 4)
				val.reverse()
				vals.append(val.decode_s32(0))
				args = args.slice(4, args.size())
			102: #f: float32
				var val = args.slice(0, 4)
				val.reverse()
				vals.append(val.decode_float(0))
				args = args.slice(4, args.size())
			115: #s: string
				var val = args.get_string_from_ascii()
				vals.append(val)
				args = args.slice(ceili((val.length() + 1) / 4.0) * 4, args.size())
			98:  #b: blob
				vals.append(args)
	
	incoming_messages[address] = vals
