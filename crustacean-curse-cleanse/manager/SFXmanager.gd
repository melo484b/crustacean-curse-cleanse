class_name SFXmanager
extends Node


signal play_complete


var playable: Array = []
var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	for stream in get_children():
		stream.connect("finished", self, "complete")


func play() -> void:
	for stream in get_children():
		if !stream.playing:
			playable.append(stream)

	var index = rng.randi_range(0, playable.size() - 1)
	if !playable.empty():
		playable[index].play()
		playable.remove(index)


func complete() -> void:
	emit_signal("play_complete")
