extends State


func enter() -> void:
  player.anim_tree.set(condition_path, true)


func update(delta: float) -> void:
  player.anim_tree.set(state_path, player.last_facing_direction)
  
  if player.input != Vector2.ZERO:
    fsm.change_state(fsm.get_node("Walk"))
  if Input.is_action_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
  

func exit() -> void:
  player.anim_tree.set(condition_path, false)
