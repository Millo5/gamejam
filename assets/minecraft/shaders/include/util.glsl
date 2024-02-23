vec2 guiPixel(mat4 ProjMat) {
    return vec2(ProjMat[0][0], ProjMat[1][1]) / 2.0;
}

int guiScale(mat4 ProjMat, vec2 ScreenSize) {
    return int(round(ScreenSize.x * ProjMat[0][0] / 2));
}

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

vec2 getCenter(sampler2D sampler, int id){
    vec2 shift = textureSize(sampler, 0)/2.;
    switch(id){
        case 0:
            shift.y *= -1.;
            return shift;
            break;
        case 1:
            return shift;
            break;
        case 2:
            shift.x *= -1.;
            return shift;
            break;
        case 3:
            return -shift;
            break;
    }
}