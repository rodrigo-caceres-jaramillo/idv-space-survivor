class_name RangedEnemyWeaponStats
extends Resource

enum Type {PRIMARY, SECONDARY}
@export var type: Type
@export var DAMAGE: float = 5
@export var DAMAGE_TYPE: DamageType
@export var MULTISHOT: float = 1.0
@export var FIRE_RATE: float = 1.0
@export var RELOAD: float = 1
@export var RANGE: float = 20.0
@export var KNOCKBACK: int = 1
@export var SPREAD: float = 0.0
@export var PROJECTILE_SPEED: float = 1000.0
var CRITICAL_CHANCE= 0.0
var CRITICAL_DAMAGE = 1.0
var PENETRATION= 0
