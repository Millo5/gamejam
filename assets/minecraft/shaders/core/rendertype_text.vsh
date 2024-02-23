#version 150

#moj_import <fog.glsl>
#moj_import <colours.glsl>
#moj_import <util.glsl>

#define PI 3.14159265

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;
uniform sampler2D Sampler0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform float GameTime;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out vec2 center;
out vec4 origColor;

float GameTimeSeconds = GameTime*1200;

void main() {

    origColor = Color;

    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

    int gui_scale = guiScale(ProjMat, ScreenSize);
    int id = gl_VertexID%4;

    // Get center location
    center = getCenter(Sampler2, id);
    center = gl_Position.xy + vec2(center.x/ScreenSize.x*gui_scale, center.y/ScreenSize.y*gui_scale);

    if (isShadow(Color, EFFECT)) {
        center += vec2(gui_scale*-2/ScreenSize.x, gui_scale*2/ScreenSize.y);
    }

    if (isEither(Color, EFFECT)) {

        // Sine wave

        //gl_Position.y += gui_scale*6*sin(GameTimeSeconds*-5 + center.x*60)/ScreenSize.y;

        // Shiver

        gl_Position.xy += vec2(
            gui_scale*2*rand(vec2(center.x+1,mod(GameTimeSeconds,PI)))/ScreenSize.x,
            gui_scale*2*rand(vec2(center.x,mod(GameTimeSeconds,PI)))/ScreenSize.y
        );

        // Epic RGB gaming PC
        //vec3 DisplayColor = vec3(mod((gl_Position.x + gl_Position.y - GameTimeSeconds/20)*2, 1.), 0.8, 0.8);
        vec3 DisplayColor = vec3(232., 2., 71);

        vertexColor = vec4(DisplayColor/255., 1.0);
        if (isShadow(Color, EFFECT)) {
            vertexColor = getShadow(DisplayColor);
        }
    }

    if (isEither(Color, CHROME)) {


        if (isColor(Color, CHROME)) {
            vertexColor = vec4(1., 1., 1., 0.);
        }

        if (isShadow(Color, CHROME)) {
            
            vec2 samplerRatio = vec2(1. / textureSize(Sampler0, 0).x, 1. / textureSize(Sampler0, 0).y);

            center = getCenter(Sampler2, id)/2.;

            center.x *= samplerRatio.x;
            center.y *= samplerRatio.y;

            center += UV0;

            switch (id){
                case 0:
                    texCoord0.x -= samplerRatio.x;
                    texCoord0.y -= samplerRatio.y;
                    gl_Position.x -= (gui_scale*4)/ScreenSize.x;
                    gl_Position.y += (gui_scale*4)/ScreenSize.y;
                    break;
                case 1:
                    texCoord0.x -= samplerRatio.x;
                    texCoord0.y += samplerRatio.y;
                    gl_Position.x -= (gui_scale*4)/ScreenSize.x;
                    break;
                case 2:
                    texCoord0.x += samplerRatio.x;
                    texCoord0.y += samplerRatio.y;
                    break;
                case 3:
                    texCoord0.x += samplerRatio.x;
                    texCoord0.y -= samplerRatio.y;
                    gl_Position.y += (gui_scale*4)/ScreenSize.y;
                    break;
            }
        }


    }
}
