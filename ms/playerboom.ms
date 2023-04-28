PlayerBoomClass = class
  constructor = function()

    // this.hp = 3
    // this.x = 0
    // this.y = 0
    // this.x_velocity = 0
    // this.y_velocity = 0
    // this.facing = 1
    // this.top_speed = 3 // 2
    // this.size = 16
    // this.landed = true
    // this.jump_velocity = 4.2
    //this.max_fall_speed = 8
    // this.acceleration = 0.8 // 0.4
    // this.climbing_speed = 1
    // this.climbing = false
    // this.climb_time = 0
    // this.move = false
    // this.shoot = false
    // this.stock= 10
    // this.shoot_delay = 0
    // this.deleted = false
    this.createBody()
  end
  
  createBody = function()
    this.body = new BodyClass(this, this.x, this.y - 1.6, 1.6, 20 *0.6)
  end
  
  delete = function()
    this.deleted = true
    this.body.delete()
  end

  update = function()
 
    this.updateMove()
    
    this.physics()
 
    this.body.updatePos(this.x + 2, this.y - 4)
  end


end

