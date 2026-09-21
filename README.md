# What is JEAN?
**JEAN** (Just Enough Array Notations) is a text configuration format designed for minimalistic data storage and data transfer.
<br>
Unlike other text configuration formats like JSON, the entirety of a .jean file is treated as an implicit array container.

# Example of JEAN:
```
entities.jean:

% entity_name (string), x (float), y (float), z (float), health (int), is_active (bool)
"Orc" 56.0 25.0 25.0 100 t
"Goblin" 25.0 25.0 -75.0 25 f
"Goblin" 16.5 25.0 -60.0 25 f
"Goblin" 12.5 25.0 -80.0 25 f
"Treasure Chest" -125.75 30.0 -80.0 -1 t % -1 in health means it's infinite
```

# Why should I care?
Most formats like JSON, TOML, and YAML are useful for general-purpose applications.
These formats can be unnecessarily verbose for small, hand-edited data files, especially in resource-constrained applications where simplicity and compactness matter.
<br>
JEAN solves these problems by:
* Using whitespace (" ", "\t", "\n") instead of structural punctuation can reduce the size and visual noise of simple data files
* Having as few types as possible (eg. "string" 1 -0.5 t/f [booleans])
* Treating the entire file as an implicit array, simplifying the parser

# Features:
* The entire file is treated as an implicit array
* Whitespace-based syntax
* Minimal data types
* Single-line comments (All of them begin with %)
* Simple parsing model
* A deliberately lightweight file format

# Use cases:
* Game-development data
* Embedded and resource-constrained systems
* Simple application configuration
* Custom tools and internal pipelines
* Inter-process communication

# Benchmark (Using Lua Parser)
## Disclaimer:
The figures shown are illustrative estimates for parsing 100 records.
Actual usage depends on the parser implementation, runtime, allocator, OS, and output data structure.
These figures are provided as a showcase and should not be treated as definitive benchmarks.

## Template file:
| id | first_name | last_name | email | age | role | is_active |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| int | string | string | string | int | string | bool |

## 100 Records (Raw):
| Format | Size | Speed | Memory |
| :--- | :---: | :---: | :---: |
| **JSON** | ~16.7 KB | ~0.15 ms | ~250 KB |
| **TOML** | ~13.4 KB | ~0.25 ms | ~300 KB |
| **YAML** | ~13.6 KB | ~0.55 ms | ~500 KB |
| **CSV** | ~5.9 KB | ~0.10 ms | ~100 KB |
| **JEAN** | ~6.0 KB | ~0.08 ms | ~120 KB |

## 100 Records (Minified):
| Format | Size | Speed | Memory |
| :--- | :---: | :---: | :---: |
| **JSON** | ~12.5 KB | ~0.14 ms | ~175 KB |
| **TOML** | ~11.9 KB | ~0.23 ms | ~156 KB |
| **YAML** | ~11.8 KB | ~0.50 ms | ~310 KB |
| **CSV** | Same | Same | ~60 KB |
| **JEAN** | ~5.5 KB | ~0.08 ms | ~90 KB |

## 100 Records (Compressed via GZIP):
| Format | Size | Speed | Memory |
| :--- | :---: | :---: | :---: |
| **JSON** | ~2.7 KB | ~0.17 ms | ~100 KB |
| **TOML** | ~2.6 KB | ~0.27 ms | ~120 KB |
| **YAML** | ~2.7 KB | ~0.56 ms | ~180 KB |
| **CSV** | ~1.4 KB | ~0.12 ms | ~40 KB |
| **JEAN** | ~2.2 KB | ~0.10 ms | ~50 KB |

# Disadvantages / Limitations:
* Since the records rely on a fixed field, rather than named keys, it is extremely delicate; removing one element may result in field shifting
* Because it is designed to save as much space as possible, it may be unreadable to some people without the use of comments
* It is not designed for general-purpose tasks in mind, use it where its simplicity and compactness are beneficial
