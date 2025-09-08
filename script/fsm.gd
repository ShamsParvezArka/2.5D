class_name StateMachine extends Node3D

@export_group ("FSM Parameters")
@export var player: CharacterBody3D

var states: Dictionary
var current_state: State


func init(initial_state: State) -> void:
  for child in get_children():
    if child is State:
      states[child.name] = child
      child.player = player
      child.fsm = self

  current_state = initial_state
  current_state.enter()


func update(delta: float) -> void:   
  if current_state:
    current_state.update(delta)
    
    
func update_facing_direction(direction: Vector2) -> void:
  var state = current_state.name.to_lower()
  player.flipbook.play("%s_%s" %[state, get_facing_direction_string(direction)])


func get_facing_direction_string(direction: Vector2):
  var facing_coordinate = [int(clamp(sign(direction.x), -1, 1)), 
                          int(clamp(sign(direction.y), -1, 1))]
  match facing_coordinate: 
    [1, 1]:   return "right_down"
    [1, -1]:  return "right_up"
    [-1, -1]: return "left_up"
    [-1, 1]:  return "left_down"
    [1, 0]:   return "right_down"
    [-1, 0]:  return "left_down"
    [0, 1]:   return "down"
    [0, -1]:  return "up"
    _:        pass


func change_state(new_state: State) -> void:
  if current_state == new_state:
    return
    
  current_state.exit()
  current_state = new_state
  current_state.enter()
