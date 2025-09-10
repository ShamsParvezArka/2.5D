extends State


func enter() -> void:
  player.velocity.y = 3
  player.flipbook.play("jump_%s" %fsm.get_facing_direction_string(player.last_facing_direction))


func update(delta: float) -> void:
  fsm.update_facing_direction(player.last_facing_direction) 
  
  player.velocity.x = player.input.x * player.speed * delta
  player.velocity.z = player.input.y * player.speed * delta
  
  if Input.is_action_just_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
  elif player.is_on_floor():
    if player.input == Vector2.ZERO:
      player.velocity = Vector3.ZERO
      fsm.change_state(fsm.get_node("Idle"))
    else:
      fsm.change_state(fsm.get_node("Walk"))
