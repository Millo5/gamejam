#version 150

in vec4 vertexColor;
in float modify;

uniform vec4 ColorModulator;

out vec4 fragColor;

void main() {

    vec4 color = vertexColor;
    if (color.a == 0.0) {discard;}

    if (modify == 2.0) {
        // code snippet from https://modrinth.com/resourcepack/bettertooltip/versions
        /* set tooltip background rgba (vec4) */
        if ( color.r == 16/255.0 && color.g == 0/255.0 && color.b == 16/255.0 ) {
            //color = vec4(0,0,0,0);
            }

        /* set tooltip border rgba (vec4) */
        if ( color.r >= 0.15686 && color.r <= 0.31373 && color.g == 0 && color.b >= 0.49 && color.b <= 1 ) { 
            //color = vec4(0,0,0,0);
            } 
    }
    else if (modify == 1.0) {discard;} 
    fragColor = color * ColorModulator;
}