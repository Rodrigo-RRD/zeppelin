extends CharacterBody2D

@export_category("Variables")

@export var _move_speed:float = 200.0
#@export var _friction: float = 0.2
#@export var _acceleration: float = 0.4

var is_walking:bool = false
var input_direction:Vector2
#var is_dashing:bool= false

@onready var body_animation_player=$AnimacaoBody

func _ready():
	body_animation_player.play("idle")

func _process(delta: float) -> void:
	is_walking_action_pressed()
	
	if is_walking:
		velocity = input_direction * _move_speed
		play_walking_animation()
		
func _physics_process(delta: float) -> void:
	get_input_direction()
	move_and_slide()
	
func is_walking_action_pressed():
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		is_walking = true 
	
func get_input_direction():
	input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
func play_walking_animation():
	
	if input_direction.x > 0:
		body_animation_player.play("andando")
		body_animation_player.flip_h = false
	
	if input_direction.x < 0:
		body_animation_player.play("andando")
		body_animation_player.flip_h = true
	
	if input_direction.y != 0:
		body_animation_player.play("andando")
	
	if velocity == Vector2(0,0) and is_walking == true:
		is_walking = false
		body_animation_player.play("idle")
	
