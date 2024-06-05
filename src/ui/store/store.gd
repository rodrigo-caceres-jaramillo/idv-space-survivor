extends CanvasLayer

@onready var player_stats = $MarginContainer/StoreContainer/LeftContainer/PlayerStats
@onready var weapon_stats = $MarginContainer/StoreContainer/RigthContainer/WeaponStats

func _ready():
	player_stats.set_up("PLAYER", Global.player.stats)
	weapon_stats.set_up("WEAPON", Global.weapon_selected.stats)
