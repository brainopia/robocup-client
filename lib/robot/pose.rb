require 'yaml'

module Robot

  def pose
    Pose
  end

  module Pose
    extend self

    Dir.glob('lib/robot/pose/*.yml').each do |pose_file|
      pose = YAML.load_file pose_file
      pose_name = File.basename pose_file, '.yml'

      eval <<CODE
        def #{pose_name}(&pose_callback)
          pose = #{pose.inspect}

          joints_size = pose.size
          joints_completed = 0

          pose.each do |joint, angle|
            Robot.send joint, :angle => angle do
              if (joints_completed += 1) == joints_size && pose_callback
                pose_callback.call
              end
            end

          end
        end
CODE
    end
  end

end