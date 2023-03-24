extends Area2D

var posic_bateria = Vector2(-100, -100)
 
func _ready():
	randomize()
	pass 



func _process(delta):
	pass


func _on_TimerBateria_timeout():
	posic_bateria = (Vector2(rand_range(50, 430), rand_range(50, 654)))
	position = posic_bateria
	pass
	
func ND_salir():
	posic_bateria = Vector2(-100, -100)
	position = posic_bateria
	pass
	
