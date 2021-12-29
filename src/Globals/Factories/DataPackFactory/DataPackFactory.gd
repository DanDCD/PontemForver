extends Node

var packID: int = 0


func getNewPack(opcode: int, adaptorOwnerID: int = -1, adaptorTargetID: int= -1)->DataPack:
	var pack: DataPack = DataPack.new(packID,
	adaptorOwnerID, adaptorTargetID, opcode, NetworkInterface.peerID)
	packID += 1
	return pack
