Pod::Spec.new do |s|
  s.name             = 'YUVConverter'
  s.version          = '1.0.0'
  s.summary          = 'A C++ YUV to RGB converter.'
  s.description      = <<-DESC
  This pod provides a C++ implementation for converting YUV image frames to RGB format, optimized for performance.
                       DESC
  s.homepage         = 'https://github.com/example'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :git => '', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.source_files = '../src/native/*.{h,cpp}'
  
  # Build as a static framework
  s.static_framework = true

  # Specify that this pod uses C++ and force linker to keep symbols
  s.pod_target_xcconfig = {
    'GCC_PRECOMPILE_PREFIX_HEADER' => 'YES',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'OTHER_LDFLAGS' => '-u _convert_yuv_to_rgb -u _free_image_memory'
  }

end 