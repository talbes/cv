cmake_minimum_required(VERSION 2.8)

project(CV NONE)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(UseLATEX)

add_subdirectory(image/)

add_latex_document(tym-cv.tex 
  DEPENDS tym-cv.cls 
  INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR}/image
  BIBFILES publications.bib
  FORCE_PDF
)