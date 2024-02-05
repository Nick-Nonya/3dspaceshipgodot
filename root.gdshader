shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = fract(50.0 * vec3(UV.x, UV.y, 0.0) - vec3(0.5));
	
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
