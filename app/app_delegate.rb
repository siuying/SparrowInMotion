SP_EVENT_TYPE_TOUCH = "touch"

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    screenBounds = UIScreen.mainScreen.bounds
    @window = UIWindow.alloc.initWithFrame(screenBounds)
    
    SPStage.setSupportHighResolutions(true, doubleOnPad: true)
    width  = ipad? ? 384 : 320
    height = ipad? ? 512 : 480
    
    $stderr.puts "setup sparrowView"
    @sparrowView = SPView.alloc.initWithFrame(screenBounds)
    @sparrowView.multipleTouchEnabled = false
    @sparrowView.frameRate = 30
    @window.addSubview(@sparrowView)

    $stderr.puts "setup gameController"
    @gameController = GameController.new(width, height)
    @sparrowView.stage = @gameController

    $stderr.puts "setup viewController"
    @viewController = ViewController.new(@sparrowView)
    if @window.respondsToSelector(:"setRootViewController:")
      @window.setRootViewController(@viewController)
    else
      @window.addSubview(@viewController.view)
    end

    @window.makeKeyAndVisible
    true
  end
end

