# Just Enough Array Notations
**JEAN** (Just Enough Array Notations) is a text configuration format designed for bare-metal data storage and data transfer.
<br>
Unlike other text configuration formats like JSON, the entirety of a .jean file is treated as an implicit array container.

## Features
* File as an array container
* Whitespace as syntax (" ", "\t", "\n")
* Minimal types (eg. "string" 1 -0.5 t/f [booleans])
* Single-line comment support (eg. "% This is a comment.")
* Small footprint (<1 KB per ~50 elements)

## Use Cases
* Game Development
* Embedded Systems & Bare-Metal Hardware
* Data Transfer & Inter-Process Communication (IPC)
* Custom DSLs & Internal Tooling
