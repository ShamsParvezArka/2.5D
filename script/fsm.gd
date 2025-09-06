class_name StateMachine extends Node3D

@export_group ("FSM Parameters")
@export var player: CharacterBody3D

# @onready var anim_state = player.anim_tree["parameters/AnimationNodeStateMachine/playback"]

var states: Dictionary
var current_state: State

func init(initial_state: State) -> void:
  for child in get_children():
    if child is State:
      states[child.name] = child
      child.player = player
      child.fsm = self
      child.state_path = "parameters/AnimationNodeStateMachine/%s/blend_position" %child.name
      child.condition_path = "parameters/AnimationNodeStateMachine/conditions/%s" %child.name.to_lower()
  current_state = initial_state
  current_state.enter()

func change_state(new_state: State) -> void:
  if current_state == new_state:
    return
    
  current_state.exit()
  current_state = new_state
  current_state.enter()


func update(delta: float) -> void:   
  if current_state:
    current_state.update(delta)
