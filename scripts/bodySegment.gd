extends RigidBody2D

@export var stick_force = 1500.0
@export var alignment_speed = 5.0

@onready var ray = $RayCast2D

func _ready():
	# Disable standard gravity so it doesn't fall off walls
	gravity_scale = 0.0
	# Set high friction to prevent sliding
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.friction = 1.0

func _integrate_forces(state):
	if ray.is_colliding():
		var normal = ray.get_collision_normal()
		
		# 1. Apply local gravity (pull toward wall)
		var force = -normal * stick_force
		state.apply_central_force(force)
		
		# 2. Align rotation to surface normal
		var target_rotation = normal.angle() + (PI / 2)
		var new_rotation = lerp_angle(rotation, target_rotation, alignment_speed * get_physics_process_delta_time())
		state.transform = Transform2D(new_rotation, state.transform.origin)

func move(direction_vector: Vector2, speed: float):
	if ray.is_colliding():
		apply_central_force(direction_vector * speed)
