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
@export var parse_rate = 10
var server = UDPServer.new()
var peers = []


func _ready():
	server.listen(port)


func listen(new_port):
	if new_port == port:
		server.listen(port)
	else:
		server.listen(new_port)
	


func _process(_delta):
	server.poll() 
	
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		print("Received data: %s" % [packet.get_string_from_utf8()])
		print(packet)
		# Reply so it knows we received the message.
		peer.put_packet(packet)
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)
	
	parse()


func parse():
	for i in range(0, peers.size()):
		var packet = peers[i].get_packet()
		
		for l in range(parse_rate - 1):
			var new_pack = peers[i].get_packet()
			parse_message(new_pack)
		
		var address = packet.get_string_from_ascii()
		var comma = packet.find(44)
		var flags = []
		var args = (packet.slice(comma, packet.size()).size()/4.0) - 1
		var vals = []
		
		for j in packet.slice(comma+1, comma + 1 + args):
			flags.append(j)
		
		packet.reverse()
		flags.reverse()
		
		for j in range(len(flags)):
			match flags[j]:
				105:
					vals.append(packet.decode_s32(j*4))
				102:
					vals.append(packet.decode_float(j*4))
		
		vals.reverse()
		if len(vals) > 0:
			incoming_messages[address] = vals



func parse_message(packet):
	var address = packet.get_string_from_ascii()
	var comma = packet.find(44)
	var flags = []
	var args = (packet.slice(comma, packet.size()).size()/4.0) - 1
	
	var vals = []
	for j in packet.slice(comma+1, comma + 1 + args):
		flags.append(j)
	
	packet.reverse()
	flags.reverse()
	
	for j in range(len(flags)):
		match flags[j]:
			105:
				vals.append(packet.decode_s32(j*4))
			102:
				vals.append(packet.decode_float(j*4))
	
	vals.reverse()
	if len(vals) > 0:
		incoming_messages[address] = vals

