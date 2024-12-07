extends Node
class_name Ost_Collection

static var path = "res://asset/ost/"
static var ost_collection: Dictionary = {}

static func load():
	if ost_collection.is_empty():
		var arr = [
			"res://asset/ost/4 - Singn Em.mp3",
			"res://asset/ost/11 - Fire In The Brain.mp3",
			"res://asset/ost/19 - Back In Business.mp3",
			"res://asset/ost/blues.mp3",
			"res://asset/ost/n02 Groundhog.mp3",
			"res://asset/ost/n04 Redman.mp3",
			"res://asset/ost/n05 Old Habits.mp3"
		]
		for i in arr:
			ost_collection[i] = load(i)

static func get_random_ost_res():
	return ost_collection[ost_collection.keys().pick_random()]
