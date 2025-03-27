#meta-name: OSCReceiver Default

extends OSCReceiver


## Code to be ran when Parent Control is set to custom.
func _custom_control(address : String, vals : Array, time):
	if vals != []:
		parent.position.x = vals[0]
	pass
