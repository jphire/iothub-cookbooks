name             'galileo-hub'
maintainer       'Janne Laukkanen'
maintainer_email 'janne@dliv.in'
license          'MIT'
description      'Starts an IOT-hub'
version          '0.0.1'

%w{ apt git java }.each do |cookbook|
  depends cookbook
end

supports 'debian'