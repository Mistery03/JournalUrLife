class_name StickyNote
extends NinePatchRect

@onready var title: LineEdit = $VBoxContainer/Title
@onready var date: Label = $VBoxContainer/Date
@onready var select_box: CollisionShape2D = $Interact/SelectBox

var selected:bool = false
var mouseOffset:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var currentDate = Time.get_date_dict_from_system()
	date.text = str(currentDate["day"]) + "/" + str(currentDate["month"]) + "/" + str(currentDate["year"])
	select_box.shape.size = size
	select_box.position = Vector2(size/2)

func _process(delta: float) -> void:
	if selected:
		followMouse()

func followMouse()->void:
	position = get_global_mouse_position() + mouseOffset

func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouseOffset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false

func _on_resized() -> void:
	select_box.shape.size = size
	select_box.position = Vector2(size/2)
