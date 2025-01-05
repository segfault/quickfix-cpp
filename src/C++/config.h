#ifndef CONFIG_H_IN
#define CONFIG_H_IN

#define HAVE_CXX17
/* #undef HAVE_STD_SHARED_PTR */
#ifdef _MSC_VER
#include "config_windows.h"
#else
#include "config_unix.h"
#endif

#define HAVE_CXX17
/* #undef HAVE_STD_SHARED_PTR */
/* #undef HAVE_MYSQL */
/* #undef HAVE_POSTGRESQL */
/* #undef HAVE_SSL */

#endif
