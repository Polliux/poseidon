extends Card

func execute_check() -> bool:
	return true

func card_execute() -> bool:
	EventController.get_ui_control().modify_resource_value("PRODUCTION",3,1)
	EventController.get_ui_control().modify_resource_value("SCIENCE",1,1)
	return true

func on_draw_effect():
	pass
