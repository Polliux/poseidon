extends Card

func execute_check() -> bool:
	return true

func card_execute() -> bool:
	exhaust	= true
	return true

func on_draw_effect():
	EventController.get_ui_control().modify_resource_value("PRODUCTION",2,-1)
