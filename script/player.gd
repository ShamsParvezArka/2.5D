extends CharacterBody3D

@export var initial_state: State
@export var anim_tree: AnimationTree
@export var speed := 30.0

@onready var fsm := $FSM

var input := Vector2.ZERO
var last_facing_direction := Vector2(1, 1)


func _ready() -> void:
  fsm.init(initial_state)


func _process(delta: float) -> void:
  input = Vector2(
    Input.get_action_strength("right") - Input.get_action_strength("left"),
    Input.get_action_strength("down") - Input.get_action_strength("up")
  ).normalized()
  
  if input != Vector2.ZERO:
    last_facing_direction = input
  
  fsm.update(delta)
  

func _physics_process(delta: float) -> void:
  move_and_slide()
