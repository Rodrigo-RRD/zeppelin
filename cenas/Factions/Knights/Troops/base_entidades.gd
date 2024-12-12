extends CharacterBody2D

@export_category("Variables")

@export var _move_speed:float = 200.0
@export var vida_maxima: float = 100.0
@export var dano: float = 10.0
var vida_atual: float = vida_maxima

var is_walking:bool = false
var input_direction:Vector2
var _pode_atacar: bool = true

@onready var body_animation_player=$AnimacaoBody

# Função para causar dano ao personagem
func receber_dano(dano: float) -> void:
	vida_atual -= dano
	if vida_atual <= 0:
		vida_atual = 0
		# Adicionar lógica para morte do personagem aqui (por exemplo, reiniciar o jogo, tocar animação de morte)
		# body_animation_player.play("morte")
		print("Personagem morreu")

# Função para atacar e aplicar dano aos inimigos
func _ataque() -> void:
	if Input.is_action_just_pressed("ataque1") and _pode_atacar == true:
		$ataqueDireito.start()
		_pode_atacar = false
		set_physics_process(false)
		is_walking = false
		body_animation_player.play("ataqueEsquerda")
		# Aplique dano ao inimigo
		print("Ataque realizado com dano: %s" % dano)
		
	if Input.is_action_just_pressed("ataque2") and _pode_atacar == true:
		$ataqueEsquerdo.start()
		_pode_atacar = false
		set_physics_process(false)
		is_walking = false
		body_animation_player.play("ataqueDireita")
		# Aplique dano ao inimigo
		print("Ataque realizado com dano: %s" % dano)

# Função para reiniciar o personagem
func reiniciar_personagem() -> void:
	vida_atual = vida_maxima
	# Reposicionar o personagem, reiniciar animação, etc.
	print("Personagem reiniciado")

func _on_ataque_esquerdo_timeout() -> void:
	$ataqueEsquerdo.stop()
	_pode_atacar = true
	body_animation_player.play("idle")
	set_physics_process(true)
	pass # Replace with function body.

func _on_ataque_direito_timeout() -> void:
	$ataqueDireito.stop()
	_pode_atacar = true
	body_animation_player.play("idle")
	set_physics_process(true)
	pass # Replace with function body.

func _ready():
	body_animation_player.play("idle")

func _process(_delta: float) -> void:
	is_walking_action_pressed()
	
	if is_walking:
		velocity = input_direction * _move_speed
		play_walking_animation()
		
func _physics_process(_delta: float) -> void:
	move_and_slide()
	get_input_direction()
	_ataque()
	
func is_walking_action_pressed():
	if _pode_atacar == true:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			is_walking = true 
	
func get_input_direction():
	input_direction = Input.get_vector("move_left","move_right","move_up","move_down")

func play_walking_animation() -> void:
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
