module Sparrow
  class ResizeEvent < SPEvent
    SP_EVENT_TYPE_RESIZE = "resize"

    attr_accessor :width, :height, :animation_time

    def self.event(width, height, time)
      e = ResizeEvent.alloc.initWithType(SP_EVENT_TYPE_RESIZE, bubbles:false)
      e.width = width
      e.height = height
      e.animation_time = time
      e
    end

    def portrait?
      self.height > self.width
    end
  end
end