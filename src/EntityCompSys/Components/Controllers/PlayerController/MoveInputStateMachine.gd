extends FiniteStateMachine


# do not confuse this with other movement logic - this is purely tracking input

func setUpMachine():
	print("setting up")
	addState("idle")
	addState("walk")
	addState("sprint")
	setState(states.idle)


func stateProcess(delta):
	pass

func onNewState(newState, oldState):
	if newState == states.idle:
		print("switch to idle")
		get_parent().changeToIdle()
	elif newState == states.walk:
		print("switch to walk")
		get_parent().changeToWalk()
	elif newState == states.sprint:
		print("switch to run")
		get_parent().changeToSprint()


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
		



