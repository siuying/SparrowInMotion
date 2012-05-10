module Sparrow
  module Media
    module_function

    @atlas = nil
    @sounds = nil
  
    def init_atlas
      return if @atlas
      @atlas = SPTextureAtlas.alloc.initWithContentsOfFile("atlas.xml")
    end
  
    def release_atlas
      @atlas = nil
    end
  
    def atlas_texture(name)
      self.init_atlas unless @atlas
      @atlas.textureByName(name)
    end
  
    def atlas_textures_with_prefix(prefix)
      self.initAtlas unless @atlas
      @atlas.texturesStartingWith(prefix)
    end
  
    def init_sound
      return if @sounds
    
      SPAudioEngine.start
      @sounds = {}
    
      soundDir = resources_path
      dirEnum = NSFileManager.defaultManager.enumeratorAtPath(soundDir)
    
      while filename = dirEnum.nextObject do
        if filename.pathExtension == "caf"
          sound = SPSound.alloc.initWithContentsOfFile(filename)
          @sounds[filename] = sound
        end
      end
    end
  
    def release_sound
      @sounds = nil
      SPAudioEngine.stop
    end
  
    def play_sound(soundName)
      sound = @sounds[soundName]
      if sound
        sound.play
      else
        SPSound.soundWithContentsOfFile(soundName).play
      end
    end
  
    def sound_channel(soundName)
      sound = @sounds[soundName]
      sound = SPSound.soundWithContentsOfFile(soundName) unless sound
      sound.createChannel
    end
  end # Media
end # Sparrow