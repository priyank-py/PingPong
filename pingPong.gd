extends Node2D

#Constants:
const PADSPEED = 200
const INITBALLSPEED = 100

#Variables:
var screenSize
var padSize
var ballDirection = Vector2(1.0, 0.0)
var ballSpeed = INITBALLSPEED
var leftScore = 0
var rightScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
#	print(screenSize.x)
	var leftPlayer = get_node("leftPlayer")
	padSize = leftPlayer.get_texture().get_size()

	set_process(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ballPosition = get_node("ball")
#	print(ballPosition)
	var rightPlayer = get_node("rightPlayer")
	var rightPlayerSize = rightPlayer.get_texture().get_size()
	var leftPlayer = get_node("leftPlayer")
	var leftPlayerSize = leftPlayer.get_texture().get_size()
	
	#collidors for pads:
	var leftCollider = Rect2(leftPlayer.position - padSize * 0.5, padSize)
	var rightCollider = Rect2(rightPlayer.position - padSize * 0.5, padSize)
#	print(leftCollider)
#	print(leftPlayer.get_method_list())
	if(rightPlayer.position.y - rightPlayerSize.y/2 > 0  and Input.is_action_pressed("ui_up")):
		rightPlayer.position.y += -PADSPEED * delta
	if(rightPlayer.position.y + rightPlayerSize.y/2 < screenSize.y and Input.is_action_pressed("ui_down")):
		rightPlayer.position.y += PADSPEED * delta
	
	#left player Movements:
	if(leftPlayer.position.y - leftPlayerSize.y/2 > 0 and Input.is_action_pressed("left_up")):
		leftPlayer.position.y += -PADSPEED * delta
	if(leftPlayer.position.y + leftPlayerSize.y/2 < screenSize.y and Input.is_action_pressed("left_down")):
		leftPlayer.position.y += PADSPEED * delta
	
#	#ball movement:
#	print(ballDirection[0])
	ballPosition.position.x += ballDirection[0] * ballSpeed * delta
	ballPosition.position.y += ballDirection[1] * ballSpeed * delta

#	ball collision check:
	if(ballPosition.position.y < 0 and ballDirection[1] < 0) or (ballPosition.position.y > screenSize.y and ballDirection[1] > 0):
		ballDirection.y = -ballDirection.y
	
	if(leftCollider.has_point(ballPosition.position) or rightCollider.has_point(ballPosition.position)):
		ballDirection.x = -ballDirection.x
		ballDirection.y = (randf()-0.5)*2
		ballDirection = ballDirection.normalized()
		if(ballSpeed <= PADSPEED):
			ballSpeed *= 1.2
	
	if (ballPosition.position.x < 0):
		ballPosition.position = screenSize * 0.5
		ballSpeed = INITBALLSPEED
		rightScore += 1
	if (ballPosition.position.x > screenSize.x):
		ballPosition.position = screenSize * 0.5
		ballSpeed = INITBALLSPEED
		leftScore += 1
	
	get_node("LeftScore").set_text(str(leftScore))
	get_node("rightScore").set_text(str(rightScore))
	
#	print(get_method_list())
	
	
	