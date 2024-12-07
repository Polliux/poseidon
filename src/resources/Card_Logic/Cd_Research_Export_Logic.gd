extends Card

func execute_check() -> bool:
	return true

func card_execute() -> bool:
	EventController.get_ui_control().modify_resource_value("ENERGY",5,1)
	return true

func on_draw_effect():
	pass
