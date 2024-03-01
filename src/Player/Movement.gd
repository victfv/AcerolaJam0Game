extends Node

class_name PlayerMovement

@export var player : CharacterBody3D
@export var input : PlayerInput
@export var floorRays : FloorRays
@export var cam : PlayerCamera

var movementMode : int = 0
var velocity : Vector3 = Vector3()
var acceleration : float = 64.0
var damping : float = 16.0

var willJump : bool = false
var gravity : float = -9.8

const DEFAULT_GRAV_DIR : Basis = Basis(Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1))
var gravityDirection : Basis = DEFAULT_GRAV_DIR
var fDist : float = 50.0
func mMode() -> void:
	fDist = floorRays.floorDistance
	var fNorm : Vector3 = floorRays.floorNormal
	
	match movementMode:
		0:
			if fDist < -0.01 and velocity.y < 2:
				setMMode(1)
		1:
			if fDist > 0.3:
				setMMode(0)

func setMMode(newMode : int) -> void:
	match movementMode:
		1:
			match newMode:
				0:
					velocity -= velocity.project(gravityDirection.y)
	
	movementMode = newMode

func _physics_process(delta : float) -> void:
	velocity = player.get_real_velocity()
	mMode()
	
	var dir : Vector3 = cam.global_basis.x * input.FBRL.x + cam.global_basis.z * input.FBRL.y
	dir = dir.limit_length()
	match movementMode:
		0:
			pass#TODO Add air control
		1:
			#Damping
			velocity = velocity - (velocity.project(gravityDirection.x) + velocity.project(gravityDirection.z)) * delta * damping
			
			#Acceleration
			velocity += acceleration * delta * dir
	
	match movementMode:
		0:
			velocity += gravityDirection.y * gravity * delta
		1:
			velocity -= velocity.project(gravityDirection.y)
			velocity += gravityDirection.y * clamp(-fDist * 30.0,-6,6)
	
	jump()
	
	player.velocity = velocity
	player.move_and_slide()

func jump() -> void:
	if willJump:
		if movementMode == 1:
			setMMode(0)
			velocity.y = 4.0
		willJump = false



