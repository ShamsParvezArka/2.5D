extends Node

@export var player: CharacterBody3D
var current_state

func state_machine_init(initial_state: State) -> void:
  current_state = initial_state
  for child in get_children():
    child.player = player
    child.fsm = self
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
