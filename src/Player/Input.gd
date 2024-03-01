extends Node

class_name PlayerInput

var FBRL : Vector2 = Vector2()
var mLook : Vector2 = Vector2()
var look : Vector2 = Vector2()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		mLook = event.relative

func _process(delta : float) -> void:
	FBRL.x = Input.get_axis("L","R")
	FBRL.y = Input.get_axis("F","B")
	FBRL = FBRL.limit_length()
	
	look = -mLook * 0.0025
	
	set_deferred("mLook", Vector2())
