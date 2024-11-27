class_name Yield

enum resource {
	ENERGY,
	SCIENCE,
	PRODUCTION
}

static func zero_yields() -> Dictionary :
	var dict:Dictionary = {}
	for i in resource:
		dict[i] = 0
	return dict;
