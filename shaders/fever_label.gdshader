shader_type canvas_item;

uniform float spiral_progress : hint_range(0.0, 1.0) = 0.0;
uniform float text_progress : hint_range(0.0, 1.0) = 0.0;
uniform float initial_spiral_speed : hint_range(0.0, 100.0) = 25.0;
uniform float initial_scale : hint_range(1.0, 35.0) = 8.0;
uniform vec4 text_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec2 centered_uv = UV - 0.5;
	float smooth_progress = smoothstep(0.0, 1.0, spiral_progress);
	float radius = length(centered_uv);
	float theta = atan(centered_uv.y, centered_uv.x);

	float current_spin = mix(initial_spiral_speed, 0.0, smooth_progress);
	float current_scale = mix(initial_scale, 1.0, smooth_progress);

	radius *= current_scale;
	theta -= current_spin;

	vec2 cartesian_uv = (vec2(cos(theta), sin(theta)) * radius) + 0.5;
	vec4 color = texture(TEXTURE, cartesian_uv);
	color.a *= smoothstep(0.5, 1, spiral_progress - 0.2);

	if (text_progress > 0.0) {
		color.rgb *= mix(color.rgb, text_color.rgb, text_progress);
    }
	COLOR = color;
}