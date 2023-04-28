NPCClass = class extends PlayernpcClass
  constructor = function(x, y)
    super()
    this.name = "enemy"
    this.x = x
    this.y = y
    this.size = 16
    this.move_delay = 0
    this.move_dir = 1
    this.acceleration = 0.1
    this.top_speed = 0.5
  end
  
  updateMove = function()

 // zakres agenta
    if this.landed then
      if dist(player.x, player.y, this.x, this.y) < 150 and abs(this.y - player.y) < 20 and
        ((player.x > this.x and this.facing == -1) or (player.x <= this.x and this.facing == 1)) then
        this.fire()
      else
        this.shoot = false
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
  
  fire = function()
    this.shoot = true
  
    if this.shoot_delay % 30 == 0 then
      if this.facing == -1 then
        bullets.push(new BulletClass(this, this.x + 10, this.y, -this.facing))
      else
        bullets.push(new BulletClass(this, this.x - 10, this.y, -this.facing))
      end
    end
    
    this.shoot_delay += 1
  end
  
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end
  
  respawn = function()
    
  end
end