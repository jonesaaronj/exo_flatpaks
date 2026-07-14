#!/bin/bash

export BOX64_PATH=/app/wine/bin
export BOX64_LD_LIBRARY_PATH=/app/wine/lib64:/app/wine/lib

exec box64 /app/wine/bin/wine "$@"
