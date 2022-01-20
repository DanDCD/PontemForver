extends Processor


func processPack(dataPack: DataPack):
	if not isOpGlobal(dataPack):
		sendPackToLocalAdaptor(dataPack)
	else:
		processGlobalOpcode(dataPack)
		
	emitPackToGuests(dataPack)

func emitPackToGuests(dataPack: DataPack):
	for guest in ServerHost.guestDataContainer.get_children():
		NetworkInterface.sendToGuest(guest.peerID, dataPack, 1)
