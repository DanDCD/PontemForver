extends Node

# "54.38.78.115" main server
#  "127.0. 0.1" loopback


var serverIP: String = "127.0. 0.1"
var port: int = 8450
var userName:String = "Dan"

func setUpGuest():
	NetworkInterface.setSafeToProcess(false)
	
	ServerHost.queue_free()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(serverIP, port)
	get_tree().network_peer = peer
	NetworkInterface.peerID = get_tree().get_rpc_sender_id()
	
	
	IdVendor.requestNewEntityIDs()
	IdVendor.requestNewcomponentIDs()
	DataBuffer.processor = ResourceManager.GUESTPROCESSOR.instance()
	DataBuffer.disabled = false
	
	
	print("Guest Set Up")


func getPeerID():
	return get_tree().get_network_unique_id()

func _ready():
	pass

