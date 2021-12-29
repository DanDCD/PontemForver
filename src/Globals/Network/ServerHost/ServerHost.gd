extends Node

# MEMBERS

const SERVER_PORT: int = 8450
var maxPlayers: int = 40;

onready var guestDataContainer = $GuestDataContainer



# METHODS

func setUpServer():
	ServerGuest.queue_free()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, maxPlayers)
	get_tree().network_peer = peer
	DataBuffer.processor = ResourceManager.HOSTPROCESSOR.instance()
	DataBuffer.disabled = false
	NetworkInterface.peerID = get_tree().get_rpc_sender_id()
	print("Host Set Up")

# guest details saved when a new peer connects to the server
func saveGuestDetails(peerId: int, userName: String):
	guestDataContainer.addGuest(peerId, userName)
	print(userName)
	
	
# SIGNALS
func networkPeerConnected(id: int):
	print("new connection, id: ",id)
	NetworkInterface.requestGuestDetails(id)

func networkPeerDisconnected(id: int):
	print("disconnection, id", id)
	guestDataContainer.removeGuest(id)



func _ready():
	get_tree().connect("network_peer_connected",self, "networkPeerConnected")
	get_tree().connect("network_peer_disconnected", self,"networkPeerDisconnected")
