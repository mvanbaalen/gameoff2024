class_name Player
extends CharacterBody2D


@export var SPEED := 48

@onready var sprite := $Sprite as AnimatedSprite2D
var moving := true
var intent := Vector2(-1, 0)
var direction := Vector2(-1, 0)

func get_input() -> void:
	if Input.is_action_pressed("character_down"):
		intent = Vector2.DOWN
	elif Input.is_action_pressed("character_up"):
		intent = Vector2.UP
	elif Input.is_action_pressed("character_left"):
		intent = Vector2.LEFT
	elif Input.is_action_pressed("character_right"):
		intent = Vector2.RIGHT
	else:
		intent = direction
		
func determine_direction() -> void:
	if direction == Vector2.ZERO:
		direction = intent
		return
		
	if intent == -direction:
		direction = intent
		return
		
	match intent:
		Vector2.DOWN:
			if direction == Vector2.RIGHT:
				if !($Colliders/DownLeft as RayCast2D).is_colliding():
					direction = intent
			elif direction == Vector2.LEFT:
				if !($Colliders/DownRight as RayCast2D).is_colliding():
					direction = intent
		Vector2.UP:
			if direction == Vector2.RIGHT:
				if !($Colliders/UpLeft as RayCast2D).is_colliding():
					direction = intent
			elif direction == Vector2.LEFT:
				if !($Colliders/UpRight as RayCast2D).is_colliding():
					direction = intent
		Vector2.RIGHT:
			if direction == Vector2.UP:
				if !($Colliders/RightDown as RayCast2D).is_colliding():
					direction = intent
			elif direction == Vector2.DOWN:
				if !($Colliders/RightUp as RayCast2D).is_colliding():
					direction = intent
		Vector2.LEFT:
			if direction == Vector2.UP:
				if !($Colliders/LeftDown as RayCast2D).is_colliding():
					direction = intent
			elif direction == Vector2.DOWN:
				if !($Colliders/LeftUp as RayCast2D).is_colliding():
					direction = intent

func _physics_process(delta: float) -> void:
	if moving:	
		get_input()
		determine_direction()
		
		var previous_pos := position
		move_and_collide(direction * SPEED * delta)
		if previous_pos == position:
			sprite.play("still")
		else:
			sprite.play("moving")		
		
func trigger_scene_change() -> void:
	moving = false
	var tween := create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y+600), 1)
	tween.tween_callback(get_tree().change_scene_to_file.bind("res://scenes/platform.tscn"))
	
	
