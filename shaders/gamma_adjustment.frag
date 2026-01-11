#include <flutter/runtime_effect.glsl>

uniform sampler2D content;
uniform float power;
uniform vec2 size;

out vec4 fragColor;

void main() {
    vec2 coord = FlutterFragCoord().xy;
    vec4 color = texture(content, coord / size);
    color.r = pow(color.r, power);
    color.g = pow(color.g, power);
    color.b = pow(color.b, power);
    fragColor = color;
}
