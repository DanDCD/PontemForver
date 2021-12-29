extends Node

var serverIP: String = "54.38.78.115"
var port: int = 8450
var userName:String = "Dan"

func setUpGuest():
	ServerHost.queue_free()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(serverIP, port)
	get_tree().network_peer = peer
	DataBuffer.processor = ResourceManager.GUESTPROCESSOR.instance()
	DataBuffer.disabled = false
	NetworkInterface.peerID = get_tree().get_rpc_sender_id()
	print("Guest Set Up")


func getPeerID():
	return get_tree().get_network_unique_id()

func _ready():
	pass

