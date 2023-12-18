@icon("res://addons/godOSC/images/OSCClient.svg")
class_name OSCClient
extends Node
## Client for sending Open Sound Control messages over UDP. Use one OSCClient per server you want to send to.

## The IP Address of the server to send to.
@export var ip_address = "127.0.0.1"
## The port to send to.
@export var port = 4646
var client = PacketPeerUDP.new()


func _ready():
	connect_socket(ip_address, port)


## Connect to an OSC server. Can only send to one OSC server at a time.
func connect_socket(new_ip = "127.0.0.1", new_port = 4646):
	client.set_dest_address(new_ip, new_port)
	print(client.is_socket_connected())


## Send an OSC message over UDP.
func send_message(osc_address : String, args : Array):
	var packet = PackedByteArray()
	var args_array = PackedByteArray()
	
	packet.append_array(osc_address.to_ascii_buffer())
	packet.append_array([0])
	
	while fmod(packet.size(), 4):
		packet.append(0) 
	
	
	packet.append(44)
	
	for i in range(len(args)):
		var to_append = PackedByteArray([0,0,0,0])
		
		match typeof(args[i]):
			TYPE_INT:
				packet.append(105)
				to_append.encode_s32(0, args[i])
				to_append.reverse()
				args_array.append_array(to_append)
			TYPE_FLOAT:
				packet.append(102)
				to_append.encode_float(0, args[i])
				to_append.reverse()
				args_array.append_array(to_append)
	
	if fmod(packet.size(), 4) == 0:
		packet.append_array([0,0,0,0])
	while fmod(packet.size(), 4):
		packet.append(0) 
	
	packet.append_array(args_array)
	client.put_packet(packet)


