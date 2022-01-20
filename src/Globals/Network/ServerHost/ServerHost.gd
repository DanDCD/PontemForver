extends Node

# MEMBERS

const SERVER_PORT: int = 8450
var maxPlayers: int = 40;

onready var guestDataContainer = $GuestDataContainer
onready var IDManager: IdManager = $IDManager


# METHODS

func setUpServer():
	NetworkInterface.setSafeToProcess(false)
	
	ServerGuest.queue_free()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, maxPlayers)
	get_tree().network_peer = peer
	NetworkInterface.peerID = get_tree().get_rpc_sender_id()
	
	
	IdVendor.requestNewEntityIDs()
	IdVendor.requestNewcomponentIDs()
	DataBuffer.processor = ResourceManager.HOSTPROCESSOR.instance()
	DataBuffer.disabled = false
	
	print("Host Set Up")

# guest details saved when a new peer connects to the server
func saveGuestDetails(peerId: int, userName: String):
	guestDataContainer.addGuest(peerId, userName)
	print(userName)

func sendBatchCompIDs(peerRecipient: int):
	var dataPack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.GRNT_NEW_CMPIDS)
	dataPack.addData(IDManager.currentCompID+1)
	dataPack.addData(IDManager.currentCompID+1000)
	IDManager.currentCompID+=1000
	NetworkInterface.sendToGuest(peerRecipient, dataPack)
	
func sendBatchEntIDs(peerRecipient: int):
	var dataPack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.GRNT_NEW_ENTIDS)
	dataPack.addData(IDManager.currentEntID+1)
	dataPack.addData(IDManager.currentEntID+500)
	IDManager.currentEntID+=500
	NetworkInterface.sendToGuest(peerRecipient, dataPack)

	
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
