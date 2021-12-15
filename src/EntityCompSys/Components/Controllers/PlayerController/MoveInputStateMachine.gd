extends FiniteStateMachine


# do not confuse this with other movement logic - this is purely tracking input

func setUpMachine():
	addState("idle")
	addState("walk")
	addState("sprint")
	setState(states.idle)


func stateProcess(delta):
	pass

func onNewState(newState, oldState):
	if newState == states.idle:
		componentOwner.changeToIdle()
	elif newState == states.walk:
		componentOwner.changeTowalk()
	elif newState == states.sprint:
		componentOwner.changeToSprint()


func getTransition():
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		# if move input detected and sprinting:
		if Input.is_action_pressed("sprint"):
			return states.sprint
		# if move input detected, but not sprinting
		else:
			return states.walk
	# if no move input detected
	else:
		return states.idle 
		



