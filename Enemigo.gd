extends Area2D


var posic_enemy = Vector2(100, 100)
var movimiento = Vector2()

const VELOCIDAD = 150

func _ready():
	set_position(posic_enemy)
	pass 



func _process(delta):
	posic_enemy += movimiento * VELOCIDAD * delta
#	posic_enemy.x = clamp(posic_enemy.x, 50, 430)
#	posic_enemy.y = clamp(posic_enemy.y, 100, 604)
	if (posic_enemy.x <= 50) or (posic_enemy.x > 430):
		movimiento.x *= -1
	if (posic_enemy.y <= 50) or (posic_enemy.y > 650):
		movimiento.y *= -1
	
	set_position(posic_enemy)
	pass
	

func ND_direccion(posic_player):
	var destino = posic_player
	var inicio = get_position()
	movimiento = destino - inicio
	movimiento = movimiento.normalized()
	pass
	
func ND_gameover_enemy():
	set_process(false)
	
	pass	
