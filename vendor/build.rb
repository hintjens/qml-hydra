
require_relative 'build_env'

def vendor_exec str
  print "\033[1;33m" # Use bold yellow text color in terminal
  puts str           # Print the command to be executed
  print "\033[0m"    # End terminal coloring
  system str         # Execute the command
end

def vendor_build
  vendor_build_env
  
  # The set of dependency libs of this project, with relevant URLs and options
  libs = [
    [:libsodium,
      retrieve: [:tar, "https://download.libsodium.org/libsodium/releases/LATEST.tar.gz"],
      configure: {
        other: '--disable-soname-versions'
      }
    ],
    [:libzmq,
      retrieve: [:git, "https://github.com/zeromq/zeromq4-x.git"],
      configure: {
        CPPFLAGS: "-Wno-long-long",
        APP_STL:  :stlport_static,
        other: '--with-libsodium=yes',
        # other: '--with-pgm',
      },
    ],
    [:czmq,
      retrieve: [:git, "https://github.com/zeromq/czmq.git"],
      env: {
        LIBTOOL_EXTRA_LDFLAGS: '-avoid-version'
      },
    ],
    [:zyre,
      retrieve: [:git, "https://github.com/zeromq/zyre.git"],
      env: {
        LIBTOOL_EXTRA_LDFLAGS: '-avoid-version'
      },
    ],
    [:hydra,
      retrieve: [:git, "https://github.com/edgenet/hydra.git"],
      env: {
        LIBTOOL_EXTRA_LDFLAGS: '-avoid-version'
      },
    ],
  ]
  
  # Path where sources are to be stored and built, relative to invoking Rakefile
  cache_path = "./vendor/cache/#{ENV['TOOLCHAIN_NAME']}/"
  
  # Create the cache_path directory
  system "mkdir -p #{cache_path}"
  
  # Process each library
  libs.each { |name, lib_opts|
    
    # Get retrieve options
    retrieve_args = lib_opts.fetch :retrieve
    retrieve_opts = retrieve_args.last.is_a?(Hash) ? retrieve_args.pop : {}
    type, url = retrieve_args
    
    # Retrieve the source using the given strategy to given path
    path = cache_path + name.to_s
    case type
    when :git
      tag = retrieve_opts.fetch :tag, nil
      
      vendor_exec "cd #{cache_path}"\
         " && git clone #{url} #{name}"
      vendor_exec "cd #{path}"\
         " && git checkout #{tag}" if tag
      vendor_exec "cd #{path}"\
         " && if [ ! -f configure ]; then ./autogen.sh; fi"
    when :tar
      tarfile = "#{name}.tar.gz"
      vendor_exec "cd #{cache_path}"\
         " && if [ ! -f #{tarfile} ]; then wget #{url} -O #{tarfile}; fi"\
         " && mkdir #{name}"\
         " && tar -C #{name} -xvf #{tarfile} --strip=1"
    else
      raise NotImplementedError
    end
    
    exit 1 unless vendor_exec\
     "#{environment lib_opts}"\
     "export PATH=#{ENV['TOOLCHAIN_PATH']}:$PATH"\
     " && cd #{path}"\
     " && ./configure #{configure_flags(lib_opts[:configure])}"\
     " && make"\
     " && make install"\
     " && echo '\n\n'"
  }
  
end
