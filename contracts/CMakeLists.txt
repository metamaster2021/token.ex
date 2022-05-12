cmake_minimum_required( VERSION 3.5 )

project(contracts)

set(AMAX_WASM_OLD_BEHAVIOR "Off")
find_package(amax.cdt)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} $CACHE{CMAKE_CXX_FLAGS}")

set(ICON_BASE_URL "http://127.0.0.1/ricardian_assets/amax.contracts/icons")


set(TOKEN_ICON_URI    "token.png#207ff68b0406eaa56618b08bda81d6a0954543f36adc328ab3065f31a5c5d654")

add_subdirectory(amax.token)
