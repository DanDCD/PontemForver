extends Node

export var disabled: bool = false

func displayMessage(message: String):
	if disabled:
		return
	print_debug("[MSG]: ", message)
	
	
func displayError(message: String):
	if disabled:
		return
	print("[ERROR]", message)
	
	
