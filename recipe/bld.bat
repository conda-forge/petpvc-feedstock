setlocal EnableDelayedExpansion

:: config
cmake %CMAKE_ARGS% ^
    	-D CMAKE_BUILD_TYPE:STRING=Release ^
    	-D CMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    	-D CMAKE_PREFIX_PATH:PATH=%LIBRARY_PREFIX% ^
    	-G Ninja ^
	-B build ^
	-S %SRC_DIR%
if errorlevel 1 exit 1

:: build
cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

:: install
cmake --install build
if errorlevel 1 exit 1

:: post-install
rmdir /s /q "%LIBRARY_PREFIX%\parc"
if errorlevel 1 exit 1

:: test
ctest --test-dir build --extra-verbose --output-on-failure
if errorlevel 1 exit 1
