extends Node





func _on_load_mods_button_pressed():
	var mods_dir_path = OS.get_executable_path().get_base_dir().path_join("mods")
	var mod_dir = DirAccess.open(mods_dir_path)
	mod_dir.list_dir_begin()
	var modname = mod_dir.get_next()
	while modname != "":
		if modname.get_extension() == "pck":
			ProjectSettings.load_resource_pack(modname)
			var imported_scene = load("res://mod.tscn")
			get_tree().root.add_child(imported_scene)
		modname.get_next()
	mod_dir.list_dir_end()
