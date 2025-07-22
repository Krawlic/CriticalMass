shader_type particles;

uniform float spin_speed = 6.0;
uniform float pull_strength = 1.0;

void process(inout Particle particle) {
	vec2 pos = particle.position;
	vec2 to_center = -pos;
	float dist = length(to_center);

	if (dist > 0.0) {
		vec2 direction = normalize(to_center);
		vec2 tangent = vec2(-direction.y, direction.x);

		vec2 final_velocity = direction * pull_strength * dist + tangent * spin_speed;
		particle.velocity = final_velocity;
	}
}
