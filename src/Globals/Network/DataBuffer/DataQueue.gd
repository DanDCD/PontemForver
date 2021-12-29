extends Reference
class_name DataQueue


var data:Array = []
var indexToPop = 0





func addData(dataPack:DataPack):
	data.append(dataPack)
		

func popData():
	if data.size() <= indexToPop:
		return null
	indexToPop +=1
	return data[indexToPop-1]
