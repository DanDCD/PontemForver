extends Node
class_name FiniteStateMachine

var states = {}
var currentState = null
var componentOwner = null
signal OnNewState(newState, oldState)



# virtual

func stateProcess(delta):
	pass

func onNewState(newState, oldState):
	pass


func getTransition():
	pass

func setUpMachine():
	pass

# methods

func runProcess(delta):
	if currentState == null:
		return
		stateProcess(delta)
		var nextState = getTransition()
		if nextState:
			setState(nextState)
		
	
func addState(name: String):
	states[name] = states.size()

func setState(newState):
	if newState == currentState:
		return
	if newState in states:
		var oldState = currentState
		currentState = newState
		onNewState(currentState, oldState)
		emit_signal("OnNewState", currentState, oldState)


# must be called to start machine
func Boot():
	componentOwner = get_parent()
	setUpMachine()
