extends Enemy

@onready var move_to_target_component = $MoveToTargetComponent

func _ready():
	super()
	move_to_target_component.target = Global.player
