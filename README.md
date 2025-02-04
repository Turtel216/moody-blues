# Moody Blues  

*A Redis clone built with Zig*  

## Overview  

**Moody Blues** is a toy Redis clone implemented in [Zig](https://ziglang.org/). The primary goal of this project is to deepen our understanding of both Redis and Zig by building a simplified, yet functional, in-memory key-value store.  

This project is not intended to be production-ready but rather serves as a learning exercise in systems programming, networking, and data structures.  

## Features (Planned)  

- Basic Redis-like command support (`GET`, `SET`, `DEL`, `EXPIRE`)  
- TCP server handling client connections  
- Simple in-memory data store  
- Event-driven I/O model  
- Basic persistence (Append-Only File or Snapshotting)  

## Why Zig?  

Zig offers a fresh approach to systems programming with:  
- Manual memory management without the complexity of C++  
- A strong type system and safety features  
- Compile-time execution and metaprogramming  
- Simplicity and performance similar to C  

## Installation & Usage  

**Note:** This project is still in early development.  

### Prerequisites  
- Install [Zig](https://ziglang.org/download/)  

### Build & Run  

```sh
zig build
./zig-out/bin/moody-blues
```

### Connect via Redis CLI  

Once running, you can connect using the Redis CLI:  

```sh
redis-cli -p 6379
SET foo bar
GET foo
```

## Roadmap  

- [ ] Implement a basic command parser  
- [ ] Support more Redis commands  
- [ ] Add persistence  
- [ ] Benchmark performance  
- [ ] Improve memory efficiency  

## Contributing  

This is a personal learning project, but if you're interested in contributing or discussing ideas, feel free to open an issue!  

## License  

MIT License.
