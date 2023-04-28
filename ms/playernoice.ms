PlayerNoiceClass = class
  constructor = function()
    this.facing = -1
    // this.max_fall_speed = 8
    this.createBody()
  end
  
  createBody = function()
    this.body = new BodyClass(this, this.x, this.y - 4, 4 * 1.4, 20 * 1.4)
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

