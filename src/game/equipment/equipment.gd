class_name Equipment
extends Resource

enum Types {
	WEAPON,
	UPGRADE
}

enum Rarities {
	COMMON,
	RARE,
	EPIC,
	LEGENDARY
}
@export var name: String
@export var icon: Texture
@export var description: String
@export var rarity: Rarities
@export var price: int
