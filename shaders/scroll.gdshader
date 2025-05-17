shader_type canvas_item;

uniform float speed = 0.1;
uniform float wave_amount = 0.1;
uniform float wave_speed = 0.2;

void vertex() {
	UV.x += -TIME * speed;
	UV.y += sin(UV.x * wave_amount + TIME * wave_speed) * 2.0;
}
