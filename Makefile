CXXFLAGS = -O3 -g0 -march=native
LDFLAGS = $(CXXFLAGS)
BUILD_DATE = `date +'%Y%m%d%H%M%S'`

releases/dnsseed: dns.o umkoin.o netbase.o protocol.o db.o main.o util.o
	g++ -pthread $(LDFLAGS) -o releases/dnsseed-$(BUILD_DATE) dns.o umkoin.o netbase.o protocol.o db.o main.o util.o -lcrypto

%.o: %.cpp umkoin.h netbase.h protocol.h db.h serialize.h uint256.h util.h
	g++ -std=c++11 -pthread $(CXXFLAGS) -Wall -Wno-unused -Wno-sign-compare -Wno-reorder -Wno-comment -c -o $@ $<

dns.o: dns.c
	gcc -pthread -std=c99 $(CXXFLAGS) dns.c -Wall -c -o dns.o

%.o: %.cpp
