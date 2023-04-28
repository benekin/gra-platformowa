NPCCzastka = class extends PlayerCzastka
  constructor = function(x, y)
    super()
    this.name = "czastka"
    this.x = x
    this.y = y
    this.size = 30
    this.move_delay = 0
    this.move_dir = 1
    this.acceleration = 0.1
    this.top_speed = 0.5
    this.bossanimation=0
    this.tick=0

    
  end
  
  lost=0
  updateMove = function()
      // print(player.chidoriboss)
    
    local hw = level.map_width / 2
    local hh = level.map_height / 2
    
    
    
    
    local missiles = getCollisionBodies(player)
    if missiles.length > 0 then
      for missile in missiles

        if player.chidoriboss ==true then
        if missile.who.name == "czastka" and this.who.name != "czastka" then 
    
          missile.who.delete()

        end
        end
      end
    end
    
    if this.landed then
      if dist(player.x, player.y, this.x, this.y) < 220 and abs(this.y - player.y) < 120 and
        ((player.x > this.x and this.facing == -1) or (player.x <= this.x and this.facing == 1)) then
        this.fire()
      else
        // this.shoot = false
        if this.move_delay < 40 then
          this.facing = -this.move_dir
          // this.x_velocity += this.move_dir * this.acceleration
          this.move = true
          this.move_delay += 1
          
          // this.x_velocity = clamp(this.x_velocity, -this.top_speed, this.top_speed)
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
  

  
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end

  draw = function()

      screen.drawSprite("czastka", this.x - camera.x, this.y - camera.y+13, this.size)

 
  end


  end
end