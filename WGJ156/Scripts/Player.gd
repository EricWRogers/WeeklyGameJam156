extends KinematicBody2D

export var max_speed : float = 100
export var acceleration : float = 50

enum STATES {
	MOVE,
	ROLL,
	ATTACK
}

var state = STATES.MOVE
var velocity : Vector2 = Vector2.ZERO
var input_vector : Vector2 = Vector2.ZERO

onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var animationTree : AnimationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/Hitbox

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		STATES.MOVE:
			_move_state_update(delta)
		STATES.ATTACK:
			_attack_state_update(delta)
		STATES.ROLL:
			pass

func _move_state_update(delta):
	# Get Move input and normalize it
	input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		swordHitbox.knockback_vector = input_vector
	else:
		animationState.travel("Idle")
	
	velocity = move_and_slide( velocity.move_toward(input_vector * max_speed, acceleration) )
	
	if Input.is_action_just_pressed("use_weapon"):
		state = STATES.ATTACK

func _attack_state_update(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = STATES.MOVE
