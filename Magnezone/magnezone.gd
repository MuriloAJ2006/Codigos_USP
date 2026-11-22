@tool
extends Node3D

# Arraste o DirectionalLight3D (sol da cena) para ca
@export var sol: DirectionalLight3D

# Listas para colocar todas as SpotLight3D e pecas que brilham
@export var lanternas: Array[Light3D] = []
@export var pecas_brilhantes: Array[MeshInstance3D] = []

@export var limite_luz_sol: float = 0.4
@export var forca_brilho_noite: float = 1.5

func _process(_delta: float) -> void:
	if sol == null:
		return

	# Verifica se o sol esta desligado ou fraco (noite/escuro)
	var esta_escuro: bool = (not sol.visible) or (sol.light_energy < limite_luz_sol)

	# 1. Liga ou desliga todas as SpotLight3D
	for luz in lanternas:
		if luz != null:
			luz.visible = esta_escuro

	# 2. Acende ou apaga o Emission de todas as pecas da lista
	for peca in pecas_brilhantes:
		if peca == null:
			continue
		var mat = peca.get_surface_override_material(0)
		if mat != null:
			mat.emission_energy_multiplier = forca_brilho_noite if esta_escuro else 0.0
