extends Sprite2D

@onready var attack_rate = $AttackRate
@onready var hitbox_component = $HitboxComponent

var stats: MeleeWeaponStats
var player_stats: PlayerStats
var base_stats
var can_swing = true

func _ready():
	attack_rate.timeout.connect(func(): can_swing = true)

func set_up(b_stast:MeleeWeaponStats, p_stats: PlayerStats):
	base_stats = b_stast
	stats = b_stast
	player_stats = p_stats
	Events.wave_started.connect(update_stats.unbind(1))

func update_stats():
	stats.DAMAGE = base_stats.DAMAGE * player_stats.DAMAGE
	stats.ATTACK_RATE = base_stats.FIRE_RATE * player_stats.RATE
	stats.CRITICAL_CHANCE = base_stats.CRITICAL_CHANCE * player_stats.CRIT_CHANCE
	stats.CRITICAL_DAMAGE = base_stats.CRITICAL_DAMAGE * player_stats.CRIT_DAMAGE
	stats.RANGE = base_stats.RANGE * player_stats.RANGE
	
func attack():
	if !self.can_swing: return
	self.swing()
	
func swing():
	pass
	
