# GodOSC
Implementation of the Open Sound Control protocol in Godot using GDScript and a group of nodes for convenient use. GodOSC receives and sends OSC messages over UDP. Currently supports OSC messages (now with experimental bundle support), booleans (thanks to NovMot) floats, integers, strings, and blobs.


# OSCServer
The OSCServer sets up a UDPServer to receive and parse OSC messages. These messages are stored in a Dictionary with the following convention:

{
"/example/address", [value1, value2, value]
}

Alternatively, OSCServer emits a signal when a new message is received which includes the Address, Value, and a Time stamp.


# OSCClient
The OSCClient is used to send OSC messages to an OSC server, either in Godot or an outside program. OSCClients can only send to one server at a time but are able to send multiple messages to multiple addresses. Essentially you should have a 1:1 client-to-server ratio.


# OSCReceiver
A convenience node for controlling nodes with OSC messages. Attach an OSCReceiver to a node you'd like to manipulate and then *extend* the script on the OSCReceiver.
You can then manipulate the parent's properties.

IMPORTANT: You must check if the OSCServer has received a message on the address the OSCReciever is listening on. Here is some example code

if target_server.incoming_messages.has(osc_address):
>Do something with the incoming data


# OSCMessage
A convenience node for creating an OSC message. This can be placed anywhere within your scene but an OSCClient must be present to work. Again, make sure to *extend* the script on the OSC message to add your own code.

Use the method send_message(value) where the value can be either an array or a discrete value to send a message using the OSCMessage node.



# Demo Projects

Below are links to demo projects using common electronic music software:

* Supercollider - https://github.com/afarra6/sc-osc-demo
* Max 8 - https://github.com/afarra6/max-osc-demo
