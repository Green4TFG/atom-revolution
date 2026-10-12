shader_type canvas_item;
uniform float thick = 2.0; //uniform allows us to shange the parameter in the material
void fragment() {
    //mask
    vec2 size = TEXTURE_PIXEL_SIZE * thick;
    float outline = 0.0;
    outline += texture(TEXTURE, UV + vec2(-size.x,0)).a; //This line looks at the position of the closest neighbros and checks the transparency
    outline += texture(TEXTURE, UV + vec2(size.x,0)).a;
    outline += texture(TEXTURE, UV + vec2(0,-size.y)).a;
    outline += texture(TEXTURE, UV + vec2(0,size.y)).a;
    
    outline += texture(TEXTURE, UV + vec2(-size.x,size.y)).a; //diagonal pixels, makes it look less ugly
    outline += texture(TEXTURE, UV + vec2(size.x,size.y)).a;
    outline += texture(TEXTURE, UV + vec2(-size.x,-size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x,-size.y)).a;
    
    outline += texture(TEXTURE, UV + vec2(-size.x,size.y*0.5)).a; //Half pixels to also make it look not ugly
    outline += texture(TEXTURE, UV + vec2(size.x,size.y*0.5)).a;
    outline += texture(TEXTURE, UV + vec2(-size.x,-size.y*0.5)).a;
    outline += texture(TEXTURE, UV + vec2(size.x,-size.y*0.5)).a;
    
    outline = step(1, outline);
    float alpha = texture(TEXTURE,UV).a;
    
    if(alpha > 0.5){
        COLOR = texture(TEXTURE,UV);
    } else if(outline > 0.5){
        COLOR = vec4(70.0/255.0, 75.0/255.0, 140.0/255.0, 1.0);
    } else {
        COLOR = vec4(0);
    }

}
