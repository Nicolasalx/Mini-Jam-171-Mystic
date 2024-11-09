extends Node2D

var pressed_buttons = []

var buttons_level_1 = []
var buttons_level_2 = []
var buttons_level_3 = []

func _ready():
	await animation_level(5)
	second_level()

func second_level():
	print("GO TO LEVEL2")

func add_case_to_list(buttons_list):
	var random_number = randi_range(1, 5)
	var button_name = "TextureButton" + str(random_number)
	buttons_list.append(button_name)

func start_level():
	$TextureRect/Watch.visible = true
	$TextureRect/Play.visible = false	

func end_level():
	$TextureRect/Watch.visible = false
	$TextureRect/Play.visible = true

func create_animation_list(buttons_list):
	await get_tree().create_timer(2.0).timeout
	for button_name in buttons_list:
		var index = button_name.find("TextureButton")
		if index != -1:
			var number = button_name.substr(index + len("TextureButton"), button_name.length() - index - len("TextureButton"))
			var animationName = "Case_" + str(number) + "_Animation"
			$TextureRect/AnimationPlayer.play(animationName)
			await get_tree().create_timer(2.0).timeout
		else:
			print("No match for: ", button_name)

func animation_level(nb_case):
	await start_level()
	for i in range(nb_case):
		add_case_to_list(buttons_level_1)

	create_animation_list(buttons_level_1)
	await end_level()
	await enable_buttons(nb_case)

func enable_buttons(target_size: int):
	for button in $TextureRect.get_children():
		if button is TextureButton:
			button.connect("pressed", Callable(self, "_on_button_pressed").bind(button, target_size))

func _on_button_pressed(button, target_size):
	pressed_buttons.append(str(button.name))
	if pressed_buttons.size() == target_size:
		if pressed_buttons.duplicate() == buttons_level_1.duplicate():
			print("SAME")
			pressed_buttons.clear()
			return
		else:
			get_tree().change_scene_to_file("res://defeat_end.tscn")
		pressed_buttons.clear()
