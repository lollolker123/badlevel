extends Area2D




func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "badlik":
		body.applyDMG(10)
		pass



	
