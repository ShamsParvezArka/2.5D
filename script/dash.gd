extends State

@onready var timer: Timer = $Timer


func enter() -> void:
  player.anim_tree.set(condition_path, true)
  timer.start()


func update(delta) -> void:
  player.anim_tree.set(state_path, player.last_facing_direction)
  
  var dash_direction = player.last_facing_direction if player.input == Vector2.ZERO else player.input 
  player.velocity = Vector3(dash_direction.x, 0, dash_direction.y)
  
  
func exit() -> void:
  player.anim_tree.set(condition_path, false)


func _on_timer_timeout() -> void:
  fsm.change_state(fsm.get_node("Idle"))
  player.velocity = Vector3.ZERO
