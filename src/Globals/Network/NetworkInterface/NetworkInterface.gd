extends Node
# avoids necessity for tree symettry between Host and Guest peers
# ALL rpcs are called through here


var peerID: int
var safeToProcess: bool = true setget setSafeToProcess
signal processSafetyChanged(isSafe) 
# UTILITY METHODS

func isServerHost()->bool:
	return(get_tree().get_rpc_sender_id()  == 0)

func setSafeToProcess(safety: bool):
	if safeToProcess == safety:
		return
	safeToProcess = safety
	if not safeToProcess:
		print("pause")
		get_tree().paused = true
	else:
		print("unpause")
		get_tree().paused = false
	emit_signal("processSafetyChanged", safeToProcess)


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
