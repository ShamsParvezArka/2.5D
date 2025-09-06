extends CharacterBody3D

@export var speed := 100.0
@export var dash_speed := 150.0 

@onready var flipbook := $Flipbook
@onready var camera := $"../Camera3D"
@onready var fsm := $StateMachine

var input := Vector2.ZERO
var mouse_available := false
var direction := Vector2.ZERO
var last_direction := Vector2.ZERO


func _ready() -> void:
  fsm.state_machine_init($StateMachine/Idle)


func _notification(what: int) -> void:
  match what:
    NOTIFICATION_WM_MOUSE_ENTER:
      mouse_available = true
    NOTIFICATION_WM_MOUSE_EXIT:
      mouse_available = false
    

func _physics_process(delta: float) -> void:
  #if mouse_available:
    #var mouse_pos = get_viewport().get_mouse_position()
    #var player_screen_pos = camera.unproject_position(global_transform.origin)
    #direction = (mouse_pos - player_screen_pos).normalized()
      
  input = Vector2(
    Input.get_action_strength("right") - Input.get_action_strength("left"),
    Input.get_action_strength("down") - Input.get_action_strength("up")
  ).normalized()
  direction = input
  if direction != Vector2.ZERO:
    last_direction = direction
    
  fsm.update(delta)


func get_direction_suffix(facing_direction: Vector2) -> String:
  var result := ""
  if facing_direction.x < 0 and facing_direction.y < 0:
    result = "up_left"
  elif facing_direction.x < 0 and facing_direction.y > 0:
    result = "down_left"
  elif facing_direction.x > 0 and facing_direction.y > 0:
    result = "down_right"
  elif facing_direction.x > 0 and facing_direction.y < 0:
    result = "up_right"
  
  elif facing_direction.y == 0:
    if facing_direction.x > 0:
      result = "down_right"
    else:
      result = "down_left"
  elif facing_direction.x == 0:
    if facing_direction.y > 0:
      result = "down"
    else:
      result = "up"
  return result


func get_direction_suffix_depricated(direction: Vector2) -> String:
  var result := ""
  var deg := rad_to_deg(atan2(direction.y, direction.x))
  if deg >= -150 and deg < -120:
    result = "up_left"
  elif deg >= -120 and deg < -60:
    result = "up"
  elif deg >= -60 and deg < -30:
    result = "up_right"
  elif deg >= -30 and deg < 30:
    result = "down_right"
  elif deg >= 30 and deg < 120:
    result = "down"
  else:
    result = "down_left"
  return result
