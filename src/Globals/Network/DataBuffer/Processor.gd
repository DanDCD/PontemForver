extends Node
class_name Processor

## VIRTUALS

func processPack(dataPack: DataPack):
	pass


## METHODS

# send the dataPack to its accossiated adaptor
#if dataPack.getData()[DataPack.ADAPTOROWNERID] != -1:
func sendPackToLocalAdaptor(dataPack:DataPack):
	var entity: Entity = EntityFactory.getEntity(DataPack.ADAPTOROWNERID)
	var adaptor: NetworkAdaptor = entity.getComponentByID(DataPack.ADAPTORTARGETID)
	adaptor.recievePack(dataPack)


# returns true if the pack has no target adaptor
func isOpGlobal(dataPack: DataPack)->bool:
	return dataPack.getData()[DataPack.ADAPTOROWNERID] == -1


# processes the logic for non-adaptor opcodes
func processGlobalOpcode(dataPack: DataPack):
	match dataPack.getData()[DataPack.OPCODE]:
		
		GlobalOpCodes.codes.GRNT_NEW_CMPIDS:
			# grant new component ids
			IdVendor.recieveNewComponentIDs(dataPack.getData()[DataPack.operandBeginIndex], 
				dataPack.getData()[DataPack.operandBeginIndex+1])
				
		GlobalOpCodes.codes.GRNT_NEW_ENTIDS:
			# grant new entity ids
			IdVendor.recieveNewEntityIDs(dataPack.getData()[DataPack.operandBeginIndex], 
				dataPack.getData()[DataPack.operandBeginIndex+1])
				
		GlobalOpCodes.codes.RQST_NEW_CMPIDS:
			#asks server to provide more comp ids
			if not NetworkInterface.isServerHost():
				return
			ServerHost.sendBatchCompIDs(dataPack.getData()[DataPack.PEERID])
			
		GlobalOpCodes.codes.RQST_NEW_ENTIDS:
			#asks server to provide more ent ids
			if not NetworkInterface.isServerHost():
				return
			ServerHost.sendBatchEntIDs(dataPack.getData()[DataPack.PEERID])
		
		GlobalOpCodes.codes.CRT_DMY_PLY:
			pass
