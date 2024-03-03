extends Node

	#var result = apply_l_system(axiom, iterations)
	#draw_l_system(result)

#func apply_l_system(input_str: String, iterations: int) -> String:
	#var result = input_str
	#for i in range(iterations):
		#result = iterate_l_system(result)
	#return result
#
#func iterate_l_system(input_str: String) -> String:
	#var output = ""
	#for symbol in input_str:
		#if rules.has(symbol):
			#output += rules[symbol]
		#else:
			#output += str(symbol)
	#return output
#
#func draw_l_system(l_system_result: String):
	#var current_position = Vector3(0, 0, 0)
	#var current_direction = Vector3(0, 1, 0)
#
	#for symbol in l_system_result:
		#match symbol:
			#"F":
				#move_forward()
				#result_str += symbol
			#"+":
				#rotate_right()
				#result_str += symbol
			#"-":
				#rotate_left()
				#result_str += symbol
			#"/":
				#roll_right()
				#result_str += symbol
			#"\\":
				#roll_left()
				#result_str += symbol
			#"^":
				#pitch_up()
				#result_str += symbol
			#"_":
				#pitch_down()
				#result_str += symbol
			#"[":
				#push_transform()
				#result_str += symbol
			#"]":
				#pop_transform()
				#result_str += symbol
			#_:
				#result_str += symbol
	#return result_str




#func move_forward():
	#var new_position = current_position + current_direction
	#draw_line(current_position, new_position)
	#current_position = new_position
#
#func rotate_right():
	#current_direction = current_direction.rotated(Vector3.UP, deg_to_rad(angle))
#
#func rotate_left():
	#current_direction = current_direction.rotated(Vector3.UP, deg_to_rad(-angle))
#
#func roll_right():
	#current_direction = current_direction.rotated(Vector3.FORWARD, deg_to_rad(angle))
#
#func roll_left():
	#current_direction = current_direction.rotated(Vector3.FORWARD, deg_to_rad(-angle))
#
#func pitch_up():
	#current_direction = current_direction.rotated(Vector3.RIGHT, deg_to_rad(angle))
#
#func pitch_down():
	#current_direction = current_direction.rotated(Vector3.RIGHT, deg_to_rad(-angle))
#
#var transform_stack : Array = []
#
#func push_transform():
	#pass
#
#func pop_transform():
	#pass

