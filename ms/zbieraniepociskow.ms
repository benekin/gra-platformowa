MagazynekClass = class extends AmmoClass
  constructor = function(x, y)
    super()
    this.name = "arrow_stack_kolizja"
    this.x = x
    this.y = y
    this.size = 16
  end
  
  updateMove = function()
//kolizja z magazynkiem
    local missiles = getCollisionBodies(player)
    if missiles.length > 0 then
      for missile in missiles
         if missile.who.name == "arrow_stack_kolizja" and this.who.name != "arrow_stack_kolizja" then  
          missile.who.delete()
          //doladowanie magazynka
          player.stock =7
        end
      end
    end


  end
  
 
  physics = function()
    charPhysics(this, 4 * 1.4, 7, 4 * 1.4, 4 * 1.4)
  end


end

