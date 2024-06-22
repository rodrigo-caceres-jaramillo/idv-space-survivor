class_name StateMachine
extends Node

@export var actor: CharacterBody2D
@export var initial_state: State
@export var animation_player: AnimationPlayer
var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.actor = actor
			child.animation_player = animation_player
			child.state_transition.connect(on_child_transition)
	if initial_state:
		initial_state.enter(null)
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name, data=null):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()
		
	new_state.enter(data)
	current_state = new_state
