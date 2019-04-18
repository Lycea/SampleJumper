
globals ={}

function globals.default_ini()
    
end

objects = {}
player ={}

no_gravity = false

gravity = vector(0,10)
jump = vector(0,-7)
right = vector(4,0)
left = vector(-4,0)


scr_width=0
scr_height=0

game_state = 1

vel_dash = 12


last_keys ={}

dash_used = false
dash_time = 0.3
dash_timer = 0
cd_dash    = 0


--editor
selected_point = false  --first selected point
first_point = {x=0,y=0}




---debug stuff

string_list_distances ={}

dash_lines ={}


