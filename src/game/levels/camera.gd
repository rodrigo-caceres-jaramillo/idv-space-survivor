extends Camera2D

const DEATH_ZONE = 200

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		var viewport_size = get_viewport().size
		var mouse_position = event.position
		var center = viewport_size * 0.5
		var target = mouse_position - center

		print("Mouse Position: ", mouse_position)
		print("Viewport Center: ", center)
		print("Target Vector: ", target)

		if target.length() < DEATH_ZONE:
			self.offset = Vector2(0, 0)
		else:
			var direction = target.normalized()
			var distance = target.length() - DEATH_ZONE
			var offset = direction * distance * 0.5
			self.offset = offset

		print("Offset: ", self.offset)
