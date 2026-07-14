#!/usr/bin/env python3
"""Restore p_cellref_init in gnumeric's psiconv plugin.

Gnumeric 1.12.61 rewrote set_format() in plugins/psiconv/psiconv-read.c and
accidentally deleted the p_cellref_init() helper along with the obsolete
append_zeros() - but p_cellref_init is still called in two places, so the
psiconv plugin no longer compiles (implicit declaration of 'p_cellref_init').
This re-inserts the helper exactly as it appeared in 1.12.60.

Usage: gnumeric-psiconv-fix.py <path/to/plugins/psiconv/psiconv-read.c>
Idempotent; fails loudly if the expected anchor is missing.
"""
import sys

path = sys.argv[1]
src = open(path, encoding="utf-8").read()

if "p_cellref_init (GnmCellRef *res" in src:
    print("gnumeric-psiconv-fix: already patched (or helper present)")
    sys.exit(0)

if "p_cellref_init" not in src:
    print("gnumeric-psiconv-fix: p_cellref_init no longer used; nothing to do")
    sys.exit(0)

anchor = (
    "static GnmValue *\n"
    "psi_new_string (psiconv_ucs2 const *data)\n"
    "{\n"
    "\treturn value_new_string_nocopy (\n"
    "\t\tg_utf16_to_utf8 (data, -1, NULL, NULL, NULL));\n"
    "}\n"
)
if anchor not in src:
    sys.exit("gnumeric-psiconv-fix: anchor not found - psiconv-read.c layout changed")

helper = anchor + (
    "\n"
    "/* Restored by portable-bundle patch: helper deleted by accident in\n"
    " * the 1.12.61 set_format() rewrite but still used below. */\n"
    "static GnmCellRef *\n"
    "p_cellref_init (GnmCellRef *res,\n"
    "\t\tint row, gboolean row_abs,\n"
    "\t\tint col, gboolean col_abs)\n"
    "{\n"
    "\tres->sheet = NULL;\n"
    "\tres->row = row;\n"
    "\tres->col = col;\n"
    "\tres->row_relative = row_abs ? 0 : 1;\n"
    "\tres->col_relative = col_abs ? 0 : 1;\n"
    "\treturn res;\n"
    "}\n"
)

src = src.replace(anchor, helper, 1)
open(path, "w", encoding="utf-8").write(src)
print("gnumeric-psiconv-fix: patched", path)
