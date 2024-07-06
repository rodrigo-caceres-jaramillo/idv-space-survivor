class_name Upgrade
extends Equipment

enum UpgradeTypes {
	character,
	weapon,
}

@export var type = Types.UPGRADE
@export var modifiers: Array[Modifier]
@export var upgrade_type: UpgradeTypes

