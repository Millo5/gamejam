#version 150

#moj_import <fog.glsl>
#moj_import <colours.glsl>

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

in vec2 center;
in vec4 origColor;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;


    if (isShadow(origColor, CHROME)) {

        vec2 samplerRatio = vec2(1. / textureSize(Sampler0, 0).x, 0.625 / textureSize(Sampler0, 0).y);

        vec2 offset = vec2(0.5, 0);

        offset.x *= samplerRatio.x;
        offset.y *= samplerRatio.y;

        vec2 coord = texCoord0 + offset;
        
        color.rgb = vec3(1., 0., 0.);

        vec2 bounds = textureSize(Sampler2, 0)/4.;
        bounds.x *= samplerRatio.x;
        bounds.y *= samplerRatio.y;
        bounds = step(center-bounds, coord) - step(center+bounds, coord);
        color.a *= bounds.x * bounds.y;

    }

    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
