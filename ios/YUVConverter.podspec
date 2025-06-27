Pod::Spec.new do |s|
  s.name             = 'YUVConverter'
  s.version          = '1.0.0'
  s.summary          = 'A C++ library to convert YUV images to RGB.'
  s.description      = <<-DESC
    This pod provides a C++ implementation for converting YUV image frames to RGB format, optimized for performance.
  DESC
  s.homepage         = 'https://github.com/example'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :path => '.' }

  s.ios.deployment_target = '11.0'
  s.source_files = '../src/native/**/*.{h,cpp}'
  s.public_header_files = '../src/native/**/*.h'
  
  # Link against the C++ standard library
  s.libraries = 'c++'

  # Set the compiler options
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'STRIP_STYLE' => 'non-global'
  }
end 