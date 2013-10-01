# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# remove duplicate libraries, generalized from PCLConfig.cmake.in
macro(_remove_duplicate_libraries _unfiltered_libraries _final_filtered_libraries)
  set(_filtered_libraries)
  set(_debug_libraries)
  set(_optimized_libraries)
  set(_other_libraries)
  set(_waiting_for_debug 0)
  set(_waiting_for_optimized 0)
  set(_library_position -1)
  foreach(library ${${_unfiltered_libraries}})
    if("${library}" STREQUAL "debug")
      set(_waiting_for_debug 1)
    elseif("${library}" STREQUAL "optimized")
      set(_waiting_for_optimized 1)
    elseif(_waiting_for_debug)
      list(FIND _debug_libraries "${library}" library_position)
      if(library_position EQUAL -1)
        list(APPEND ${_filtered_libraries} debug ${library})
        list(APPEND _debug_libraries ${library})
      endif()
      set(_waiting_for_debug 0)
    elseif(_waiting_for_optimized)
      list(FIND _optimized_libraries "${library}" library_position)
      if(library_position EQUAL -1)
        list(APPEND ${_filtered_libraries} optimized ${library})
        list(APPEND _optimized_libraries ${library})
      endif()
      set(_waiting_for_optimized 0)
    else("${library}" STREQUAL "debug")
      list(FIND _other_libraries "${library}" library_position)
      if(library_position EQUAL -1)
        list(APPEND ${_filtered_libraries} ${library})
        list(APPEND _other_libraries ${library})
      endif()
    endif("${library}" STREQUAL "debug")
  endforeach(library)
  set(_final_filtered_libraries _filtered_libraries)
endmacro()


if(my_msg_pkg_CONFIG_INCLUDED)
  return()
endif()
set(my_msg_pkg_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if(FALSE)
  set(my_msg_pkg_SOURCE_PREFIX C:/work/overlay/src/my_msg_pkg)
  set(my_msg_pkg_DEVEL_PREFIX C:/work/overlay/devel)
  set(my_msg_pkg_INSTALL_PREFIX "")
  set(my_msg_pkg_PREFIX ${my_msg_pkg_DEVEL_PREFIX})
else()
  set(my_msg_pkg_SOURCE_PREFIX "")
  set(my_msg_pkg_DEVEL_PREFIX "")
  set(my_msg_pkg_INSTALL_PREFIX C:/opt/ros/groovy/x86)
  set(my_msg_pkg_PREFIX ${my_msg_pkg_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'my_msg_pkg' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(my_msg_pkg_FOUND_CATKIN_PROJECT TRUE)

if(NOT "C:/opt/ros/groovy/x86/include" STREQUAL "")
  set(my_msg_pkg_INCLUDE_DIRS "")
  set(absolute_include_dirs "C:/opt/ros/groovy/x86/include")
  foreach(idir ${absolute_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif(IS_DIRECTORY C:/opt/ros/groovy/x86/${idir})
      set(include C:/opt/ros/groovy/x86/${idir})
    else()
      message(FATAL_ERROR "Project 'my_msg_pkg' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in 'C:/opt/ros/groovy/x86/${idir}'.  Ask the maintainer 'Admin <Admin@gmail.com>' to fix it.")
    endif()
    _list_append_unique(my_msg_pkg_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "")
foreach(library ${libraries})
  if(TARGET ${library})
    list(APPEND my_msg_pkg_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND my_msg_pkg_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path C:/opt/ros/groovy/x86/lib;C:/opt/ros/groovy/x86/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(my_msg_pkg_LIBRARY_DIRS ${lib_path})
      list(APPEND my_msg_pkg_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'my_msg_pkg'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND my_msg_pkg_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(my_msg_pkg_EXPORTED_TARGETS "my_msg_pkg_generate_messages_cpp;my_msg_pkg_generate_messages_lisp;my_msg_pkg_generate_messages_py")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${my_msg_pkg_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "message_runtime;std_msgs")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 my_msg_pkg_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${my_msg_pkg_dep}_FOUND)
      find_package(${my_msg_pkg_dep} REQUIRED)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${my_msg_pkg_dep} REQUIRED ${depend_list})
  endif()
  _list_append_unique(my_msg_pkg_INCLUDE_DIRS ${${my_msg_pkg_dep}_INCLUDE_DIRS})
  list(APPEND my_msg_pkg_LIBRARIES ${${my_msg_pkg_dep}_LIBRARIES})
  _list_append_unique(my_msg_pkg_LIBRARY_DIRS ${${my_msg_pkg_dep}_LIBRARY_DIRS})
  list(APPEND my_msg_pkg_EXPORTED_TARGETS ${${my_msg_pkg_dep}_EXPORTED_TARGETS})
endforeach()

if(my_msg_pkg_LIBRARIES)
  _remove_duplicate_libraries(my_msg_pkg_LIBRARIES my_msg_pkg_LIBRARIES)
endif()

set(pkg_cfg_extras "C:/opt/ros/groovy/x86/share/my_msg_pkg/cmake/my_msg_pkg-msg-extras.cmake")
foreach(extra ${pkg_cfg_extras})
  include(${extra})
endforeach()