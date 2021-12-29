extends Reference
class_name DataPack




# 0: peerID+PacketID, 1:AdaptorOwnerID,2:adaptorTarget,  3:Opcode, 4-...:Operands
var data :Array =[]
const PACKID: int = 0
const ADAPTOROWNERID: int = 1 # entity owner id of adaptor
const ADAPTORTARGETID: int = 2 # id of actual adaptor
const OPCODE: int = 3 # operation code
const PEERID: int = 4
const operandBeginIndex: int = 5 # any operands begin at index 4

# if adaptorTarget or owner is -1, then the packet is is not targetting an adaptor
func _init(packID: int, adaptorOwnerID: int,adaptorTarget: int, opcode: int, peerID: int):
	data.append(packID)
	data.append(adaptorOwnerID)
	data.append(adaptorTarget)
	data.append(opcode)
	data.append(peerID)
		
func addData(Idata):
	data.append(Idata)


func getData():
	return data
