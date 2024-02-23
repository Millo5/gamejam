#version 150

#define TOOLTIP_Z -0.04000008

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;
out float modify;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    vec4 position = gl_Position;
    modify = 0.0;
    if (position.z == TOOLTIP_Z) {
        if (position.y > 1 || position.y < -0.99) {modify = 1.0;}
        else {modify = 2.0;}    
    }
    vertexColor = Color;
}