PlayernpcClass = class
  constructor = function()
    this.name = "player"

    this.max_fall_speed = 8

    this.createBody()

  end
  
  createBody = function()
    this.body = new BodyClass(this, this.x, this.y - 4, 4 * 1.4, 20 * 0.6)
  end
  
  delete = function()
    this.deleted = true
    this.body.delete()
  end

  update = function()
 (this.touching_ladder) and (not this.landed)
    
    this.updateMove()
    
    this.physics()

    this.body.updatePos(this.x + 2, this.y - 4)

  end
  

  
  draw = function()

    screen.setDrawScale(this.facing, 1)

    if this.climbing then
      if this.move then
        playSprite("sprite18", this.x - camera.x, this.y - camera.y, this.size)
      else
        playSprite("sprite18", this.x - camera.x, this.y - camera.y,
          this.size, this.size, this.climb_time)
      end 
    elsif this.y_velocity > 0 then

      screen.drawSprite("skok", this.x - camera.x, this.y - camera.y, this.size)

    elsif this.y_velocity < 0 then

      screen.drawSprite("skok", this.x - camera.x, this.y - camera.y, this.size)

    elsif abs(this.x_velocity) > 0.5 then
      if not this.shoot then

        screen.drawSprite("wrogchodzenie", this.x - camera.x, this.y - camera.y, this.size)

      else
        screen.drawSprite("wrogchodzenie", this.x - camera.x, this.y - camera.y, this.size)
      end
    else
      if not this.shoot then

        screen.drawSprite("wrogchodzenie", this.x - camera.x, this.y - camera.y, this.size)

      else
        screen.drawSprite("wrogrzut", this.x - camera.x, this.y - camera.y, this.size)
      end
    end

    screen.setDrawScale(1, 1)
  end


end

