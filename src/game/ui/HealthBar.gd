extends ProgressBar

var health = 0

func _ready():
	health = Global.player.HP
	value = health
	max_value = health
	
func _process(delta):
	if(!Global.player == null):
		value = Global.player.HP 
	else:
		value = 0
