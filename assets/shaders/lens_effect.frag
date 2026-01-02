#version 460 core

// Input from the vertex shader - the coordinate of the pixel in the texture
in vec2 v_textureCoordinates;

// The final color of the pixel
out vec4 out_color;

// The texture we're manipulating (the blurred background)
uniform sampler2D u_texture;

// The resolution of the button widget
uniform vec2 u_resolution;

// --- Lens Effect Parameters ---
// The radius of the lens effect, from 0.0 to 0.5
uniform float u_lens_radius; 
// How much to bend the light (the strength of the distortion)
uniform float u_refraction; 

void main() {
    // A 'uv' coordinate goes from 0.0 to 1.0, so the center is at (0.5, 0.5)
    vec2 uv = v_textureCoordinates;
    vec2 center = vec2(0.5, 0.5);
    
    // Vector from the center to the current pixel
    vec2 from_center = uv - center;
    
    // Distance from the center. length() is sqrt(x*x + y*y)
    float dist = length(from_center);
    
    // If the pixel is outside our lens radius, draw it normally without distortion
    if (dist >= u_lens_radius) {
        out_color = texture(u_texture, uv);
        return;
    }
    
    // This creates a smooth falloff at the edge of the lens instead of a sharp cutoff
    float smooth_factor = smoothstep(u_lens_radius, u_lens_radius * 0.1, dist);
    
    // This is the core logic:
    // We move the texture coordinate inwards, towards the center.
    // The amount we move it is based on the distance from the center and the refraction strength.
    vec2 distorted_uv = uv - normalize(from_center) * (dist * u_refraction) * smooth_factor;
    
    // Read the color from the original texture at the NEW, distorted coordinate
    out_color = texture(u_texture, distorted_uv);
}
