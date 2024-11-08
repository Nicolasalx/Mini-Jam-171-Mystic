extends Node2D

func _ready():
	await animation_level_1()
	# Selection of level 1
	# animation_level_2() 
	# Selection of level 2 
	# animation_level_3() 
	# Selection of level 3

func animation_level_1():
	await get_tree().create_timer(2.0).timeout
	$TextureRect/AnimationPlayer.play("Case_1_Animation")
	await get_tree().create_timer(2.0).timeout
	$TextureRect/AnimationPlayer.play("Case_2_Animation")
	await get_tree().create_timer(2.0).timeout
	$TextureRect/AnimationPlayer.play("Case_3_Animation")
	await get_tree().create_timer(2.0).timeout
	$TextureRect/AnimationPlayer.play("Case_4_Animation")
	await get_tree().create_timer(2.0).timeout
	$TextureRect/AnimationPlayer.play("Case_5_Animation")
