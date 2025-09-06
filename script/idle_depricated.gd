extends State

func enter() -> void:
  var dir = player.direction if player.direction != Vector2.ZERO else player.last_direction
  player.flipbook.play("idle_" + player.get_direction_suffix(dir))
  

func update(delta: float) -> void:
  if Input.is_action_just_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
  elif player.input != Vector2.ZERO:
    fsm.change_state(fsm.get_node("Walk"))
