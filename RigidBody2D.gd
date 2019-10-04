extends RigidBody2D
onready var linked_to:Node2D = get_node(linked_path)

export var linked_path: = NodePath()
export var chain_length = 50

onready var chain = linked_to.position - position


func _integrate_forces(state):
	var xform = state.get_transform()
	if (linked_to.position - position).length() > chain_length:
		
		chain = linked_to.position - position
		chain = chain.clamped(chain_length)
		
		xform.origin.x = clamp(xform.origin.x, linked_to.position.x-abs(chain.x), linked_to.position.x+abs(chain.x))
		xform.origin.y = clamp(xform.origin.y, linked_to.position.y-abs(chain.y), linked_to.position.y+abs(chain.y))
		
		state.set_transform(xform)
		
	if (linked_to.position - position).length() > chain_length:
		
		var impulse_strength = 0
		if linked_to is RigidBody2D:
			impulse_strength = linked_to.linear_velocity.length()
		if linked_to is KinematicBody2D:
			impulse_strength = 100
		#print(impulse_strength)
		apply_impulse(Vector2.ZERO, chain.normalized()*impulse_strength*0.5)


