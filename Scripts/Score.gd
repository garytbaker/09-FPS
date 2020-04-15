extends Label


var Score = 0
var won = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	Score +=1
	text=str(Score)
	if !won:
		$"../Timer".start()
	if won:
		text = "YOU WON IN "+str(Score)+" SECONDS!"
