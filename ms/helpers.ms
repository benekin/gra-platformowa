// keep a value within a set range
// utrzymuj wartość w ustalonym zakresie
//potrzebna do kamery
clamp = function(value, lower_limit, upper_limit)
  local val = max(value, lower_limit)
  val = min(val, upper_limit)
  return val
end

// calculate the grid position of a specific x value in the world
// oblicz pozycję siatki określonej wartości x na świecie
// xPosToGrid = function(x, map_columns, map_draw_width)
//   local column_draw_width = map_draw_width / map_columns
//   return floor((x + map_draw_width / 2) / column_draw_width)
// end

// // calculate the grid position of a specific y value in the world
// yPosToGrid = function(y, map_rows, map_draw_height)
//   local row_draw_height = map_draw_height / map_rows
//   return floor((y + map_draw_height / 2) / row_draw_height)
// end

///////to jest wykorzystywane do okreslenia do pojawiania się wrogow i itemow na mapie
xMapToPos = function(x)
  local column_draw_width = level.map_width / level.map.width
  return x * column_draw_width - level.map_width / 2
end

yMapToPos = function(y)
  local column_draw_height = level.map_height / level.map.height
  return y * column_draw_height - level.map_height / 2 
end


//// obliczanie dystansow przeciwników od siebie
dist = function(x1, y1, x2, y2)
  return sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

// discover the name of the sprite portion at an (x, y) position in the world
// odkryj nazwę części duszka na pozycji (x, y) na świecie
checkCollisionExt = function(x, y, map, map_draw_width, map_draw_height)
  local grid_x = floor((x + map_draw_width / 2) / (map_draw_width / maps[map].width))
  local grid_y = floor((y + map_draw_height / 2) / (map_draw_height / maps[map].height))
  return maps[map].get(grid_x, grid_y)
end


//wykrywanie kolizji np z drabiona
checkCollision = function(x, y, name)
  local check = checkCollisionExt(x, y, level.map_name, level.map_width, level.map_height)
  if check.startsWith then
    return check.startsWith(name)
  end
end
///sprawdzenie  elemntu na jakim jest gracz
checkMap = function(x, y, name)
  local check = level.map.get(x, y)
  if check.startsWith then
    return check.startsWith(name)
  end
end

// moveToward = function(current_value, target, amount)
//   local new_value = 0
//   if current_value == target then
//     new_value = current_value
//   elsif current_value < target then
//     new_value = current_value + amount
//     if new_value > target then new_value = target end
//   elsif current_value > target then
//     new_value = current_value - amount
//     if new_value < target then new_value = target end  
//   end
//   return new_value
// end

// getFlashValue = function(seconds_per_flash = 1.5)
//   return pow(cos(system.time()/1000*PI/seconds_per_flash), 2) * 0.6 + .4
// end
/////////do rysowania
playSprite = function(sprite, x, y, w, h, t)
  if not h then h = w end
  if not t then t = time end
  
  local frames = sprites[sprite].frames.length
  local fps = sprites[sprite].fps
  
  local frame = floor((t / (60 / fps)) % frames)
  screen.drawSprite(sprite + "." + frame, x, y, w, h)
end
//////
// getFrame = function(sprite, t)
//   if not t then t = time end
  
//   local frames = sprites[sprite].frames.length
//   local fps = sprites[sprite].fps
  
//   return floor((t / (60 / fps)) % frames)
// end



///funkcja od fizyki
//pozrbana aby postaci mogly wykryc kolizje z podlozem
charPhysics = function(char, top, bottom, left, right)
  //rozmiar bloku
  local cell_size = 16
  //jesli postac sie nie wspina
  if not char.climbing then
    // x_velocity smoothing
    // plynnosc porusznia sie
    char.x_velocity *= .85
    // if char.x_velocity > -0.05 and char.x_velocity < 0.05 then
    //   char.x_velocity = 0
    // end
    // gravity
    char.y_velocity -= .2
    // if char.y_velocity < -char.max_fall_speed then char.y_velocity = -char.max_fall_speed end
  end
  
  // local map = level.map
  // print(map)
  local hw = level.map_width / 2    // half level map width in pixels
  local hh = level.map_height / 2  // half level map height

  // define the map grid squares where each of the four corners of the invisible
  // hit box for the player is - both for current (old) position and 
  // desired new position based on velocity
  // zdefiniuj kwadraty siatki mapy, w których każdy z czterech rogów niewidzialnego
  // hit box dla gracza to - zarówno dla obecnej (starej) pozycji, jak i
  // pożądana nowa pozycja w oparciu o prędkość
  local old_top = floor((char.y + top + hh) / cell_size)
  local old_bottom = floor((char.y - bottom + hh) / cell_size)
  local old_right = floor((char.x + right + hw) / cell_size)
  local old_left = floor((char.x - left + hw) / cell_size)
  

  local new_top = floor((char.y + char.y_velocity + top + hh) / cell_size)
  local new_bottom = floor((char.y + char.y_velocity - bottom + hh) / cell_size)
  local new_right = floor((char.x + char.x_velocity + right + hw) / cell_size)
  local new_left = floor((char.x + char.x_velocity - left + hw) / cell_size)

  // falling

  if char.y_velocity < 0 and 
    (checkMap(old_left, new_bottom, "wall") or checkMap(old_right, new_bottom, "wall3")) then
    char.y = -hh + (new_bottom + 1) * cell_size + bottom
    /// jesli tego nie ma to spadaja na dol
    char.y_velocity = 0
    // bez tego nie mozna skoczyc
    char.landed = true
    
    
    
  // jumping

    elsif char.y_velocity > 0 and 
    (checkMap(old_left, new_top, "wall") or checkMap(old_right, new_top, "wall")) then
    char.y_velocity = 0
  else
    //jesli sie nie spindram skok jest falszem czyli spada w dol
    if not char.climbing then char.landed = false end
  end


//////kolizja z boxami od boku zeby nie przenikac
  // moving left
  //jesli kolizja z lewej to velocity 0
  if char.x_velocity < 0 and 
    (checkMap(new_left, old_bottom, "wall") or checkMap(new_left, old_top, "wall")) then
    char.x_velocity = 0
    // char.x = -hw + (new_left+1) * cell_size + left
  // moving right
  elsif char.x_velocity > 0 and 
    (checkMap(new_right, old_bottom, "wall") or checkMap(new_right, old_top, "wall")) then
      
    char.x_velocity = 0
    // char.x = -hw + (new_right) * cell_size - right
  end
  
  // actually move the player
  //aktualner polozenie gracza
  char.x += char.x_velocity
  char.y += char.y_velocity
  
  // handle player falling off screen (always into the ocean and treated as a "death")
  //poradzić sobie z wypadnięciem gracza z ekranu (zawsze do oceanu i traktowany jako „śmierć”)
  if char.y < (-level.map_height/2 - 100) then
    char.respawn()
  end
  

end



