extends Node
class_name Cards_Collection

static var path = "res://src/resources/Cards"
static var cards_collection: Dictionary = {}
static var issue_cards: Array = []

static func load():
	
	if cards_collection.is_empty():
		for file in DirAccess.get_files_at(path):
			var resource_file = path + "/" + file
			var card = load(resource_file)
			cards_collection[file] = card
			if card.card_type == 1:
				if issue_cards.find(file) == -1:
					issue_cards.append(file)
		
	print(issue_cards)

static func get_random_card_res():
	return cards_collection[cards_collection.keys().pick_random()]

static func get_random_issue_card_res():
	return cards_collection.get(issue_cards.pick_random())
	
static func get_card_collection():
	return cards_collection

static func get_start_deck():
	var dict:Dictionary = {
		"res://src/resources/Cards/Energy_Export.tres":3,
		"res://src/resources/Cards/Research_Export.tres":3,
		"res://src/resources/Cards/Windmill.tres":2,
		"res://src/resources/Cards/Ground_Solar.tres":2,
		"res://src/resources/Cards/Light_Industry.tres":2,
		"res://src/resources/Cards/Town.tres":2,
		"res://src/resources/Cards/Energy_Shortage.tres":1,
		"res://src/resources/Cards/Enviromental_Apathy.tres":1,
		"res://src/resources/Cards/Flood.tres":1,
		"res://src/resources/Cards/Heat_Wave.tres":1
	}
	return dict
