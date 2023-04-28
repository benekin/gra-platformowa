///lista spriteow z ktorymi jest interakcja
interactable = ["blade","blade1","blade2","glass","newlevel","power","infoboom","infoblade","infoammo","infoninja","infonoice","drop","infochidori"]
getInteraction = function()
  local map = level.map
  local hw = level.map_width / 2    // half level map width in pixels
  local hh = level.map_height / 2 


  //polozenie postaci
    local y = floor((player.y + player.y_velocity + 4 + hh) / 16)
    local bottom = floor((player.y + player.y_velocity - 6 + hh) / 16)
    local x = floor((player.x + player.x_velocity + 4 + hw) / 16)
    local left = floor((player.x + player.x_velocity - 4 + hw) / 16)
     //sprawdzenie interakcji jesli zachodzi zwraca nazwe z czym
  if isInteracting(x,bottom) then
   return maps[mapName].get(x,bottom)
  elsif isInteracting(x,bottom+1) then
   return maps[mapName].get(x,bottom+1)
  end
  
  if isInteracting(left,y) then
    return maps[mapName].get(left,y)
  elsif isInteracting(left+1,y) then
    return maps[mapName].get(left+1,y)

  end
  
  
end
//contains - Zwraca 1 (prawda), gdy element znajduje się na liście, lub 0 (fałsz), gdy elementu nie można znaleźć na liście
//sprawdzenie czy zaszla interakcja pomiedzy obiektem z listyu a graczem
isInteracting = function(x, y)
  return  interactable.contains(maps[mapName].get(x,y))
end