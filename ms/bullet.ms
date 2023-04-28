//pocisk
BulletClass = class
  constructor = function(who, x, y, dir)
    this.name = "bullet"
    this.who = who
    this.x = x
    this.y = y
    this.dir = dir
    this.body = new BodyClass(this, this.x, this.y, 6, 6)
    this.deleted = false
  end

  delete = function()
    this.deleted = true
    this.body.delete()
  end
  
  update = function()
    this.x += 5 * this.dir
    this.body.x = this.x
    
    local bodies = getCollisionBodies(this.body)
    if bodies.length > 0 then
      for body in bodies
        if body.who.name == "enemy" and this.who.name != "enemy" then
          body.who.delete()
          this.delete()
        elsif body.who.name == "boom" and this.who.name != "boom" then
          body.who.delete()
          this.delete()
          elsif body.who.name == "czastka" and this.who.name != "czastka" then
          this.delete()
          
         //życie 
        elsif body.who.name == "boss" and this.who.name != "boss" then
             body.who.hp -= 1
          zycieboss -=1
           this.delete()
           //boss spawns
          if(zycieboss==7) then
            addAllItemss(level.item_map5,"item_boom",NPCBoomClass)
            addAllItemss(level.item_map1,"item_ammo",MagazynekClass)
            addAllItemss(level.item_map7,"item_czastka",NPCCzastka)
          end
          if(zycieboss==5) then
            addAllItemss(level.item_map6,"item_enemy",NPCClass)
            addAllItemss(level.item_map1,"item_ammo",MagazynekClass)
            addAllItemss(level.item_map7,"item_czastka",NPCCzastka)
          end 
          if(zycieboss==3) then
            addAllItemss(level.item_map5,"item_boom",NPCBoomClass)
            addAllItemss(level.item_map1,"item_ammo",MagazynekClass)
            addAllItemss(level.item_map7,"item_czastka",NPCCzastka)
            end
          if zycieboss <= 0 then

            body.who.delete()
          end
        elsif body.who.name == "player" and this.who.name != "player" then
          body.who.hp -= 1
          
          if body.who.hp <= 0 then
            body.who.hp = 3
            setLevel(level.number)
            player.respawn()
          end
          
          this.delete()
        end
      end
    end

  end
  //narysowany pocisk
  draw = function()

    screen.setDrawScale(this.dir, 1)
    screen.drawSprite("shot1", this.x - camera.x, this.y - camera.y, 15)
    screen.setDrawScale(1, 1)
  end
end
drawArrowStock = function()
  screen.drawSprite("arrow_stock",screen.width/2-50,80,15*arrow_bump)
  screen.drawText(arrow_stock,screen.width/2-40,80,15*arrow_bump,"#FFF")
  arrow_bump = 1+(arrow_bump-1)*.95
end
