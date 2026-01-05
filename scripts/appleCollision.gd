extends Area2D

func _ready() -> void:
	$"../AnimationPlayer".play("apple")

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("isPlayer"):
		if body.get_parent().name == "Wheels":
			body.get_parent().get_parent().get_parent().phaseUp()
		else:
			body.get_parent().get_parent().phaseUp()
		get_parent().queue_free()
	
