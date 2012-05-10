class ViewController < UIViewController
  attr_accessor :sparrow_view
  def self.new(sparrowView)
    vc = ViewController.alloc.init
    vc.sparrow_view = sparrowView
    nc = NSNotificationCenter.defaultCenter
    nc.addObserver(vc, 
      selector: :"onApplicationDidBecomeActive:", 
      name: UIApplicationDidBecomeActiveNotification, 
      object: nil)
    nc.addObserver(vc, 
      selector: :"onApplicationWillResignActive:", 
      name: UIApplicationWillResignActiveNotification, 
      object: nil)
    vc
  end
  
  def didReceiveMemoryWarning
    SPPoint.purgePool
    SPRectangle.purgePool
    SPMatrix.purgePool  
    super
  end

  def loadView
    self.view = Sparrow::OverlayView.alloc.initWithFrame(App.frame)
  end
  
  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    supportedOrientations = NSBundle.mainBundle.infoDictionary["UISupportedInterfaceOrientations"]
    return true if (interfaceOrientation == UIInterfaceOrientationPortrait && supportedOrientations.include?("UIInterfaceOrientationPortrait"))
    return true if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft && supportedOrientations.include?("UIInterfaceOrientationLandscapeLeft"))
    return true if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown && supportedOrientations.include?("UIInterfaceOrientationPortraitUpsideDown"))
    return true if (interfaceOrientation == UIInterfaceOrientationLandscapeRight && supportedOrientations.include?("UIInterfaceOrientationLandscapeRight"))
    return false
  end
  
  def willAnimateRotationToInterfaceOrientation(interfaceOrientation, duration: duration)
    gameController = @sparrow_view.stage
    gameController.rotateToInterfaceOrientation(interfaceOrientation, animationTime:duration)
  end

  def onApplicationDidBecomeActive(notification)
    @sparrow_view.start
  end
  
  def onApplicationWillResignActive(notification)
    @sparrow_view.stop
  end

end