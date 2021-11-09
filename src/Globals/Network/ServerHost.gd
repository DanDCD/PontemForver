extends Node

# MEMBERS

const SERVER_PORT: int = 2052
var maxPlayers: int = 40;

onready var guestDataContainer = $GuestDataContainer

# METHODS

func setUpServer():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, maxPlayers)
	get_tree().network_peer = peer
	ServerGuest.queue_free()
	print("Host Set Up")
	
func saveGuestDetails(id: int, userName: String):
	guestDataContainer.addGuest(id, userName)
	print(userName)
	
	
# SIGNALS
func networkPeerConnected(id: int):
	print("new connection")
	NetworkInterface.requestGuestDetails(id)





func _ready():
	get_tree().connect("network_peer_connected",self, "networkPeerConnected")
