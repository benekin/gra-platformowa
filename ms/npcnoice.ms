NPCNoiceClass = class extends PlayerNoiceClass
  constructor = function(x, y)
    super()
    this.name = "npcnoice"
    this.x = x
    this.y = y
    this.size = 46
    this.move_delay = 0
    this.move_dir = 1
    this.acceleration = 0.1
    this.top_speed = 0.5
    this.czas=0

  end
  updateMove = function()
  //timer
    if(player.check==true) then
      this.czas+=1/60
        if (this.czas>5)then
          this.czas=0
          player.check=false
          end
  //kolizja
    local missiles = getCollisionBodies(player)
    if missiles.length > 0 then
      for missile in missiles
         if missile.who.name == "npcnoice" and this.who.name != "npcnoice" then 
          body.who.hp = 3
          this.czas=0
          player.check=false
            setLevel(level.number)
            player.respawn()

        end
      end
    end
    //zakres agenta
    if this.landed then
      if dist(player.x, player.y, this.x, this.y) < 120 and abs(this.y - player.y) < 120 and
        ((player.x > this.x and this.facing == -1) or (player.x <= this.x and this.facing == 1)) then
        this.run()
        
      else
        if this.move_delay < 40 then
          this.facing = -this.move_dir
          this.move = true
          this.move_delay += 1
          
        elsif this.move_delay < 20 then
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
    if(this.czas<5) then
    this.acceleration=0.3
     this.facing = -this.move_dir
        this.x_velocity += this.move_dir * this.acceleration
        this.move = true
          this.move_delay += 1
    end

      end
  end 

  
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end
  
  draw = function()


    screen.setDrawScale(this.facing, 1)

    if this.climbing then
      if this.move then
        playSprite("npcnoice", this.x - camera.x, this.y - camera.y+4, this.size)
      else
        playSprite("npcnoice", this.x - camera.x, this.y - camera.y+4
          this.size, this.size, this.climb_time)
      end
    elsif this.y_velocity > 0 then
      screen.drawSprite("npcnoice", this.x - camera.x, this.y - camera.y+4, this.size)
    elsif this.y_velocity < 0 then
      screen.drawSprite("npcnoice", this.x - camera.x, this.y - camera.y+4, this.size)
    elsif abs(this.x_velocity) >= 0.1 then
      screen.drawSprite("npcnoicemove", this.x - camera.x, this.y - camera.y+4, this.size)
    else
      if this.shoot then
        screen.drawSprite("npcnoicemove", this.x - camera.x, this.y - camera.y+4, this.size)
      else
        screen.drawSprite("npcnoice", this.x - camera.x, this.y - camera.y+4, this.size)
      end
    end

    screen.setDrawScale(1, 1)
  end
end