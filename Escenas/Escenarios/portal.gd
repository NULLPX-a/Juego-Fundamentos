extends Node2D

@export var portal_id: int = 0

var target_portal: Node2D = null
var can_teleport := true

func _ready() -> void:
	var portals = get_tree().get_nodes_in_group("portal")

	for portal in portals:
		if portal != self and portal.portal_id == portal_id:
			target_portal = portal
			break

	if target_portal == null:
		push_error("No se encontró portal destino con ID: " + str(portal_id))


func _on_area_teletransport_area_entered(area: Area2D) -> void:
	if not can_teleport:
		return

	var body = area.get_parent()

	if body and body.is_in_group("virtual") and target_portal:
		teleport(body)


func teleport(body: Node2D) -> void:
	can_teleport = false
	
	# Teletransportar al otro portal (mejor usar global_position)
	body.global_position = target_portal.global_position
	
	# Bloquear también el otro portal para evitar rebote
	target_portal.can_teleport = false
	
	await get_tree().create_timer(0.3).timeout
	
	can_teleport = true
	target_portal.can_teleport = true
