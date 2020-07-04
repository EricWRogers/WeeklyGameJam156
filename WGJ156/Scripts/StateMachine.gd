extends Node
class_name StateMachine

var state = null setget set_state
var previous_state = null
var states = {}

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var change_state = _get_transition(delta)
		if change_state != null:
			set_state(change_state)

func _state_logic(delta):
	pass

func _get_transition(delta):
	pass

func _enter_state():
	pass

func _exit_state(new_state):
	pass

func set_state(new_state):
	if new_state == null:
		return
	#Exit the current state
	if state != null:
		_exit_state(new_state)
	#Set new state
	previous_state = state
	state = new_state
	#Start new state
	_enter_state()

func add_state(state_name):
	states[state_name] = states.size()
