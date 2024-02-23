#define EFFECT vec3(112., 94., 48.) // #705e30
#define CHROME vec3(112., 94., 80.) // #705e50
#define T vec3(76., 64., 22.) // #4C4016 T for transparent

bool isColor(vec4 originColor, vec3 color) {
    return (originColor*255.).xyz == color;
}

vec4 getShadow(vec3 color) {
    return vec4(floor(color / 4.) / 255., 1);
}

bool isShadow(vec4 originColor, vec3 color) {
    return originColor.xyz == getShadow(color).xyz;
}

bool isEither(vec4 originColor, vec3 color) {
    return isShadow(originColor, color) || isColor(originColor, color);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}