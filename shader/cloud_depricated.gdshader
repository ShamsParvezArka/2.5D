shader_type spatial;

uniform sampler2D noise_texture : repeat_enable;
uniform float speed : hint_range(0.0, 2.0) = 0.1;

void fragment() {
    // Move UV horizontally
    vec2 uv_update = fract(UV + vec2(TIME * speed, 0.0));

    // Sample texture
    vec4 tex = texture(noise_texture, uv_update);

    // Output
    ALBEDO = tex.rgb;
    ALPHA = tex.a; // or 1.0 if fully opaque
}
