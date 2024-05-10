extends Label

var money = 0

func _process(delta):
	self.text = str(Global.money)
