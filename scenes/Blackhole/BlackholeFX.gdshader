shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture;
uniform float intensity : hint_range(0.0, 1.0) = 0.0;
uniform vec2 screen_size;

void fragment() {
	vec2 uv = SCREEN_UV;
	
	float offset = intensity * 0.01;
	
	float r = texture(screen_tex, uv + vec2(offset, 0.0)).r;
	float g = texture(screen_tex, uv).g;
	float b = texture(screen_tex, uv - vec2(offset, 0.0)).b;
	
	COLOR = vec4(r, g, b, 1.0);
}