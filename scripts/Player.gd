extends Node
signal hit
export (PackedScene) var Trace


var velocity = Vector2()

func _ready():
	Trace = load("res://scenes/Trace.tscn")
	velocity.x = 200
	$Body.set_position(Vector2(100,100))
	pass


func _physics_process(delta):
	var trace = Trace.instance()
	add_child(trace)
	trace.position = Vector2($Body.get_position().x,$Body.get_position().y)
	$Body.set_position($Body.get_position() + velocity*delta)
	if Input.is_action_pressed("ui_left"):
		$Body.rotate(-PI/50)
		velocity = velocity.rotated(-PI/50).normalized()*200
	if Input.is_action_pressed("ui_right"):
		$Body.rotate(PI/50)
		velocity = velocity.rotated(PI/50).normalized()*200
	pass



func _on_Body_input_event(viewport, event, shape_idx):
	print("cest le test")
	$Body/CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.


func _on_Body_body_entered(body):
	velocity.x = 0
	velocity.y = 0
	pass # Replace with function body.
