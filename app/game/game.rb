class Game < SPSprite
  include Sparrow

  attr_accessor :game_width, :game_height

  def initWithWidth(width, height:height)
    init
    @game_width = width
    @game_height = height
    self.setup
    self
  end
  
  def setup
    SPAudioEngine.start
    Media.init_atlas
    Media.init_sound
    
    background = SPImage.alloc.initWithContentsOfFile("background.jpg")
    background.pivotX = background.width / 2
    background.pivotY = background.height / 2
    background.x = @game_width / 2
    background.y = @game_height / 2
    self.addChild(background)

    @egg = SPImage.alloc.initWithTexture(Media.atlas_texture("egg"))
    @egg.pivotX = (@egg.width / 2).to_i
    @egg.pivotY = (@egg.height / 2).to_i
    @egg.x = @game_width / 2
    @egg.y = @game_height / 2 + 50
    self.addChild(@egg)

    @egg.addEventListener(:"onEggTouched:", atObject:self, forType:"touch")
    @tween = SPTween.tweenWithTarget(@egg, time:5.0, transition:Transitions::EASE_IN_OUT)
    @tween.animateProperty("rotation", targetValue:360.0.to_rad)
    @tween.loop = SPLoopTypeRepeat
    SPStage.mainStage.juggler.addObject(@tween)

    text = "To find out how to create your own game out of this scaffold, have a look at the 'First Steps' section of the Sparrow website!"
    @textField = SPTextField.alloc.initWithWidth(280, height:80, text:text)
    @textField.x = (@game_width - @textField.width) / 2
    @textField.y = @egg.y - 175
    self.addChild(@textField)

    self.addEventListener(:"onResize:", atObject:self, forType:ResizeEvent::SP_EVENT_TYPE_RESIZE)    
  end
  
  def tearDown
    Media.release_atlas
    Media.release_sound
  end

  def onEggTouched(event)
    touches = event.touchesWithTarget(self, andPhase:SPTouchPhaseEnded)
    if touches.anyObject
      Media.play_sound("sound.caf")
    end
  end
  
  def onResize(event)
    # puts ("new size: %.0fx%.0f (%s)", event.width, event.height, event.portrait? ? "portrait" : "landscape")
  end
end