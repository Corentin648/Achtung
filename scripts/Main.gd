extends Node2D
export (PackedScene) var Player


func _ready():
	Global.Main = self
	Player = load("res://scenes/Player.tscn")
	$Mur.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Menu_game_started():
	$Mur.show()
	var player = Player.instance()
	player.touche_droite = KEY_RIGHT
	add_child(player)
	pass # Replace with function body.
	
func _on_Player_hit():
	print("le test")
	pass
