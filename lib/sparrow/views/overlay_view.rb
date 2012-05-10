# This class makes a UIView work just like a sprite in Sparrow:
# it will react only on touches of child objects, and won't block touches on 
# empty areas any longer. That makes it perfect for an overlay view, on which
# we can then add all kinds of UIKit elements: textfields, iAd banners, etc.
module Sparrow
  class OverlayView < UIView
   def pointInside(point, withEvent: event)
     self.subviews.each do |subview|
       innerPoint = [point.x - subview.frame.origin.x,
                     point.y - subview.frame.origin.y]
       return true if (subview.pointInside(innerPoint, withEvent: event))
     end
     return false
   end 
  end
end