extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
var score : int = 0

@onready var scoreText : Label = $CanvasLayer/ScoreText
@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		anim.flip_h = false
		velocity.x -= move_speed
	
	if Input.is_key_pressed(KEY_RIGHT):
		anim.flip_h = true
		velocity.x += move_speed
	
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y -= jump_force
		
	if velocity.y != 0:
		anim.play("jump")
	else:
		anim.play("walk")
	
	move_and_slide()
	
	if global_position.y > 100:
		game_over()
	
func game_over():
	get_tree().reload_current_scene()
	reset_score()
	
func reset_score():
	global.score = 0
	scoreText.text = "Score: 0"
	
func add_score(amount):
	global.score += amount
	scoreText.text = str("Score: ", global.score)
	
func _ready():
	add_score(0)
	print(get_children())
