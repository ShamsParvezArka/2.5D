extends State


func enter() -> void:
  player.flipbook.play("idle_%s" %fsm.get_facing_direction_string(player.last_facing_direction))


func update(delta: float) -> void:
  fsm.update_facing_direction(player.last_facing_direction)
  
  if player.input != Vector2.ZERO:
    fsm.change_state(fsm.get_node("Walk"))
  if Input.is_action_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
  if Input.is_action_pressed("jump") and player.is_on_floor():
    fsm.change_state(fsm.get_node("Jump"))
    
    
func exit() -> void: 
  pass
