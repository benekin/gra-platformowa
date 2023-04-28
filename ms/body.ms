
BodyClass = class
  constructor = function(who, x, y, w, h)
    this.who = who
    this.x = x
    this.y = y
    this.w = w
    this.h = h
    this.deleted = false
    
    bodies.push(this)
  end
  
  delete = function()
    this.deleted = true
  end
  
  updatePos = function(x, y)
    this.x = x
    this.y = y
  end
end

checkBodies = function(body1, body2)
  if (body1.x + body1.w >= body2.x) and
      (body1.x <= body2.x + body2.w) and
      (body1.y + body1.h >= body2.y) and
      (body1.y <= body2.y + body2.h) then
    return true
  end
  return false
end

getCollisionBodies = function(self_body)
  local collision_bodies = []
  
  for body in bodies
    if self_body == body then continue end
    
    if checkBodies(self_body, body) then
      collision_bodies.push(body)
    end
  end
  return collision_bodies
end