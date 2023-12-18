@icon("res://addons/godOSC/images/OSCMessage.svg")
class_name OSCMessage
extends Node
## Convenience class for organizing an OSC message. Used with an OSCClient. To add your own code, extend the script attached to the OSCReceiver you create by right clicking and "extend script"

## The client to send the OSC message with
@export var target_client : OSCClient

## The OSC address to send to
@export var osc_address := "/example"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Sends 0 to the target OSC address
	target_client.send_message(osc_address, [0])
	pass
