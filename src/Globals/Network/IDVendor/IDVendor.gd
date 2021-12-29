extends Node

var validEntityIDs = []
var validComponentIDs = []


func getNewEntityID():
	
	if validEntityIDs.size() < 500:
		# request new entity ids from server host
		requestNewEntityIDs()
		
	return validEntityIDs.pop_back()



func getNewComponentID():
	if validComponentIDs.size() < 1000:
		 # request more component ids from host
		requestNewcomponentIDs()
	
	return validComponentIDs.pop_back()




func requestNewEntityIDs():
	var dataPack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.RQST_NEW_ENTIDS)
	NetworkInterface.sendToHost(dataPack, 0)
	
func requestNewcomponentIDs():
	var dataPack: DataPack = DataPackFactory.getNewPack(GlobalOpCodes.codes.RQST_NEW_CMPIDS)
	NetworkInterface.sendToHost(dataPack, 0)





func recieveNewEntityIDs(lowestID:int, highestID:int):
	for i in range(lowestID, highestID+1):
		validEntityIDs.append(i)

func recieveNewComponentIDs(lowestID:int, highestID:int):
	for i in range(lowestID, highestID+1):
		validComponentIDs.append(i)

