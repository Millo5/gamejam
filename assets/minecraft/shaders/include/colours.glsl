#define T vec3(76., 64., 22.) // #4C4016 T for transparent

// Checks if a colour with RGBA is equal to a colour with RGB
bool isColor(vec4 originColor, vec3 color) {
    return (originColor*255.).xyz == color;
}

vec4 getShadow(vec3 color) {
    return vec4(floor(color / 4.) / 255., 1);
}

bool isShadow(vec4 originColor, vec3 color) {
    return originColor.xyz == getShadow(color).xyz;
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}