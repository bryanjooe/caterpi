extends Node2D

@onready var wheels = $Worm/Wheels
var wheelNode = []
var lowestPoint = Vector2()

var phase = 0
var phaseOrder = ["worm","pupa","butterfly"]

func _ready() -> void:
	$Pupa/RigidBody2D.process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	wheelNode = wheels.get_children()
	lowestPoint.y = 0
	for wheel in wheelNode:
		if wheel.global_position.y + 14 > lowestPoint.y:
			lowestPoint.y = wheel.global_position.y + 14

func getPhase():
	return phaseOrder[phase]


func phaseUp(newPhase = false):
	if not newPhase:
		phase += 1
	if  getPhase() == "pupa":
		
		$Pupa/RigidBody2D.global_position = $Worm/Head.global_position
		$Worm.visible = false
		$Worm.process_mode = Node.PROCESS_MODE_DISABLED
		$Pupa/RigidBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
		$Pupa/RigidBody2D.linear_velocity = $Worm/Head.linear_velocity
		$Pupa.visible = true
