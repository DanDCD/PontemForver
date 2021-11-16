extends Node



func displayMessage(message: String):
	outToScreen("[MSG]: ", message)
	
	
func displayError(message: String):
	outToScreen("[ERROR]", message)
	
	
func outToScreen(category:String, message:String):
	print(category+message)
