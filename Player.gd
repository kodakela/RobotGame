extends Area2D

signal encontrado
signal tocado
signal escudado

var movimiento = Vector2()
var posic_player = Vector2(240, 352)
var escudo = false

const VELOCIDAD = 150

func _ready():
	set_position(posic_player)
	
	pass 

func _process(delta):
	ND_direccion()
	ND_animar()
	
	posic_player += movimiento * VELOCIDAD * delta
#	if posic_player.x < 50:
#		posic_player.x = 50
#	if posic_player.x > 430:
#		posic_player.x = 430
	posic_player.x = clamp(posic_player.x, 50, 430)
	posic_player.y = clamp(posic_player.y, 100, 604)
	
	set_position(posic_player)
	
	pass
	
	
func ND_direccion():
	movimiento = Vector2()
	if Input.is_action_pressed("ui_right"):
		movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		movimiento.x += -1
	if Input.is_action_pressed("ui_up"):
		movimiento.y += -1
	if Input.is_action_pressed("ui_down"):
		movimiento.y += 1
	movimiento = movimiento.normalized()
	pass
	
	
func ND_animar():
	if movimiento.x > 0:
		$SpritePlayer.set_flip_h(true)
	if movimiento.x < 0:
		$SpritePlayer.set_flip_h(false)
	if movimiento == Vector2():
		$SpritePlayer.set_animation ("Idle")
	if movimiento != Vector2():
		$SpritePlayer.set_animation ("Run")		
		
	pass









func _on_Player_area_entered(area):
	if area.is_in_group("Engrane"):
		area.ND_borrar()
		emit_signal("encontrado")
	if (area.is_in_group("Enemigo")) and (escudo == false):
		emit_signal("tocado")
	if area.is_in_group("Bateria"):
		#Contar puntos
		emit_signal("escudado")
		#Aparecer el escudo
		$Escudo.visible = true
		#La motosierra no nos hace sdaño
		escudo = true
		#La bateria desaparece
		$TimerEscudo.start()
		area.ND_salir()
	pass 


func ND_gameover_player():
	#Que deje de moverse el player
	set_process(false)
	#Reproducir la animación de daño al player
	$SpritePlayer.animation = "Hurt"
	pass


func _on_TimerEscudo_timeout():
	$Escudo.visible = false
	escudo = false
	pass 
