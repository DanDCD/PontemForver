extends Node

var validEntityIDs = []
var validComponentIDs = []


func getNewEntityID():
	
	if validEntityIDs.size() < 500:
		# request new entity ids from server host
		requestNewEntityIDs()
	checkIDsSufficient()
	return validEntityIDs.pop_back()



func getNewComponentID():
	
	if validComponentIDs.size() < 1000:
		 # request more component ids from host
		requestNewcomponentIDs()
	checkIDsSufficient()
	return validComponentIDs.pop_back()



func checkIDsSufficient():
	NetworkInterface.setSafeToProcess(validEntityIDs.size() >= 500 && validComponentIDs.size() >= 1000)
		


func requestNewEntityIDs():
	if NetworkInterface.isServerHost():
		recieveNewEntityIDs(ServerHost.IDManager.currentEntID+1, ServerHost.IDManager.currentEntID+500)
		ServerHost.IDManager.currentEntID+=500
		return
	var dataPack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.RQST_NEW_ENTIDS)
	NetworkInterface.sendToHost(dataPack, 0)
	
func requestNewcomponentIDs():
	if NetworkInterface.isServerHost():
		recieveNewComponentIDs(ServerHost.IDManager.currentCompID+1, ServerHost.IDManager.currentCompID+1000)
		ServerHost.IDManager.currentCompID+=1000
		return
	var dataPack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.RQST_NEW_CMPIDS)
	NetworkInterface.sendToHost(dataPack, 0)

func recieveNewEntityIDs(lowestID:int, highestID:int):
	for i in range(lowestID, highestID+1):
		validEntityIDs.append(i)
	checkIDsSufficient()

func recieveNewComponentIDs(lowestID:int, highestID:int):
	for i in range(lowestID, highestID+1):
		validComponentIDs.append(i)
	checkIDsSufficient()

