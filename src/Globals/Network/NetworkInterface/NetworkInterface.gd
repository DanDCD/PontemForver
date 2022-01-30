extends Node
# avoids necessity for tree symettry between Host and Guest peers
# ALL rpcs are called through here

# network id of peer that owns this client/server
var peerID: int
# all these flags must be true for the network to begin processing packets
var safeToProcessFlags = {
	
	"enoughIDs": false,
	"gameWorldReady": false
	
	
}
# emits when a flag gets changed - returns true if all flags are true
signal processSafetyChanged(isSafe) # note: if i client becomes unsafe we disconnect and reconnect



# UTILITY METHODS

func hookUpSafetyDependencies():
	pass


func isServerHost()->bool:
	return(get_tree().get_rpc_sender_id()  == 0)

# allows process flag to be changed - emits safety after
func setSafeToProcessFlag(flagName: String, safety: bool):
	if not safeToProcessFlags.has(flagName):
		return
	if safeToProcessFlags[flagName] == safety:
		return
	safeToProcessFlags[flagName] = safety
	
	var newSafety = checkSafeToProcess()
	emit_signal("processSafetyChanged", newSafety)
	if isServerHost():
		get_tree().paused = not newSafety
		
	

# returns true if all safety flags are true, otherwise false
func checkSafeToProcess()->bool:
	for key in safeToProcessFlags:
		if safeToProcessFlags[key]  == false:
			return false
	return true

# ADMIN METHODS


# called by Host to request network details from guest peer
func requestGuestDetails(peerID: int)->void:
	if not(isServerHost()):
		return
		
	rpc_id(peerID, "grantGuestDetails")

# called by guest peer to hand details to host
remote func grantGuestDetails()->void:
	if(isServerHost()):
		return
	rpc_id(1, "recieveGuestDetails", ServerGuest.userName)
	
# triggered within host to add guest details to list
remote func recieveGuestDetails(userName: String)->void:
	ServerHost.saveGuestDetails(get_tree().get_rpc_sender_id(), userName)


# called by clients to send data to host
func sendToHost(dataPack: DataPack, priority: int = 0):
	rpc_id(1, "pushToDataBuffer", dataPack, priority)

func sendToHostU(dataPack: DataPack, priority: int = 0):
	rpc_unreliable_id(1, "pushToDataBuffer", dataPack, priority)



# called by host to send data to guests
func sendToGuest(peerID:int,dataPack: DataPack, priority: int = 0):
	if not isServerHost():
		return
	rpc_id(peerID, "pushToDataBuffer", dataPack, priority)

func sendToGuestU(peerID: int,dataPack: DataPack, priority: int = 0):
	if not isServerHost():
		return
	rpc_unreliable_id(peerID, "pushToDataBuffer", dataPack, priority)


# pushes json data onto a buffer in the server host
remote func pushToDataBuffer(dataPack: DataPack, priority: int = 1):
	DataBuffer.addToBuffer(dataPack, priority)
