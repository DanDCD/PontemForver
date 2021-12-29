extends NetworkAdaptor
class_name PlayerNetworkAdaptor


enum AdaptorOpCodes {
	SetBodyPosition= 0 #operands: id of body, value of position
}



# creates and sends a data pack containing position data to the host
func sendMovementBodyData(moveBody: MovementBodyComponent):
	var dataPack: DataPack = DataPackFactory.getNewPack(0, get_parent().entityId, get_parent().getComponentID(self))
	dataPack.addData(get_parent().getComponentID(moveBody))
	dataPack.addData(moveBody.position)
	NetworkInterface.sendToHostU(dataPack)
	
func loadMovementBodyData(data: Array):
	get_parent().getComponentByID(data[DataPack.operandBeginIndex]).position = data[DataPack.operandBeginIndex+1]
	
	
func recievePack(dataPack: DataPack):
	match dataPack.getData()[DataPack.OPCODE]:
		0: loadMovementBodyData(dataPack.getData())
	
	
		
