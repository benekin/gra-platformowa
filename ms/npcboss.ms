NPCBoss = class extends PlayerBoss
  constructor = function(x, y)
    super()
    this.name = "boss"
    this.x = x
    this.y = y
    this.size = 40
    this.move_delay = 0
    this.move_dir = 1
    this.acceleration = 0.1
    this.top_speed = 0.5
    this.bossanimation=0
    this.tick=0
    
  end
  
  updateMove = function()
    //kolizja
    local missiles = getCollisionBodies(player)
    if missiles.length > 0 then
      for missile in missiles

        if missile.who.name == "boss" and this.who.name != "boss" then 

       
          respawnPlayer()
        end

      end
    end
    //zakres
    if this.landed then
      if dist(player.x, player.y, this.x, this.y) < 220 and abs(this.y - player.y) < 120 and
        ((player.x > this.x and this.facing == -1) or (player.x <= this.x and this.facing == 1)) then
        this.animation()
      else
        if this.move_delay < 40 then
          this.facing = -this.move_dir
          this.move = true
          this.move_delay += 1
        elsif this.move_delay < 120 then
          this.move = false
          this.move_delay += 1
        else
          this.move_dir = -this.move_dir
          this.move_delay = 0
        end
      end
    end
  end
  
  animation = function()

    if(player.x < this.x) then

      this.tick += 1
      if this.tick%5 == 0 then
        this.frame += 1
        if this.frame >5 then this.frame = 5 end
      end
      if(this.tick>200) then
        this.frame=0  
      end
      this.bossanimation=1
      else
        this.bossanimation=1
    end
     

  end
  
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end
  

  draw = function()

    
      ///////////to trzeba ogarnac na jakiej wysokosci boss
    if(bossanimation==0)then
    screen.drawSprite("boss.0", this.x - camera.x, this.y+14 - camera.y, this.size)
    else
      // if( sprites.boss.getFrame()<5) then
      screen.drawSprite("boss."+this.frame, this.x - camera.x, this.y+14 - camera.y, this.size)
          ///////deszcz
      // for r in rain
      //   r.draw()
      // end
      screen.setDrawAnchor(-1, 0)
      screen.drawText("Boss HP", 165, 60, 10, "red")
    screen.fillRect(165, 50, 20 / 3 * zycieboss, 10, "rgba(180, 278, 0)")
    screen.setDrawAnchor(0, 0)

    end
    
  
    // flip sprite if facing left
    screen.setDrawScale(this.facing, 1)

    screen.setDrawScale(1, 1)
  end
end