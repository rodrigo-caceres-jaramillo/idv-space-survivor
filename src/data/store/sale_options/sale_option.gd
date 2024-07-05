class_name SaleOption
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

@export var rarity: Rarities
@export var price: int
@export var type: Types
@export var equipment: Equipment

