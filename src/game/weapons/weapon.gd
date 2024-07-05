class_name Weapon
extends Equipment

enum WeaponTypes {
	PRIMARY=1,
	SECONDARY=2,
}

@export var weapon_scene: PackedScene
@export var stats: RangeWeaponsStats
@export var weapon_type: WeaponTypes
