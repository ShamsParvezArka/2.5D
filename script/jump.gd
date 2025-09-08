extends State


@onready var timer: Timer = $Timer


func enter() -> void:
  player.flipbook.play("idle_%s" %fsm.get_facing_direction_string(player.last_facing_direction))
  timer.start()

func update(delta: float) -> void:
  fsm.update_facing_direction(player.last_facing_direction) 
  if Input.is_action_pressed("dash"):
    fsm.change_state(fsm.get_node("Dash"))
  player.velocity.y = 35 * delta


func _on_timer_timeout() -> void:
  fsm.change_state(fsm.get_node("Idle"))
