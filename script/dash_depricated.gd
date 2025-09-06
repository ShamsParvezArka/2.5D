extends State

@export var dash_duration := 0.2
@export var dash_distance := 50.0 

var timer := 0.0
var dash_velocity := Vector3.ZERO

func enter() -> void:
    timer = dash_duration
    player.flipbook.speed_scale = 4
    # Pick dash direction (mouse or last known)
    var dir2D: Vector2 = player.direction if player.direction != Vector2.ZERO else player.last_direction
    player.last_direction = dir2D  # remember it
    
    # Convert to 3D movement vector (X,Z plane)
    var dir3D = Vector3(dir2D.x, 0, dir2D.y).normalized()
    
    # Velocity to move dash_distance over dash_duration
    dash_velocity = dir3D * (dash_distance / dash_duration)

    # Play dash animation
    player.flipbook.play("dash_" + player.get_direction_suffix(dir2D))


func update(delta: float) -> void:
    timer -= delta
    
    # Apply dash movement (ignores input)
    player.velocity = dash_velocity * delta
    player.move_and_slide()
    
    if timer <= 0:
      player.flipbook.speed_scale = 2
      fsm.change_state(fsm.get_node("Idle"))
        
