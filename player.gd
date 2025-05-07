extends CharacterBody2D

const SPEED = 90

var input_vector: = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	animation_tree.set("parameters/TimeScale/scale", 0.1)

func _physics_process(delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = input_vector * SPEED
	move_and_slide()
