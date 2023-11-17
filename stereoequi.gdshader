shader_type spatial;
render_mode unshaded,depth_draw_opaque;

uniform sampler2D equirect:source_color;
uniform bool stereoscopic;
uniform bool stereo_left_on_top;
uniform bool stereo_left_only;

void vertex() {
}

void fragment() {
	vec4 albedo;
	float left_offset;
	float right_offset;
	if (stereo_left_on_top) {
		left_offset = 0.0;
		right_offset = 0.5;
	} else {
		left_offset = 0.5;
		right_offset = 0.0;		
	}
	if (stereoscopic) {
		if (VIEW_INDEX == VIEW_MONO_LEFT) {
			albedo = texture(equirect, vec2(1.0-UV.x, UV.y*0.5 + left_offset  ));
		} else if (VIEW_INDEX == VIEW_RIGHT) {
			albedo = texture(equirect, vec2(1.0-UV.x, UV.y*0.5 + right_offset )); //vec4(0.0,1.0,0.0,1.0);//
		}
		ALBEDO = albedo.xyz;
		ALPHA = albedo.a;
	} else if (stereo_left_only) {
		albedo = texture(equirect, vec2(1.0-UV.x, UV.y*0.5 + left_offset  ));
		ALBEDO = albedo.xyz;
		ALPHA = albedo.a;
	} else {
		albedo = texture(equirect,vec2(1.0-UV.x, UV.y));
		ALBEDO = albedo.xyz;
		ALPHA = albedo.a;
	}

}
