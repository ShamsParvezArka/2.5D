extends State

func enter() -> void:
  var dir = player.direction if player.direction != Vector2.ZERO else player.last_direction
  player.flipbook.play("walk_" + player.get_direction_suffix(dir))
  
func update(delta: float) -> void:
  if player.input == Vector2.ZERO:
    fsm.change_state(fsm.get_node("Idle"))
    return
  if Input.is_action_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
    return
    
  player.velocity.x = player.input.x * player.speed * delta
  player.velocity.z = player.input.y * player.speed * delta
  player.move_and_slide()
