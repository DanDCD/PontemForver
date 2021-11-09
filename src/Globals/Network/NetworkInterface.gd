extends Node
# avoids necessity for tree symettry between Host and Guest peers
# ALL rpcs are called through here

# UTILITY METHODS

func isServerHost()->bool:
	return(get_tree().get_rpc_sender_id()  == 1)




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
	
remote func recieveGuestDetails(userName: String)->void:
	ServerHost.saveGuestDetails(get_tree().get_rpc_sender_id(), userName)
