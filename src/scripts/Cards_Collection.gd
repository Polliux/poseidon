extends Node
class_name Cards_Collection

static var path = "res://src/resources/Cards"
static var cards_collection: Dictionary = {}

static func load():
	for file in DirAccess.get_files_at(path):
		var resource_file = path + "/" + file
		var card = load(resource_file)
		cards_collection[file] = card
		

static func get_random_card_res():
	return cards_collection[cards_collection.keys().pick_random()]
