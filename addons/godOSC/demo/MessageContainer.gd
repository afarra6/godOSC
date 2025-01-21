extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Signal sent from OSCServer that sends the Address, Value, and System Time
func _on_osc_server_message_received(address, value, time):
	$Add1.text = address
	$Val1.text = str(value)
	$Time1.text = str(time)
	pass # Replace with function body.
