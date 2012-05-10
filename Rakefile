$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'SparrowDemo'
  app.files += Dir.glob(File.join(app.project_dir, 'vendor/BubbleWrap/lib/**/*.rb'))
  app.pods do
    dependency 'Sparrow-Framework'
  end
  
  app.files_dependencies "app/game/game.rb" => "app/supports/number_ext.rb"
end
