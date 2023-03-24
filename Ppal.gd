extends Node2D

var engranes_inicio = 5
var puntos = 0
var nivel = 1
var tiempo = 12

export(PackedScene) var Engrane #Avisar que el jugador esta en el banco


func _ready():
	OS.center_window()
	randomize()
	ND_instanciar_engranes()
	ND_interfaz()
	$ContenedorAudios/AudioGral.play()
	pass 
	
	
#func _process(delta):
#	pass


func ND_instanciar_engranes():
	for i in range(engranes_inicio + nivel):
		var EngraneInstanciado = Engrane.instance() #Le avisamos al jugador que va a entrar que vaya precalentando
		EngraneInstanciado.set_position(Vector2(rand_range(50, 430), rand_range(50, 654))) #Le damos la orden de accion al jugador
		$ContenedorEngranes.call_deferred("add_child", EngraneInstanciado) #Sale el jugador a la cancha
	
	
	
	pass


func _on_Player_encontrado():
	puntos += 1
	$ContenedorAudios/AudioPuntos.play()
	if $ContenedorEngranes.get_child_count() <= 1:
		nivel += 1
		$ContenedorAudios/AudioLevel.play()
		$Interfaz/Mensaje.visible = true
		$ContenedorTimer/TimerMensaje.start()
		ND_instanciar_engranes()
		tiempo = 12
	ND_interfaz()
	pass 
	
	
func ND_interfaz():
	$Interfaz/Puntos.text = str(puntos)
	$Interfaz/Nivel.text = str(nivel)
	$Interfaz/Tiempo.text = str(tiempo)
	pass


func _on_TimerMensaje_timeout():
	$Interfaz/Mensaje.visible = false
	pass 


func _on_TimerGral_timeout():
	tiempo -= 1
	if $ContenedorEngranes.get_child_count() <= 0:
		nivel += 1
		$ContenedorAudios/AudioLevel.play()
		$Interfaz/Mensaje.visible = true
		$ContenedorTimer/TimerMensaje.start()
		ND_instanciar_engranes()
		tiempo = 12
	ND_interfaz()
	if tiempo <= 0:
		#Hacemos el GAMEOVER
		ND_gameover()
	pass 

func ND_gameover():
	$ContenedorAudios/AudioGral.stop()
	#Poner el mensaje GAME OVER!
	$Interfaz/Mensaje.text = "GAME OVER!"
	$Interfaz/Mensaje.visible = true
	#Que deje de contar el tiempo
	$ContenedorTimer/TimerGral.stop()
	#Que deje de moverse el player
	#La animación de daño al player
	$Player.ND_gameover_player()
	$Enemigo.ND_gameover_enemy()
	#Mostrar los puntos ganados
	$Interfaz/Puntos.rect_scale = Vector2(2, 2)
	#Dar la posibilidad de reiniciar
	$Interfaz/Button.visible = true
	$ContenedorAudios/GameOver.play()
	pass


func _on_Button_pressed():
	get_tree().reload_current_scene()
	pass 


func _on_TimerEnemy_timeout():
	var posic_player = $Player.get_position()
	$Enemigo.ND_direccion(posic_player)
	pass 


func _on_Player_tocado():
	ND_gameover()
	
	pass 


func _on_Player_escudado():
	$ContenedorAudios/AudioPowerUp.play()
	puntos += 3 
	ND_interfaz()
	pass
