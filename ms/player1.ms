PlayerClass = class
  constructor = function()
    this.name = "player"
    this.hp = 3
    this.x = 0
    this.y = 0
    this.x_velocity = 0
    this.y_velocity = 0
    this.facing = 1
    this.top_speed = 2 // 2
    this.size = 16 ////////zebyzmienic rozmiar gracza trzeba zmienic to i new BodyClass, physics
    this.landed = true
    this.jump_velocity = 4.2
    this.max_fall_speed = 8
    this.acceleration = 0.4 // 0.4//przyspieszenie
    this.climbing_speed = 1
    this.climbing = false
    this.climb_time = 0
    this.move = false
    this.shoot = false
    // this.stock= 0
    this.shoot_delay = 0
    this.deleted = false
    this.createBody()
    this.check=false
    this.chidori=0
    this.chidoribieg=0
    this.tick=0
    // this.ghost = false
    this.chidoriboss=0
    // this.zniszczonaczastka=0
  end

  createBody = function()
    this.body = new BodyClass(this, this.x, this.y - 4, 4 * 1.4, 20 * 0.6)
  end
  
  delete = function()
    this.deleted = true
    this.body.delete()
  end

  update = function()
  
    // detect whether climbing or not
    this.touching_ladder = checkCollision(this.x, this.y, "ladder")
    // this.touching_arrow = checkCollision(this.x, this.y, "arrow_stack")
   
    this.climbing = (this.touching_ladder) and (not this.landed)
    
    this.updateMove()
    
    this.physics()
  
    // clamp player to the map area (on the x axis)
    this.x = clamp(this.x, -level.map_width / 2 + 8, level.map_width / 2 - 8)
    
    this.body.updatePos(this.x + 2, this.y - 4)
  
  //////////// chidori bieg
  if this.chidoribieg>0 then
    this.chidoribieg+=1/60
    end
  if this.chidoribieg > 5 then
      this.chidoribieg=0
      this.frame = 0
  end
  end
  
  updateMove = function()
    //poruszanie się
    playerPhysics()
    this.move = false
    // poruszanie się
    if this.climbing then

      this.x_velocity = 0
      if keyboard.LEFT or gamepad.LEFT then
        this.x_velocity -= this.climbing_speed / 3
        this.move = true
      end
      
      if keyboard.RIGHT or gamepad.RIGHT then
        this.x_velocity += this.climbing_speed / 3
        this.move = true
      end
      
      this.y_velocity = 0
      if keyboard.UP or gamepad.UP then
        this.y_velocity = this.climbing_speed
        this.move = true
      end
      if keyboard.DOWN or gamepad.DOWN then
        this.y_velocity = -this.climbing_speed
        this.move = true
        
        //print(this.chidori)
      end
      //this.chidori=false
      if this.move then
        this.climb_time = time
      end
      // set the direction player is facing based on position on vine/ladder
      // local vine_x_traversal = ((this.x + level.map_width / 2) / (level.map_width / level.map.width)) % 1
      // if vine_x_traversal < 0.5 then this.facing = 1 else this.facing = -1 end
    else
      if keyboard.LEFT or gamepad.LEFT then
        //ulozenie postaci
        this.facing = -1
        //predkosc chodzenia
        this.x_velocity -= this.acceleration
        this.move = true
      end
      if keyboard.RIGHT or gamepad.RIGHT then
        this.facing = 1
        this.x_velocity += this.acceleration
        this.move = true
      end
      
      this.shoot = false
      if keyboard.press.F then
        this.shoot = true
        this.shoot_delay = 0
        this.stock -= 1
        ////do magazynka
        if this.stock <0 then
          this.stock=0
        end
        // if this.stock >=20 then
        //   this.stock =20
        // end
      // if this.touching_arrow =="true" then
        // this.stock =20
        //end
        ////
        // print(this.stock)
      end
      ///////// uzycie chidori
      if keyboard.H then
        
      this.tick += 1
      if this.tick%10 == 0 then
        this.frame += 1
        if this.frame >18 then this.frame = 0 end
      end  
        
      this.chidori += 1
      this.chidoribieg=1/60
      
      else
        this.chidori =0
        
      end
      
      if this.chidoribieg >0 then
        chidoriboss=1
        else
          chidoriboss=0
        end
      this.chidori += 0
      /////////// tu w raziec zmienic shoot_delay 
      if keyboard.F then
        this.shoot = true
        if this.stock > 0  then
          if this.shoot_delay % 15 == 0 then
            if not this.move then
              if this.facing == 1 then
                bullets.push(new BulletClass(this, this.x + 10, this.y + 5, this.facing))
              else
                bullets.push(new BulletClass(this, this.x - 10, this.y + 5, this.facing))
              end
            else
              if this.facing == 1 then
                bullets.push(new BulletClass(this, this.x + 21, this.y + 4, this.facing))
              else
                bullets.push(new BulletClass(this, this.x - 21, this.y + 4, this.facing))
              end
            end
          end
          
        end
        this.shoot_delay += 0.1
      end
      
      // limit player to it's own top speed
      this.x_velocity = clamp(this.x_velocity, -this.top_speed, this.top_speed)
    
      // detect jump request
      if (keyboard.SPACE or keyboard.UP or gamepad.A) and this.landed then
        // sprites["player_jump"].setFrame(0) NEED TO CHANGE!!!
        this.y_velocity = this.jump_velocity
        this.move = true
      end
    end
  end
  
  draw = function()
    // flip sprite if facing left
    screen.setDrawScale(this.facing, 1)
    // written out with separte draw calls to allow for experimentation with draw sizes etc.
    //////////rysowanie chidori ladowania
    if this.chidori > 1 then
      // sprites.chidori.getFrame(0)
      screen.drawSprite("chidori."+this.frame, this.x - camera.x, this.y - camera.y, this.size)
      else
    if this.climbing then
      if this.move then
        screen.drawSprite("wchodzenie", this.x - camera.x, this.y - camera.y, this.size)
      else
        playSprite("wchodzenie", this.x - camera.x, this.y - camera.y,
          this.size, this.size, this.climb_time)
      end 
    elsif this.y_velocity > 0 then
      /////////chidori jak skacze
      if  this.chidoribieg > 0 then
        screen.drawSprite("chidoriskok", this.x - camera.x, this.y - camera.y, this.size)
        else
      screen.drawSprite("skok", this.x - camera.x, this.y - camera.y, this.size)
      end
    elsif this.y_velocity < 0 then
      if  this.chidoribieg > 0 then
        screen.drawSprite("chidoriskok", this.x - camera.x, this.y - camera.y, this.size)
        else
      screen.drawSprite("skok", this.x - camera.x, this.y - camera.y, this.size)
    end
    elsif abs(this.x_velocity) > 0.5 then
      if not this.shoot then
        /////////chidori jak chodzi
        if  this.chidoribieg > 0 then
        screen.drawSprite("chidorichodzenie", this.x - camera.x, this.y - camera.y, this.size)
        else
        screen.drawSprite("chodzenie", this.x - camera.x, this.y - camera.y, this.size)
      end
      else
        screen.drawSprite("chodzenie", this.x - camera.x, this.y - camera.y, this.size)
      end
    else
      if not this.shoot then
        /////////chidori jak stoi
        if  this.chidoribieg > 0 then
        screen.drawSprite("chidoriwmiejscu", this.x - camera.x, this.y - camera.y, this.size)
        else
        screen.drawSprite("sprite", this.x - camera.x, this.y - camera.y, this.size)
        end
      else
        screen.drawSprite("rzut", this.x - camera.x, this.y - camera.y, this.size)
      end
    end
    end
    // reset to avoid flipping other draw calls
    screen.setDrawScale(1, 1)
  end
  ///TUTAJ MOZNA ZMIENIAC FIZYKE,wysokosc na jakiej jest gracz
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end

  respawn = function()
    this.x = level.spawn.x
    this.y = level.spawn.y
  end

end

respawnPlayer = function()
      player.x = level.spawn.x
      player.y = level.spawn.y
    end