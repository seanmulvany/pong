
require "artoo"


class LeapPong < Artoo::MainRobot


connection :leapmotion, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leapmotion, :driver => :leapmotion



work do
  on leapmotion, :open => :on_open
  on leapmotion, :frame => :on_frame
  on leapmotion, :close => :on_close


end


def on_open(*args)
  puts args
end

def on_frame(*args)


frame = args[1]
frame

  frame.pointables.each do |thing|
    p thing.stabilizedTipPosition[1]
    case when element
           read = File.open('console.out', 'w')
           read << thing.stabilizedTipPosition[1]
           read.close

    end
  end

=begin
  frame.hands.each do |element|
  element.stabilizedPalmPosition[1]
    case when element
           read = File.open('console.out', 'w')
            read << element.stabilizedPalmPosition[1]
           read.close

    end

  end
=end

end


def on_close(*args)
  puts args
end



end

LeapPong.work!



