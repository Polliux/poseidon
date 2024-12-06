class_name Yield

enum resource {
	ENERGY,
	SCIENCE,
	PRODUCTION,
	POLLUTION
}

static func zero_yields() -> Dictionary :
	var dict:Dictionary = {}
	for i in resource:
		dict[i] = 0
	return dict;
