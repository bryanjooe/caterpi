extends "res://scripts/bodySegment.gd" # Inherits the segment logic

@export var move_speed = 2000.0
var body_segments = []



func _ready():
	super._ready()
	# Find all siblings that are also segments
	for child in get_parent().get_children():
		if child is RigidBody2D:
			body_segments.append(child)

func _physics_process(_delta):
	var input_dir = Input.get_axis("ui_left", "ui_right")
	
	if input_dir != 0 and get_parent().get_parent().getPhase() == "worm":	
		# Calculate the forward direction based on the Head's current rotation
		var forward = transform.x * input_dir
		
		# Tell every segment to move in that direction
		for segment in body_segments:
			if segment.has_method("move"):
				segment.move(forward, move_speed)
