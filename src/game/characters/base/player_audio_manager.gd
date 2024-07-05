class_name AudioManager
extends Node2D

func play_sound(audio_stream):
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = audio_stream
	audio_player.bus = "sfx"
	add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(func(): audio_player.queue_free())
