extends Node

export (PackedScene) var Trace


var velocity = Vector2()

func _ready():
	Trace = load("res://scenes/Trace.tscn")
	velocity.x = 200
	$Body.set_position(Vector2(100,100))
	pass


func _process(delta):
	var trace = Trace.instance()
	add_child(trace)
	trace.position = Vector2($Body.get_position().x,$Body.get_position().y)
	$Body.move_and_slide(velocity)
	if Input.is_action_pressed("ui_left"):
		$Body.rotate(-PI/50)
		velocity = velocity.rotated(-PI/50).normalized()*100
		#$Body.move_and_slide(velocity)
	if Input.is_action_pressed("ui_right"):
		$Body.rotate(PI/50)
		velocity = velocity.rotated(PI/50).normalized()*100
		#$Body.move_and_slide(velocity)
	pass

