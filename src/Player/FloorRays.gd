extends Node3D

class_name FloorRays

var floorDistance : float
var floorNormal : Vector3 = Vector3(0,1,0)
var up : Vector3 = Vector3(0,1,0)

func _physics_process(delta : float) -> void:
	floorDistance = 50.0
	floorNormal = Vector3(0,1,0)
	for ray : RayCast3D in get_children():
		if ray.get_collider() != null:
			var dst : float = (global_position.y - ray.get_collision_point().y)
			if dst < floorDistance and ray.get_collision_normal().dot(up) > 0.707106:
				floorDistance = dst
				floorNormal = ray.get_collision_normal()
	
