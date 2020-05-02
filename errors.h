/*-------------------------------------------------\
|This file discribe the various error code returned|
|by this software.                                 |
\-------------------------------------------------*/

#define ERROR_NO_DIR 1
#define ERROR_NO_FILE 2
#define ERROR_ARGS 3
#define ERROR_UNWRITABLE 4
#define ERROR_FORMAT 5

#define addErrorLua(L) lua_pushinteger(L, ERROR_FORMAT);lua_setglobal(L,"ERROR_FORMAT");
