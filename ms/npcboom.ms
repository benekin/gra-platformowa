NPCBoomClass = class extends PlayerBoomClass
  constructor = function(x, y)
    super()
    this.name = "boom"
    this.x = x
    this.y = y
    this.size = 16
    this.move_delay = 0
    this.move_dir = 1
    this.acceleration = 0.1
    this.top_speed = 0.5

  end
  updateMove = function()
  //kolizja
    local missiles = getCollisionBodies(player)
    if missiles.length > 0 then
      for missile in missiles
         if missile.who.name == "boom" and this.who.name != "boom" then 
          missile.who.delete()
          wait
          
          setLevel(level.number)
            player.respawn()

        end
      end
    end
    
    //zakres agenta
    if this.landed then
      if dist(player.x, player.y, this.x, this.y) < 120 and abs(this.y - player.y) < 20 and
        ((player.x > this.x and this.facing == -1) or (player.x <= this.x and this.facing == 1)) then
        this.run()
      else
        if this.move_delay < 40 then
          this.facing = -this.move_dir
          this.x_velocity += this.move_dir * this.acceleration
          this.move = true
          this.move_delay += 1
          
          this.x_velocity = clamp(this.x_velocity, -this.top_speed, this.top_speed)
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
  
  run = function()
     this.acceleration=0.3
     this.facing = -this.move_dir
        this.x_velocity += this.move_dir * this.acceleration
        this.move = true
          this.move_delay += 1

  end
  
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end

  draw = function()

    screen.setDrawScale(this.facing, 1)
    // written out with separte draw calls to allow for experimentation with draw sizes etc.
    if this.climbing then
      if this.move then
        playSprite("boomzatrzymanie", this.x - camera.x, this.y - camera.y, this.size)
      else
        playSprite("boomzatrzymanie", this.x - camera.x, this.y - camera.y,
          this.size, this.size, this.climb_time)
      end
    elsif this.y_velocity > 0 then
      screen.drawSprite("boomzatrzymanie", this.x - camera.x, this.y - camera.y, this.size)
    elsif this.y_velocity < 0 then
      screen.drawSprite("boomzatrzymanie", this.x - camera.x, this.y - camera.y, this.size)
    elsif abs(this.x_velocity) >= 0.1 then
      screen.drawSprite("boom", this.x - camera.x, this.y - camera.y, this.size)
    else
      if this.shoot then
        screen.drawSprite("boom", this.x - camera.x, this.y - camera.y, this.size)
      else
        screen.drawSprite("boomzatrzymanie", this.x - camera.x, this.y - camera.y, this.size)
      end
    end
   
   
    // reset to avoid flipping other draw calls
    screen.setDrawScale(1, 1)
  end
end
end