  
finishGame = function()
  won = 1
  player.stock=0
  arrow_stock=0
end
ammunition = function()
  ammu = 1
end 
infobo = function()
  infob = 1
end
infobla = function()
  infobl = 1
end
infoam = function()
  infoa = 1
end
infonoi = function()
  infono = 1
end
infonin = function()
  infoni = 1
end
infonochi = function()
  infonoch = 1
end
actions = object
  blade = function()
    finishGame()
  end
  blade1 = function()
    finishGame()
  end
  blade2 = function()
    finishGame()
  end
  glass = function()
    player.check=true
  end
  newlevel = function()
    setLevel(level.number + 1)
      respawnPlayer()
  end
  power = function()
    powerchidori=true
  end

  infoboom = function()
    infobo()
  end
  
  infoblade = function()
    infobla()
  end
  infoammo = function()
    infoam()
  end
  infoninja = function()
    infonin()
  end
  infonoice = function()
    infonoi()
  end
  infochidori = function()
    infonochi()
  end
end

init = function()



  zycieboss=10
  this.czas=0
  //ustawienie ciala
  bodies = []
  draw_bodies = false
  player = new PlayerClass()
  //tablica pociskow
  bullets = []
  touchKeys.arrows = not system.inputs.keyboard
  initPlayer()
  initCamera()
  initGameTimer()
  level_complete = false
  //ustawienie levela
  setLevel(1)
  respawnPlayer()
  // respawn()
  mode = 1        // 1 - play, 2 - end screen

  game_started = false
  // overlay_alpha_target = 0.75

end

update = function()
  //ustawienie mapy potrzebne aby przejsc do nastepnego lvla
  mapName = "level"+level.number


    updateGameplay()

  if player.stock>0 then
  arrow_stock =  player.stock-1
  end
  
  //do dead
  if not won then/////////////do kolizji z elementami
    local cell = getInteraction()
    if cell then
      ///////////////jesli zachodzi interakcja to wywolaj funkcje z elementeem ktorym zachoidzi interakcja
      actions[cell]()
    // elsif not cell and switching then
    //   switching = 0
    end
  end
  //////////////////
  // update the overlay fades
  // overlay_alpha = moveToward(overlay_alpha, overlay_alpha_target, 0.05)

  if mode == 1 then
   // if touching_arrow == 1 then
     // end
    // print(touching_arrow)
    player.update()
    for item in level.items
      if not item.deleted then
        if item.update then
          item.update()
        end
      else
        level.items.removeElement(item)
      end
    end
    
    for item in ammo.items
      if not item.deleted then
        if item.update then
          item.update()
        end
      else
        ammo.items.removeElement(item)
      end
    end
    
    //wywolanie pociskow
    for bullet in bullets
      if not bullet.deleted then
        if bullet.update then
          bullet.update()
        end
      else
        bullets.removeElement(bullet)
      end
    end
    
     for body in bodies
      if body.deleted then
        bodies.removeElement(body)
      end
     end
  // for arrow_stack in ammunit
  //     if arrow_stack.deleted then
  //       ammunit.removeElement(arrow_stack)
  //     end
  //   end
    updatePlayer()
    updateCamera()

    if level_complete then
      setLevel(level.number + 1)
      respawnPlayer()
      // respawn()
    end
  end
touchKeys.update()
end

draw = function()
  // touchKeys.draw()
  screen.clear()
  
  if mode == 1 then
      
    // screen.drawMap("sky" + level.number, -camera.x / 3, -camera.y / 3, 640, 384)
    screen.drawSprite("tlo"+level.number, -camera.x / 3, -camera.y / 3,739,471)
    // draw level
    screen.drawMap(level.map_name, -camera.x, -camera.y, level.map_width, level.map_height)
    draw player
    drawPlayer()
    // draw animated water
    player.draw()

    
    drawGameplay()
    
    drawArrowStock()
    local mgla1_height = sin(system.time()/1000) * 3
    local mgla2_height = sin(system.time()/347) * 1.5
    local mgla1_x_offset = (system.time() / 100) % 16
    local mgla2_x_offset = (system.time() / 72) % 16
    screen.drawMap("mgla" + level.number + "a", mgla1_x_offset - camera.x, -camera.y - 247 + mgla1_height, 70*16, 4*16)
    screen.drawMap("mgla" + level.number + "b", mgla2_x_offset - camera.x, -camera.y - 255 + mgla2_height, 70*16, 4*16)
  // draw ending scene
  touchKeys.draw()
    for item in level.items
      if item.draw then
        item.draw()
      end
    end
    for item in ammo.items
      if item.draw then
        item.draw()
      end
    end

    //rysowanie pociskow
    for bullet in bullets
      bullet.draw()
    end
    
    if draw_bodies then
      for body in bodies
        screen.fillRect(body.x - camera.x, body.y - camera.y, body.w, body.h, "rgba(255, 0, 0, 0.5)")
      end
    end
  end
    
  // draw overlay
  // screen.fillRect(0, 0, screen.width, screen.height, "rgba(0, 0, 0," + overlay_alpha + ")")
  // draw gameplay
  if won then
    screen.drawText("You lost!", 0, 0, 50, "red")
    wait
    respawnPlayer()
    // respawn()
    won = 0
  end
  if infob then
      screen.drawText("Uwazażaj! Gdy tylko cię zobaczą ruszą, aby cię zaatakować.",0,64,13,, "red")
      infob = 0
  end
  if infobl then
      screen.drawText("Te ostrza są bardzo ostre.",0,4,13,, "red")
      infobl = 0
  end
    if infoa then
      screen.drawText("To są shurikeny, aby z nich skorzystać użyj klawisza 'F'.",0,4,13, "red")
      infoa = 0
    end
    if infono then
      screen.drawText("Te stworzenia reagują na hałas, bądż cicho!!",0,4,13, "red")
      infono = 0
    end
    if infoni then
      screen.drawText("Uważaj, ci ninja mają shurikeny.",0,4,13, "red")
      infoni = 0
    end
    if infonoch then
      screen.drawText("Użyj Chidori 'H', aby zniszczyć tarczę.",0,4,13, "red")
      infonoch = 0
    end
    
  if zycieboss <= 0 then
      screen.drawText("WYGRAŁEŚ", 0, 0, 50, "red")
    end
    
  // if ammu then
  //   if arrow_stock<20 then
  //   arrow_stock =+10
  //   end
  //   wait
  //   won = 0
  // end
  if mode == 1 then
    
    screen.setDrawAnchor(-1, 0)
    screen.fillRect(-165, 90, 100 / 3 * player.hp, 10, "rgba(210, 0, 0)")
    screen.setDrawAnchor(0, 0)
  end
  
  
  // for r in rain
  //       r.draw()
  //     end
end


// HELPER FUNCTIONS

setLevel = function(num)
  /////////////////////////////////
  
  ////////////////////////////////
  // overlay_alpha = 2.5 // will take time to begin fade in (at alpha values of below 1)
  // overlay_alpha_target = 0

    bodies = [player.body]
    level.number = num
    level.map_name = "level" + num
    level.map = maps[level.map_name]
    level.map_width = level.map.width * level.map.block_width
    level.map_height = level.map.height * level.map.block_height
    level.spawn.x = level_spawns[num][0]
    level.spawn.y = level_spawns[num][1]
    player.facing = level_spawns[num][2]
    level.item_map = maps[level.map_name + "_items"]

    level.item_map1 = maps[level.map_name + "_ammo"]
    level.item_map2 = maps[level.map_name + "_boom"]
    level.item_map3 = maps[level.map_name + "_noice"]
    level.item_map4 = maps[level.map_name + "_boss"]
    level.item_map5 = maps[level.map_name + "_boomboss"]
    level.item_map6 = maps[level.map_name + "_itemsboss"]
    level.item_map7 = maps[level.map_name + "_czastka"]
    level.items = []
    ammo.items = []

    addAllItemss(level.item_map,"item_enemy",NPCClass)
    addAllItemss(level.item_map1,"item_ammo",MagazynekClass)
    addAllItemss(level.item_map2,"item_boom",NPCBoomClass)
    addAllItemss(level.item_map3,"item_noice",NPCNoiceClass)
    addAllItemss(level.item_map4,"item_boss",NPCBoss)


end

level_spawns = [
  0,
  [-480, -150, 1],
  [-480, -150, 1],
  [-467, -1, 1],
  [-480, 60, -1]
]


/////funkcja 
addAllItemss = function(item,nazwaitemu,klasa)
  local x = 0
  local y = 0
  local map = item
  // local map = map.item_map
  
  for x=0 to map.width-1
    for y=0 to map.height-1
      local item = map.get(x, y)
      if item then
        if item.startsWith(nazwaitemu) then
          level.items.push(new klasa(xMapToPos(x), yMapToPos(y)))
        end
      end
    end
  end
end


// Quick.remove = function(o)
//   if o.type == "sprite" then
//     local index = sprites.indexOf(o)
//     if index>=0 then sprites.remove(index) end
//   end
//   local index = objects.indexOf(o)
//   if index>=0 then objects.remove(index) end
// end









