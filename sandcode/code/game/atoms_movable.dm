/atom/movable/proc/update_transform_holo()
	var/matrix/M = matrix()
	M.Scale(icon_scale_x, icon_scale_y)
	M.Turn(icon_rotation)
	src.transform = M

// Use this to set the object's scale.
/atom/movable/proc/adjust_scale(new_scale_x, new_scale_y)
	if(isnull(new_scale_y))
		new_scale_y = new_scale_x
	if(new_scale_x != 0)
		icon_scale_x = new_scale_x
	if(new_scale_y != 0)
		icon_scale_y = new_scale_y
	update_transform_holo()

/atom/movable/proc/adjust_rotation(new_rotation)
	icon_rotation = new_rotation
	update_transform_holo()

/atom/movable
	var/icon_scale_x = 1 // Used to scale icons up or down horizonally in update_transform_holo().
	var/icon_scale_y = 1 // Used to scale icons up or down vertically in update_transform_holo().
	var/icon_rotation = 0 // Used to rotate icons in update_transform_holo()
