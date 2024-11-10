extends StaticBody2D

@export_enum("Up","Down","Right","Left") var fly_direction

func fly():
	match fly_direction:
		"Up":
			velocity = Vector2.UP
