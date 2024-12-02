extends Node
class_name Ost_Collection

static var path = "res://asset/ost/"
static var ost_collection: Dictionary = {}

static func load():
	for file in DirAccess.get_files_at(path):
		if file.containsn("import"):
			continue
		var resource_file = path + "/" + file
		var ost = load(resource_file)
		ost_collection[file] = ost
		
	print(ost_collection)

static func get_random_ost_res():
	return ost_collection[ost_collection.keys().pick_random()]
