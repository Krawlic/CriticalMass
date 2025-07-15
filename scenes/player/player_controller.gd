extends CharacterBody2D

@export var speed : float = 150.0
@export var jump_velocity: float = -175.0
@export var jump_buffer_time: float = 0.15
@export var max_jumps: int = 0
@export var coyote_time: float = 0

@onready var animated_sprite : AnimatedSprite2D = $PlayerSprite

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var is_moving: bool = false
var direction: Vector2 = Vector2.ZERO
var player_pos: Vector2 = Vector2.ZERO
var jump_buffer_timer: float = 0.0
var static_pos : bool = false
var jumps_left: int = 0
var coyote_timer: float = 0.0

func _ready():
	SignalBus.player_escape.connect(_player_escape)
	coyote_time = PlayerManager.coyote_time
	max_jumps = PlayerManager.max_jumps
	
func _physics_process(delta):
	if !static_pos:
		if not is_on_floor():
			velocity.y += gravity * delta
			coyote_timer -= delta
		else:
			coyote_timer = coyote_time
		
		if Input.is_action_just_pressed("jump"):
			jump_buffer_timer = jump_buffer_time
			
		if jump_buffer_timer > 0:
			jump_buffer_timer -= delta
			
		if is_on_floor() or coyote_timer > 0:
			land()
			if jump_buffer_timer > 0:
				jump()
				jump_buffer_timer = 0
				coyote_timer = 0
		else:
			if jump_buffer_timer > 0 and jumps_left > 0:
				jump()
				jump_buffer_timer = 0
				jumps_left -= 1
		
		direction = Input.get_vector("left", "right", "up", "down")
		if direction:
			velocity.x = direction.x * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		player_pos = global_position
		
		move_and_slide()
		update_animation()

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			is_moving = true
			animated_sprite.play("walk")
			if direction.x > 0:
				animated_sprite.flip_h = false
			elif direction.x < 0:
				animated_sprite.flip_h = true
		else:
			animated_sprite.play("idle")
			is_moving = false

func jump():
	is_moving = true
	velocity.y = jump_velocity
	#animated_sprite.play("jump")
	#animation_locked = true
	
func land():
	#animation_locked = false
	is_moving = false
	jumps_left = max_jumps - 1

func _player_escape():
	animation_locked = true
	static_pos = true
	animated_sprite.play("escape")
	pass

func _on_player_sprite_animation_finished():
	if animated_sprite.animation == "escape":
		SignalBus.progress_scene.emit("Upgrade")
