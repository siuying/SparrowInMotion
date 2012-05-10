$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'SparrowDemo'
  app.files += Dir.glob(File.join(app.project_dir, 'vendor/BubbleWrap/lib/**/*.rb'))
  app.files += Dir.glob(File.join(app.project_dir, 'lib/sparrow/**/*.rb'))

  app.pods do
    dependency 'Sparrow-Framework'
  end
  app.frameworks += ['OpenGLES', 'OpenAL', 'QuartzCore', 'AudioToolbox', 'AVFoundation']  
  app.files_dependencies "app/game/game.rb" => "lib/sparrow/supports/number_ext.rb"
  app.files_dependencies "app/app_delegate.rb" => "lib/sparrow/events/resize_event.rb"
end
