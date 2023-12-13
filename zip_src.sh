#!/bin/bash
# builds a source distribution
PROJECT_NAME=wadsmoosh
rm "$PROJECT_NAME"_src.zip
zip -ur9 $PROJECT_NAME.zip . -i@zip_src_include -x *.pyc
# put all this in a containing directory
mkdir $PROJECT_NAME
cd $PROJECT_NAME
unzip ../$PROJECT_NAME.zip
cd ..
rm $PROJECT_NAME.zip
zip -ur9 "$PROJECT_NAME"_src.zip $PROJECT_NAME/*
rm -rf $PROJECT_NAME/
