macro(build_hdf5 install_prefix staging_prefix  zlib_include_dir zlib_library zlib_dir)
  
  
set(CMAKE_OSX_EXTERNAL_PROJECT_ARGS)
if(APPLE)
  list(APPEND CMAKE_OSX_EXTERNAL_PROJECT_ARGS
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
    -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
    -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
  )
endif()


ExternalProject_Add(HDF5
  URL "http://www.hdfgroup.org/ftp/HDF5/current/src-old/hdf5-1.8.12.tar.bz2"
  URL_MD5 "75829af785e54332cdef6ad5a4a96607"
  SOURCE_DIR HDF5
  BINARY_DIR HDF5-build
  CMAKE_GENERATOR ${CMAKE_GEN}
  CMAKE_ARGS
      -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
      -DBUILD_SHARED_LIBS:BOOL=${MT_BUILD_SHARED_LIBS}
      -DBUILD_STATIC_EXECS:BOOL=OFF
      -DCMAKE_SKIP_RPATH:BOOL=ON
      -DCMAKE_SKIP_INSTALL_RPATH:BOOL=ON
      -DCMAKE_INSTALL_PREFIX:PATH=${install_prefix}
      -DHDF5_INSTALL_CMAKE_DIR:PATH=${install_prefix}
      -DHDF5_NO_PACKAGES:BOOL=ON
      -DCMAKE_CXX_FLAGS:STRING=-fPIC
      -DCMAKE_C_FLAGS:STRING=-fPIC
      -DHDF5_BUILD_CPP_LIB:BOOL=ON
      -DHDF5_BUILD_TOOLS:BOOL=ON
      -DHDF5_ENABLE_Z_LIB_SUPPORT=ON
      ${CMAKE_OSX_EXTERNAL_PROJECT_ARGS}
      -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
      -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
      -DCMAKE_EXE_LINKER_FLAGS:STRING=${CMAKE_EXE_LINKER_FLAGS}
      -DCMAKE_MODULE_LINKER_FLAGS:STRING=${CMAKE_MODULE_LINKER_FLAGS}
      -DCMAKE_SHARED_LINKER_FLAGS:STRING=${CMAKE_SHARED_LINKER_FLAGS}
#      -DZLIB_USE_EXTERNAL:BOOL=ON
#      -DZLIB_DIR:PATH=${zlib_library_dir}
      -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
      -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
      -DZLIB_INCLUDE_DIRS:STRING=${zlib_include_dir}
      -DZLIB_LIBRARIES:STRING=${zlib_library}
      -DZLIB_INCLUDE_DIR:STRING=${zlib_include_dir}
      -DZLIB_LIBRARY:STRING=${zlib_library}
#      -DZLIB_DIR:PATH=${zlib_dir}
#      -DH5_ZLIB_HEADER="zlib.h"
  INSTALL_COMMAND make install DESTDIR=${staging_prefix}
  INSTALL_DIR ${staging_prefix}/${install_prefix}
)

SET(HDF5_LIB_SUFFIX ".a")
IF(MT_BUILD_SHARED_LIBS)
  IF(APPLE)
    SET(HDF5_LIB_SUFFIX ".dylib")
  ELSE(APPLE)
    SET(HDF5_LIB_SUFFIX ".so")
  ENDIF(APPLE)
ENDIF(MT_BUILD_SHARED_LIBS)

SET(HDF5_BIN_DIR     ${staging_prefix}/${install_prefix}/bin )
SET(HDF5_INCLUDE_DIR ${staging_prefix}/${install_prefix}/include )
SET(HDF5_LIBRARY_DIR ${staging_prefix}/${install_prefix}/lib${LIB_SUFFIX} )
SET(HDF5_LIBRARY     ${staging_prefix}/${install_prefix}/lib${LIB_SUFFIX}/libhdf5${HDF5_LIB_SUFFIX} )

SET(HDF5_DIR         ${staging_prefix}/${install_prefix}/share/cmake/hdf5)
SET(HDF5_FOUND ON)

endmacro(build_hdf5)
