extends Node


var highPriorityQueue:DataQueue = DataQueue.new()
var mediumPriorityQueue: DataQueue = DataQueue.new()
var lowPriorityQueue:DataQueue = DataQueue.new()
var buffers: Array = [lowPriorityQueue, mediumPriorityQueue, highPriorityQueue]
var disabled: bool = true
var processor: Processor = null


func addToBuffer(dataPack: DataPack, priority):
	buffers[priority].addData(dataPack)
	print("recievedPack")
	

func processQueue(dataQueue: DataQueue):
	if dataQueue.data.size() == 0:
		return
	
	# logic to interpret datapack
	var data:DataPack = dataQueue.popData()
	
func processBuffer():
	processQueue(mediumPriorityQueue)
	



func _physics_process(delta):
	if not disabled:
		processBuffer()
