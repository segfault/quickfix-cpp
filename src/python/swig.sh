#!/bin/sh

swig -I../C++ -threads -fastproxy -olddefs -features directors,autodoc=2  -D__cpp_noexcept_function_type -DHAVE_SSL=1 -DHAVE_MYSQL -DHAVE_POSTGRESQL -python -c++ -o QuickfixPython.cpp quickfix.i
sed -i "s/quickfix\.//g" quickfix_fields.py
sed -i "s/import quickfix//g" quickfix_fields.py
cat quickfix_fields.py >> quickfix.py
sed -i "s/object.__getattr__/object.__getattribute__/g" quickfix.py
