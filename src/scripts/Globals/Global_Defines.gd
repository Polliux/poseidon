extends Node

# AUTOLOAD

const CARD_DRAW_PER_TURN: int = 5

const MAX_POLLUTION_STATE: int = 1000

const STARTING_RESOURCES: Dictionary = {
	"ENERGY" : 20,
	"SCIENCE" : 20,
	"PRODUCTION" : 20,
	"POLLUTION" : 0
}
const STARTING_DELTA: Dictionary = {
	"ENERGY": 2,
	"SCIENCE": 1,
	"PRODUCTION": 1,
	"POLLUTION": 1
}
