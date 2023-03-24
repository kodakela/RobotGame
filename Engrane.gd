extends Area2D



func _ready():
	pass 


#func _process(delta):
#	pass

func ND_borrar():
	call_deferred("queue_free")
	
	pass
