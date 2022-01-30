extends Node
class_name HostEntityManager

var clients = []


func addClient(id: int):
	clients.append(id)
	
func removeClient(id: int):
	for x in range(clients.size()-1):
		if clients[x] == id:
			clients.remove(x)

# ADD TO ALL GAME CLIENTS AND SERVER
func addPlayerToWorld(controllerPeerID: int):
	var packForControllingClient: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.CRT_PLYR)
	var packForDummyClients: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.CRT_DMY_PLY)
	# sends instruction to controlling client
	NetworkInterface.sendToGuest(controllerPeerID, packForControllingClient)
	# sends instruction to non-controlling client to create dummy
	for client in clients:
		if client != controllerPeerID:
			NetworkInterface.sendToGuest(client, packForDummyClients)
	# create dummy in server
	EntityFactory.createPlayerDummy(true)

func addNPCtoWorld():
	pass

# ADD TO SINGLE GAME CLIENT

func createGameWorld(targetPeerID: int):
	var pack:DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.CRT_WRLD) # need add world data as operand
	NetworkInterface.sendToGuest(targetPeerID, pack)
