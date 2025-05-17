shader_type canvas_item;

uniform float fever_intensity : hint_range(0.0, 1.0) = 0.0;
uniform float scroll_offset;
uniform bool is_grb;
uniform float alpha : hint_range(0.0, 1.0) = 1.0;

void vertex() {
	UV.x += scroll_offset;
}

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
	vec3 darkened_color = original_color.rgb / (1.0 + original_color.rgb);
	vec3 inverted_color = is_grb ? darkened_color.grb : darkened_color.bgr;
    vec3 final_rgb = mix(darkened_color, inverted_color, fever_intensity);
    COLOR = vec4(final_rgb, alpha);
}