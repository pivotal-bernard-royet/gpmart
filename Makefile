vmart_gen: gpmart_gen.cpp
	$(CXX) -D_FILE_OFFSET_BITS=64 -static gpmart_gen.cpp -o gpmart_gen

clean:
	rm -f gpmart_gen
