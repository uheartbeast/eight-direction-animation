extends CharacterBody2D

const SPEED = 90
const ANIMATION_SPEED = 1.0
const MIN_ANIMATION_SPEED = 0.75
const INPUT_INTERPOLATION_SPEED = 8

var input_vector: = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree

func _physics_process(delta: float) -> void:
	var vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_vector = input_vector.move_toward(vector, INPUT_INTERPOLATION_SPEED * delta)
	
	if input_vector.length() > 0.0:
		update_blend_positions(Vector2(input_vector.x, -input_vector.y))
		animation_tree.set("parameters/TimeScale/scale", max(MIN_ANIMATION_SPEED, input_vector.length() * ANIMATION_SPEED))

	velocity = input_vector * SPEED
	move_and_slide()

func update_blend_positions(new_position: Vector2) -> void:
	animation_tree.set("parameters/StateMachine/MoveState/IdleState/blend_position", new_position)
	animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position", new_position)
