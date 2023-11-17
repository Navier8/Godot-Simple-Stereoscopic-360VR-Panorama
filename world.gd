extends Node3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("Native mobile")
	if xr_interface and xr_interface.initialize():
		print("Native mobile initialised successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("Native mobile not initialized")
