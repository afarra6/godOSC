@icon("res://addons/godOSC/images/OSCReceiver.svg")
class_name OSCReceiver
extends Node
## Generic node for Receiving OSC messages. Must have an active OSCServer in the scene to work. 
## Make this node the child of a node you want to control with OSC. To add your own code, extend the 
## script attached to the OSCReceiver you create by right clicking and "extend script"

## The OSCServer to receive messages from
@export var target_server : OSCServer

## The OSC address to receive
@export var osc_address := "/example"

## Get the parent of this node
@onready var parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# OSC messages are stored as a dictionary held in OSCServer variable incoming_messages, which uses a string for the
# key and an array to store the data. To access the data use the following format: 
# target_server.incoming_messages[osc_address][0]
func _process(delta):
	
	# IMPORTANT! You must check if the server has received a message on the correct address. The example below
	# checks if the server has received an OSC message at the address "/example" and then prints the first value
	# sent with the message.
#	if target_server.incoming_messages.has(osc_address):
#		print(target_server.incoming_messages[osc_address][0])
#
#		# This example changes the scale of a Node2D
#
#		#parent.scale = Vector2(1,1) * target_server.incoming_messages[osc_address][0]
#
#		# This example changes the scale of a Node3D
#
#		#parent.scale = Vector3(1,1,1) * target_server.incoming_messages[osc_address][0]
#
#
	pass
