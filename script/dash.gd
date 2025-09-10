extends State

@onready var timer: Timer = $Timer


func enter() -> void:
  player.flipbook.play("dash_%s" %fsm.get_facing_direction_string(player.last_facing_direction))
  timer.start()


func update(delta) -> void:
  fsm.update_facing_direction(player.last_facing_direction)
  
  var dash_direction = player.last_facing_direction if player.input == Vector2.ZERO else player.input 
  player.velocity = Vector3(dash_direction.x, 0, dash_direction.y) * player.dash_speed


func _on_timer_timeout() -> void:
  fsm.change_state(fsm.get_node("Idle"))
  player.velocity = Vector3.ZERO
