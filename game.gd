extends Node2D

var pressed_buttons = []
var buttons_level = []
var level_completed = false

var nb_case_level_1 = 5;
var nb_case_level_2 = 7;

func _ready():
	await main()

func main():
	await animation_level(nb_case_level_1)
	while not level_completed:
		await get_tree().process_frame
	await animation_level(nb_case_level_2)

func add_case_to_list(buttons_list):
	var random_number = randi_range(1, 5)
	var button_name = "TextureButton" + str(random_number)
	buttons_list.append(button_name)

func start_level():
	$TextureRect/Watch.visible = true
	$TextureRect/Play.visible = false
	$TextureRect/LevelUp.visible = false

func end_level(nb_case):
	$TextureRect/Watch.visible = false
	$TextureRect/Play.visible = true
	enable_buttons(nb_case)

func create_animation_list(buttons_list, nb_case):
	await get_tree().create_timer(2.0).timeout
	for button_name in buttons_list:
		var index = button_name.find("TextureButton")
		if index != -1:
			var number = button_name.substr(index + len("TextureButton"), button_name.length() - index - len("TextureButton"))
			var animationName = "Case_" + str(number) + "_Animation"
			$TextureRect/AnimationPlayer.play(animationName)
			await get_tree().create_timer(2.0).timeout
	end_level(nb_case)

func animation_level(nb_case):
	await start_level()
	for i in range(nb_case):
		add_case_to_list(buttons_level)
	await create_animation_list(buttons_level, nb_case)

func enable_buttons(target_size: int):
	for button in $TextureRect.get_children():
		if button is TextureButton:
			button.connect("pressed", Callable(self, "_on_button_pressed").bind(button, target_size))

func _on_button_pressed(button, target_size):
	if (level_completed):
		target_size = nb_case_level_2;
	pressed_buttons.append(str(button.name))
	if pressed_buttons.size() == target_size:
		if pressed_buttons.duplicate() == buttons_level.duplicate():
			pressed_buttons.clear()
			buttons_level.clear()
			$TextureRect/AnimationPlayer.play("level_up")
			level_completed = true
			if (target_size == nb_case_level_2):
				get_tree().change_scene_to_file("res://victory_end.tscn")
		else:
			get_tree().change_scene_to_file("res://defeat_end.tscn")
		pressed_buttons.clear()
