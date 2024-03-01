extends Node3D

class_name PlayerCamera

@export var input : PlayerInput
@onready var cam_x : Node3D = $CamX

const lookLim = PI/2.1

func _process(delta : float) -> void:
	rotate_y(input.look.x)
	cam_x.rotation.x = clamp(cam_x.rotation.x + input.look.y,-lookLim,lookLim)

