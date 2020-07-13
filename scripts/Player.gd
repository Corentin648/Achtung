extends Node
signal hit
export (PackedScene) var Trace

var pause
var vivant
var nom

var image
var couleur

var velocity = Vector2()
var compteurTrous
var aleatoireTrou

var touche_gauche
var touche_droite
var points

func _ready():
	
	pause = true
	vivant = true
	
	var screen_width = ProjectSettings.get_setting("display/window/size/width")
	var screen_height = ProjectSettings.get_setting("display/window/size/height")
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# code permettant d'associer les touches au mouvement
	var event_droite = InputEventKey.new()
	event_droite.scancode = touche_droite
	InputMap.add_action(String(touche_droite))
	InputMap.action_add_event(String(touche_droite), event_droite)
	var event_gauche = InputEventKey.new()
	event_gauche.scancode = touche_gauche
	InputMap.add_action(String(touche_gauche))
	InputMap.action_add_event(String(touche_gauche), event_gauche)
	
	connect("hit", Global.Main, "_on_Player_hit")
	compteurTrous = 0
	Trace = load("res://scenes/Trace.tscn")
	velocity.x = rng.randf_range(-1,1)
	velocity.y = rng.randf_range(-1,1)
	velocity = velocity.normalized()*100
	
	$Body.rotate(velocity.angle())
	
	# La largeur de l'écran jaune vaut 710 px
	$Body.set_position(Vector2(round(rng.randf_range(0.1, 0.9)*710), round(rng.randf_range(0.1, 0.9)*screen_height)))
	pass


func _physics_process(delta):
	if !pause && vivant:
		nouveau_trou()
		$Body.set_position($Body.get_position() + velocity*delta)
		if Input.is_action_pressed(String(touche_gauche)):
			$Body.rotate(-PI/75)
			velocity = velocity.rotated(-PI/75).normalized()*100
		if Input.is_action_pressed(String(touche_droite)):
			$Body.rotate(PI/75)
			velocity = velocity.rotated(PI/75).normalized()*100
	pass
	

func nouveau_trou():
	if compteurTrous == 0:
		aleatoireTrou = randf()
		if aleatoireTrou <= 0.995:
			var trace = Trace.instance()
			trace.get_node("Sprite").set_texture(image)
			add_child(trace)
			trace.position = Vector2($Body.get_position().x,$Body.get_position().y)
		else:
			compteurTrous = 1
	elif compteurTrous == 30:
		compteurTrous = 0
	else:
		compteurTrous += 1
	pass

func _on_Area2D_body_entered(body):
	velocity.x = 0
	velocity.y = 0
	if vivant:
		vivant = false
		emit_signal("hit", self)
	pass
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		pause = !pause
	pass
