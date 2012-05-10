class GameController < SPStage
  attr_accessor :game

  def self.new(width, height)
    gc = GameController.alloc.initWithWidth(width, height:height)

    game_width = width
    game_height = height
    # if the orientation is landscape, swap the size
    if [:landscape_left, :landscape_right].include?(orientation)
      game_width = height
      game_height = width
    end
    
    orientation = gc.initialInterfaceOrientation
    gc.game = Game.alloc.initWithWidth(game_width, height:game_height)
    gc.game.pivotX = game_width / 2
    gc.game.pivotY = game_height / 2
    gc.game.x = width  / 2
    gc.game.y = height / 2
    gc.rotateToInterfaceOrientation(orientation, animationTime:0)
    
    $stderr.puts "GameController.addChild"
    gc.addChild(gc.game)
    gc
  end
  
  def initialInterfaceOrientation
    # In an iPhone app, the 'statusBarOrientation' has the correct value on Startup; 
    # unfortunately, that's not the case for an iPad app (for whatever reason). Thus, we read the
    # value from the app's plist file.

    bundleInfo = NSBundle.mainBundle.infoDictionary
    initialOrientation = bundleInfo.objectForKey("UIInterfaceOrientation")
    if initialOrientation
      if initialOrientation == "UIInterfaceOrientationPortrait"
        return UIInterfaceOrientationPortrait
      elsif initialOrientation == "UIInterfaceOrientationPortraitUpsideDown"
        return UIInterfaceOrientationPortraitUpsideDown
      elsif initialOrientation == "UIInterfaceOrientationLandscapeLeft"
        return UIInterfaceOrientationLandscapeLeft
      else
        return UIInterfaceOrientationLandscapeRight
      end
    else 
      return UIApplication.sharedApplication.statusBarOrientation
    end
  end
  
  def rotateToInterfaceOrientation(interfaceOrientation, animationTime: animationTime)
    angles = [0.0, 0.0, -PI, PI_HALF, -PI_HALF]
    oldAngle = @game.rotation
    
    newAngle = angles[interfaceOrientation]
    while oldAngle - newAngle >  PI do
      newAngle += TWO_PI
    end
    
    while oldAngle - newAngle < -PI do
      newAngle -= TWO_PI
    end

    if animationTime > 0
      tween = SPTween.tweenWithTarget(@game, time:animationTime, transition:Transitions::EASE_IN_OUT)
      tween.animateProperty("rotation", targetValue:newAngle)
      SPStage.mainStage.juggler.removeObjectsWithTarget(@game)
      SPStage.mainStage.juggler.addObject(tween)
    else
      @game.rotation = newAngle
    end

    # if the orientation is landscape, swap the size
    isPortrait = [:landscape_left, :landscape_right].include?(orientation)
    newWidth = isPortrait ? [@game.game_width, @game.game_height].min : [@game.game_width, @game.game_height].max
    newHeight = isPortrait ? [@game.game_width, @game.game_height].max : [@game.game_width, @game.game_height].min
    
    if newWidth != @game.game_width
      @game.game_width = newWidth
      @game.game_height = newHeight

      resizeEvent = ResizeEvent.event(newWidth, newHeight, animationTime)
      @game.broadcastEvent(resizeEvent)
    end
  end
end