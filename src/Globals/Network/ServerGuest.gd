extends Node

var serverIP: String = "127.0.0.1"
var port: int = 2052
var userName:String = "Dan"

func setUpGuest():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(serverIP, port)
	get_tree().network_peer = peer
	ServerHost.queue_free()
	print("Guest Set Up")


func _ready():
	pass

