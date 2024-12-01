extends Camera2D

#const MIN_CAMERA_X = -50
#const MAX_CAMERA_X = 700
#const MIN_CAMERA_Y = -100
#const MAX_CAMERA_Y = 1500

const FRAMERATE_CONST = 60
const ZOOM_MAX: Vector2 = Vector2(1.4,1.4)
const ZOOM_MIN: Vector2 = Vector2(0.6,0.6)
const ZOOM_INCREMENT: float = 0.2
const ZOOM_SPEED: float = 0.3 * FRAMERATE_CONST

const CAMERA_LERP_SPEED: float = 0.05 * FRAMERATE_CONST

var zoom_enabled = true
var zoom_cd: int = 10
var target_zoom: Vector2 = Vector2(1,1)

var target_position: Vector2

func _ready():
	pass

func _process(delta):
	zoom_cd = clampi(zoom_cd-1,0,10)
	
	# Target Position
	if not target_position.is_equal_approx(self.position):
		self.position = lerp(self.position,target_position,CAMERA_LERP_SPEED*delta)
			
	# Target Zoom
	if not target_zoom.is_equal_approx(self.zoom):
		if self.zoom < target_zoom:
			self.zoom = lerp(self.zoom,target_zoom,ZOOM_SPEED*delta)
			#print(self.zoom)
		elif self.zoom > target_zoom:
			self.zoom = lerp(self.zoom,target_zoom,ZOOM_SPEED*delta)
			#print(self.zoom)

func on_mousewheel(mousewheel_direction: int) -> void:
	# 1 -> UP, -1 -> DOWN
		
	if zoom_enabled and zoom_cd <= 0:
		if mousewheel_direction > 0 and target_zoom < ZOOM_MAX:
				target_zoom += Vector2(ZOOM_INCREMENT,ZOOM_INCREMENT)

		elif mousewheel_direction < 0 and target_zoom > ZOOM_MIN:
				target_zoom += Vector2(-ZOOM_INCREMENT,-ZOOM_INCREMENT)

		zoom_cd = 3

func mouse_drag_camera(vector:Vector2) -> void:
	target_position -= (2*vector)
	#target_position.x = clampf(target_position.x,MIN_CAMERA_X,MAX_CAMERA_X)
	#target_position.y = clampf(target_position.y,MIN_CAMERA_Y,MAX_CAMERA_Y)
