extends Node

# MEMBERS

const SERVER_PORT: int = 8450
var maxPlayers: int = 40;
onready var guestDataContainer: GuestDataContainer = $GuestDataContainer
onready var IDManager: IdManager = $IDManager
onready var hostEntityManager: HostEntityManager = $HostEntityManager

# METHODS
func setUpServer():
	ServerGuest.queue_free()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, maxPlayers)
	get_tree().network_peer = peer
	NetworkInterface.peerID = get_tree().get_rpc_sender_id()
	IdVendor.requestNewEntityIDs()
	IdVendor.requestNewcomponentIDs()
	createNewGameWorld()
	DataBuffer.processor = ResourceManager.HOSTPROCESSOR.instance()
	
	

# guest details saved when a new peer connects to the server
func saveGuestDetails(peerId: int, userName: String):
	guestDataContainer.addGuest(peerId, userName)
	print(userName)
	hostEntityManager.createGameWorld(peerId) # loads world for new client
	hostEntityManager.addPlayerToWorld(peerId) # adds player to all clients
	

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

func createNewGameWorld():
	SceneManager.setWorld(ResourceManager.TESTINGWORLD.instance())


func toggleConnections(refuse:bool):
	if refuse == get_tree().refuse_new_network_connections:
		return
	get_tree().refuse_new_network_connections = refuse
	if refuse:
		disconnectPeer()
	
		

# disconnects peer - if -1, disconnects all peers
func disconnectPeer(id: int = -1):
	var Pack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.DSC_FRM_SRVR)
	if id == -1:
		for guest in guestDataContainer.get_children():
			NetworkInterface.sendToGuest(guest.peerID, Pack)
	else:
		NetworkInterface.sendToGuest(id, Pack)
	
	
# SIGNALS
func networkPeerConnected(id: int):
	print("new connection, id: ",id)
	NetworkInterface.requestGuestDetails(id)

func networkPeerDisconnected(id: int):
	print("disconnection, id", id)
	guestDataContainer.removeGuest(id)

func processSafetyChanged(newSafety: bool):
	toggleConnections(not newSafety)
		
	



func _ready():
	NetworkInterface.connect("processSafetyChanged", self,"processSafetyChanged")
	guestDataContainer.connect("GuestAdded", hostEntityManager, "addClient")
	guestDataContainer.connect("GuestLeft", hostEntityManager, "removeClient")
	get_tree().connect("network_peer_connected",self, "networkPeerConnected")
	get_tree().connect("network_peer_disconnected", self,"networkPeerDisconnected")
