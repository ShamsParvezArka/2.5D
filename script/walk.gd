extends State


func enter() -> void:
  player.anim_tree.set(condition_path, true)


func update(delta: float) -> void:
  player.anim_tree.set(state_path, player.last_facing_direction)
  if player.input == Vector2.ZERO:
    fsm.change_state(fsm.get_node("Idle"))
  if Input.is_action_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
    
  player.velocity.x = player.input.x * player.speed * delta
  player.velocity.z = player.input.y * player.speed * delta
  
  
func exit() -> void:
  player.anim_tree.set(condition_path, false)
