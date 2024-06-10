class_name StoreResource
extends Resource

enum ResourceTypes {
	WEAPON,
	ITEM,
	UPGRADE
}

@export var name: String
@export var description: String
@export var price: int
@export var icon: Texture2D
