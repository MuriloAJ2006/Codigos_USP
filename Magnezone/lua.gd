@tool
extends Light3D

# Arraste o DirectionalLight3D do Sol para cá
@export var sol: DirectionalLight3D
@export var limite_luz_sol: float = 0.4

func _process(_delta: float) -> void:
	if sol == null:
		return

	# Acende a lua se o sol estiver desligado ou fraco
	visible = (not sol.visible) or (sol.light_energy < limite_luz_sol)
