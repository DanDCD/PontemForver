extends Node







const HOSTPROCESSOR = preload("res://src/Globals/Network/DataBuffer/HostProcessor.tscn")
const GUESTPROCESSOR = preload("res://src/Globals/Network/DataBuffer/GuestProcessor.tscn")




const COMPONENTIDTAG = preload("res://src/EntityCompSys/ComponentIDTag/ComponentIDTag.tscn")
const POSITIONGLUER = preload("res://src/EntityCompSys/Components/Kinematics/PositionGluer/PositionGluer.tscn")
const PLAYERCONTROLLER = preload("res://src/EntityCompSys/Components/Controllers/PlayerController/PlayerController.tscn")



const MOVEMENTBEHAVIOUR = preload("res://src/EntityCompSys/Components/Behaviours/MovementBehaviours/MovementBehaviour/MovementBehaviour.tscn")
const WALKMOVEMENTBEHAVIOUR = preload("res://src/EntityCompSys/Components/Behaviours/MovementBehaviours/WalkMovementBehaviour/WalkMovementBehaviour.tscn")
const RUNMOVEMENTBEHAVIOUR = preload("res://src/EntityCompSys/Components/Behaviours/MovementBehaviours/RunMovementBehaviour/RunMovementBehaviour.tscn")
const IDLEMOVEBEHAVIOUR = preload("res://src/EntityCompSys/Components/Behaviours/MovementBehaviours/IdleMovementBehaviour/IdleMovementBehaviour.tscn")


const PLAYER = preload("res://src/EntityCompSys/GameObject/PlayerDemo/Player.tscn")



const TESTINGWORLD = preload("res://src/Worlds/TestingWorld/TestingWorld.tscn")
