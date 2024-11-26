extends CharacterBody2D


@export var SPEED := 40.0
@onready var player_node: CharacterBody2D = get_tree().get_nodes_in_group('player')[0] as CharacterBody2D
@onready var nav := $NavigationAgent2D as NavigationAgent2D
var target_location: Vector2

func _process(delta: float) -> void:
	nav.target_position = player_node.global_position

func _physics_process(delta: float) -> void:
	velocity = global_position.direction_to(nav.get_next_path_position()) * SPEED
	move_and_slide()
