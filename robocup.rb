require 'socket'
require 'yaml'
require 'mathn'

require 'rubygems'
require 'symbolic'

require 'lib/extensions/kernel'
require 'lib/extensions/matrix'
require 'lib/extensions/numeric'
require 'lib/extensions/symbolic'
require 'lib/extensions/vector3d'
require 'lib/extensions/transformation'

require 'lib/robot'
require 'lib/robot/joint'
require 'lib/robot/pose'
require 'lib/robot/movement'
require 'lib/robot/structure/joint'
require 'lib/robot/structure/joint/dsl'
require 'lib/robot/structure/limb'
require 'lib/robot/structure/limb/dsl'
require 'lib/robot/structure'

Thread.abort_on_exception = true

require 'lib/client'
require 'lib/client/prefix'
require 'lib/client/socket'
require 'lib/client/parser'
require 'lib/client/mapper'
