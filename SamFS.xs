#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <catalog.h>
#include <devstat.h>
#include <stat.h>
#include <ustat.h>
#include <rminfo.h>
#include <version.h>
#include <lib.h>

/* Not declared in SamFS header files. */
char *sam_devstr(uint_t status);

static int
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(char *name, int arg)
{
    errno = 0;
    switch (*name) {
    case 'A':
	break;
    case 'B':
	if (strEQ(name, "BARCODE_LEN"))
#ifdef BARCODE_LEN
	    return BARCODE_LEN;
#else
	    goto not_there;
#endif
	break;
    case 'C':
	if (strEQ(name, "CATALOG_SLOT_DRIVE"))
#ifdef CATALOG_SLOT_DRIVE
	    return CATALOG_SLOT_DRIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CATALOG_SLOT_MAIL"))
#ifdef CATALOG_SLOT_MAIL
	    return CATALOG_SLOT_MAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CATALOG_SLOT_MEDIA"))
#ifdef CATALOG_SLOT_MEDIA
	    return CATALOG_SLOT_MEDIA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CF_ARCHIVED"))
#ifdef CF_ARCHIVED
	    return CF_ARCHIVED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CF_ARCH_I"))
#ifdef CF_ARCH_I
	    return CF_ARCH_I;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CF_DAMAGED"))
#ifdef CF_DAMAGED
	    return CF_DAMAGED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CF_REARCH"))
#ifdef CF_REARCH
	    return CF_REARCH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CF_STALE"))
#ifdef CF_STALE
	    return CF_STALE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CF_VAULT"))
#ifdef CF_VAULT
	    return CF_VAULT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_BAD_MEDIA"))
#ifdef CSP_BAD_MEDIA
	    return CSP_BAD_MEDIA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_BAR_CODE"))
#ifdef CSP_BAR_CODE
	    return CSP_BAR_CODE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_CLEANING"))
#ifdef CSP_CLEANING
	    return CSP_CLEANING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_EXPORT"))
#ifdef CSP_EXPORT
	    return CSP_EXPORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_INUSE"))
#ifdef CSP_INUSE
	    return CSP_INUSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_LABELED"))
#ifdef CSP_LABELED
	    return CSP_LABELED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_NEEDS_AUDIT"))
#ifdef CSP_NEEDS_AUDIT
	    return CSP_NEEDS_AUDIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_OCCUPIED"))
#ifdef CSP_OCCUPIED
	    return CSP_OCCUPIED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_READ_ONLY"))
#ifdef CSP_READ_ONLY
	    return CSP_READ_ONLY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_RECYCLE"))
#ifdef CSP_RECYCLE
	    return CSP_RECYCLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_UNAVAIL"))
#ifdef CSP_UNAVAIL
	    return CSP_UNAVAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CSP_WRITEPROTECT"))
#ifdef CSP_WRITEPROTECT
	    return CSP_WRITEPROTECT;
#else
	    goto not_there;
#endif
	break;
    case 'D':
	if (strEQ(name, "DT_CLASS_MASK"))
#ifdef DT_CLASS_MASK
	    return DT_CLASS_MASK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_CLASS_SHIFT"))
#ifdef DT_CLASS_SHIFT
	    return DT_CLASS_SHIFT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_DAT"))
#ifdef DT_DAT
	    return DT_DAT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_DATA"))
#ifdef DT_DATA
	    return DT_DATA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_DISK"))
#ifdef DT_DISK
	    return DT_DISK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_DISK_SET"))
#ifdef DT_DISK_SET
	    return DT_DISK_SET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_ERASABLE"))
#ifdef DT_ERASABLE
	    return DT_ERASABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_EXABYTE_TAPE"))
#ifdef DT_EXABYTE_TAPE
	    return DT_EXABYTE_TAPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_FAMILY_SET"))
#ifdef DT_FAMILY_SET
	    return DT_FAMILY_SET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_LINEAR_TAPE"))
#ifdef DT_LINEAR_TAPE
	    return DT_LINEAR_TAPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_MEDIA_MASK"))
#ifdef DT_MEDIA_MASK
	    return DT_MEDIA_MASK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_META"))
#ifdef DT_META
	    return DT_META;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_META_SET"))
#ifdef DT_META_SET
	    return DT_META_SET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_MULTIFUNCTION"))
#ifdef DT_MULTIFUNCTION
	    return DT_MULTIFUNCTION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_OPTICAL"))
#ifdef DT_OPTICAL
	    return DT_OPTICAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_RAID"))
#ifdef DT_RAID
	    return DT_RAID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_ROBOT"))
#ifdef DT_ROBOT
	    return DT_ROBOT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_ROBOT_MASK"))
#ifdef DT_ROBOT_MASK
	    return DT_ROBOT_MASK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_SCSI_R"))
#ifdef DT_SCSI_R
	    return DT_SCSI_R;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_SCSI_ROBOT_MASK"))
#ifdef DT_SCSI_ROBOT_MASK
	    return DT_SCSI_ROBOT_MASK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_SQUARE_TAPE"))
#ifdef DT_SQUARE_TAPE
	    return DT_SQUARE_TAPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_TAPE"))
#ifdef DT_TAPE
	    return DT_TAPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_TAPE_R"))
#ifdef DT_TAPE_R
	    return DT_TAPE_R;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_TAPE_SR"))
#ifdef DT_TAPE_SR
	    return DT_TAPE_SR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_VIDEO_TAPE"))
#ifdef DT_VIDEO_TAPE
	    return DT_VIDEO_TAPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_WORM_OPTICAL"))
#ifdef DT_WORM_OPTICAL
	    return DT_WORM_OPTICAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DT_WORM_OPTICAL_12"))
#ifdef DT_WORM_OPTICAL_12
	    return DT_WORM_OPTICAL_12;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_ATTENTION"))
#ifdef DVST_ATTENTION
	    return DVST_ATTENTION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_AUDIT"))
#ifdef DVST_AUDIT
	    return DVST_AUDIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_BAD_MEDIA"))
#ifdef DVST_BAD_MEDIA
	    return DVST_BAD_MEDIA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_CLEANING"))
#ifdef DVST_CLEANING
	    return DVST_CLEANING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_FORWARD"))
#ifdef DVST_FORWARD
	    return DVST_FORWARD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_FS_ACTIVE"))
#ifdef DVST_FS_ACTIVE
	    return DVST_FS_ACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_I_E_PORT"))
#ifdef DVST_I_E_PORT
	    return DVST_I_E_PORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_LABELED"))
#ifdef DVST_LABELED
	    return DVST_LABELED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_MAINT"))
#ifdef DVST_MAINT
	    return DVST_MAINT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_MOUNTED"))
#ifdef DVST_MOUNTED
	    return DVST_MOUNTED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_OPENED"))
#ifdef DVST_OPENED
	    return DVST_OPENED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_POSITION"))
#ifdef DVST_POSITION
	    return DVST_POSITION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_PRESENT"))
#ifdef DVST_PRESENT
	    return DVST_PRESENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_READY"))
#ifdef DVST_READY
	    return DVST_READY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_READ_ONLY"))
#ifdef DVST_READ_ONLY
	    return DVST_READ_ONLY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_REQUESTED"))
#ifdef DVST_REQUESTED
	    return DVST_REQUESTED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_SCANNED"))
#ifdef DVST_SCANNED
	    return DVST_SCANNED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_SCANNING"))
#ifdef DVST_SCANNING
	    return DVST_SCANNING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_SCAN_ERR"))
#ifdef DVST_SCAN_ERR
	    return DVST_SCAN_ERR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_STAGE_ACT"))
#ifdef DVST_STAGE_ACT
	    return DVST_STAGE_ACT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_STOR_FULL"))
#ifdef DVST_STOR_FULL
	    return DVST_STOR_FULL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_UNLOAD"))
#ifdef DVST_UNLOAD
	    return DVST_UNLOAD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_WAIT_IDLE"))
#ifdef DVST_WAIT_IDLE
	    return DVST_WAIT_IDLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DVST_WR_LOCK"))
#ifdef DVST_WR_LOCK
	    return DVST_WR_LOCK;
#else
	    goto not_there;
#endif
	break;
    case 'E':
	break;
    case 'F':
	break;
    case 'G':
	break;
    case 'H':
	break;
    case 'I':
	break;
    case 'J':
	break;
    case 'K':
	break;
    case 'L':
	break;
    case 'M':
	if (strEQ(name, "MAX_ARCHIVE"))
#ifdef MAX_ARCHIVE
	    return MAX_ARCHIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_CAT"))
#ifdef MAX_CAT
	    return MAX_CAT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_VSNS"))
#ifdef MAX_VSNS
	    return MAX_VSNS;
#else
	    goto not_there;
#endif
	break;
    case 'N':
	break;
    case 'O':
	break;
    case 'P':
	break;
    case 'Q':
	break;
    case 'R':
	if (strEQ(name, "RI_blockio"))
#ifdef RI_blockio
	    return RI_blockio;
#else
	    goto not_there;
#endif
	break;
    case 'S':
	if (strEQ(name, "SAM_FIXV"))

#ifdef SS_ARCHDONE
	    return SS_ARCHDONE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_ARCHIVED"))
#ifdef SS_ARCHIVED
	    return SS_ARCHIVED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_ARCHIVE_A"))
#ifdef SS_ARCHIVE_A
	    return SS_ARCHIVE_A;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_ARCHIVE_N"))
#ifdef SS_ARCHIVE_N
	    return SS_ARCHIVE_N;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_ARCHIVE_R"))
#ifdef SS_ARCHIVE_R
	    return SS_ARCHIVE_R;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_CSGEN"))
#ifdef SS_CSGEN
	    return SS_CSGEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_CSUSE"))
#ifdef SS_CSUSE
	    return SS_CSUSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_CSVAL"))
#ifdef SS_CSVAL
	    return SS_CSVAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_DAMAGED"))
#ifdef SS_DAMAGED
	    return SS_DAMAGED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_OFFLINE"))
#ifdef SS_OFFLINE
	    return SS_OFFLINE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_RELEASE_A"))
#ifdef SS_RELEASE_A
	    return SS_RELEASE_A;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_RELEASE_N"))
#ifdef SS_RELEASE_N
	    return SS_RELEASE_N;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_RELEASE_P"))
#ifdef SS_RELEASE_P
	    return SS_RELEASE_P;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_REMEDIA"))
#ifdef SS_REMEDIA
	    return SS_REMEDIA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_SAMFS"))
#ifdef SS_SAMFS
	    return SS_SAMFS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_STAGEFAIL"))
#ifdef SS_STAGEFAIL
	    return SS_STAGEFAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_STAGE_A"))
#ifdef SS_STAGE_A
	    return SS_STAGE_A;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_STAGE_N"))
#ifdef SS_STAGE_N
	    return SS_STAGE_N;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SS_STAGING"))
#ifdef SS_STAGING
	    return SS_STAGING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IRGRP"))
#ifdef S_IRGRP
	    return S_IRGRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IROTH"))
#ifdef S_IROTH
	    return S_IROTH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IRUSR"))
#ifdef S_IRUSR
	    return S_IRUSR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IRWXG"))
#ifdef S_IRWXG
	    return S_IRWXG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IRWXO"))
#ifdef S_IRWXO
	    return S_IRWXO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IRWXU"))
#ifdef S_IRWXU
	    return S_IRWXU;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IWGRP"))
#ifdef S_IWGRP
	    return S_IWGRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IWOTH"))
#ifdef S_IWOTH
	    return S_IWOTH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IWUSR"))
#ifdef S_IWUSR
	    return S_IWUSR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IXGRP"))
#ifdef S_IXGRP
	    return S_IXGRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IXOTH"))
#ifdef S_IXOTH
	    return S_IXOTH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "S_IXUSR"))
#ifdef S_IXUSR
	    return S_IXUSR;
#else
	    goto not_there;
#endif
	break;
    case 'T':
	break;
    case 'U':
	break;
    case 'V':
	break;
    case 'W':
	break;
    case 'X':
	break;
    case 'Y':
	break;
    case 'Z':
	break;
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}

char buff[21];

char *
ull2s(u_longlong_t value)
{
	sprintf(buff, "%llu", value);
	return buff;
}

MODULE = Filesys::SamFS		PACKAGE = Filesys::SamFS		PREFIX = sam_

PROTOTYPES: DISABLE

double
constant(name,arg)
	char *		name
	int		arg

char *
sam_FIXV()
CODE:
	RETVAL = SAM_FIXV;
OUTPUT:
	RETVAL

char *
sam_MAJORV()
CODE:
	RETVAL = SAM_MAJORV;
OUTPUT:
	RETVAL

char *
sam_MINORV()
CODE:
	RETVAL = SAM_MINORV;
OUTPUT:
	RETVAL

char *
sam_NAME()
CODE:
	RETVAL = SAM_NAME;
OUTPUT:
	RETVAL

char *
sam_VERSION()
CODE:
	RETVAL = SAM_VERSION;
OUTPUT:
	RETVAL

int
sam_S_ISBLK(mode)
	int mode;
CODE:
	RETVAL = S_ISBLK(mode);
OUTPUT:
	RETVAL

int
sam_S_ISCHR(mode)
	int mode;
CODE:
	RETVAL = S_ISCHR(mode);
OUTPUT:
	RETVAL

int
sam_S_ISDIR(mode)
	int mode;
CODE:
	RETVAL = S_ISDIR(mode);
OUTPUT:
	RETVAL

int
sam_S_ISFIFO(mode)
	int mode;
CODE:
	RETVAL = S_ISFIFO(mode);
OUTPUT:
	RETVAL

int
sam_S_ISGID(mode)
	int mode;
CODE:
	RETVAL = S_ISGID(mode);
OUTPUT:
	RETVAL

int
sam_S_ISREG(mode)
	int mode;
CODE:
	RETVAL = S_ISREG(mode);
OUTPUT:
	RETVAL

int
sam_S_ISUID(mode)
	int mode;
CODE:
	RETVAL = S_ISUID(mode);
OUTPUT:
	RETVAL

int
sam_S_ISLNK(mode)
	int mode;
CODE:
	RETVAL = S_ISLNK(mode);
OUTPUT:
	RETVAL

int
sam_SS_ISSAMFS(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_SAMFS) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISREMEDIA(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_REMEDIA) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISARCHIVED(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_ARCHIVED) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISARCHDONE(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_ARCHDONE) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISDAMAGED(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_DAMAGED) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISOFFLINE(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_OFFLINE) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISARCHIVE_N(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_ARCHIVE_N) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISARCHIVE_A(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_ARCHIVE_A) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISARCHIVE_R(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_ARCHIVE_R) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISRELEASE_A(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_RELEASE_A) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISRELEASE_N(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_RELEASE_N) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISRELEASE_P(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_RELEASE_P) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISSTAGE_A(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_STAGE_A) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISSTAGE_N(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_STAGE_N) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISCSGEN(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_CSGEN) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISCSUSE(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_CSUSE) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISCSVAL(attr)
	int attr;
CODE:
	RETVAL = (attr & SS_CSVAL) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISSTAGING(flags)
	int flags;
CODE:
	RETVAL = (flags & SS_STAGING) != 0;
OUTPUT:
	RETVAL

int
sam_SS_ISSTAGEFAIL(flags)
	int flags;
CODE:
	RETVAL = (flags & SS_STAGEFAIL) != 0;
OUTPUT:
	RETVAL

int
sam_CS_NEEDS_AUDIT(status)
	int status;
CODE:
	RETVAL = (status & CSP_NEEDS_AUDIT) != 0;
OUTPUT:
	RETVAL

int
sam_CS_INUSE(status)
	int status;
CODE:
	RETVAL = (status & CSP_INUSE) != 0;
OUTPUT:
	RETVAL

int
sam_CS_LABELED(status)
	int status;
CODE:
	RETVAL = (status & CSP_LABELED) != 0;
OUTPUT:
	RETVAL

int
sam_CS_BADMEDIA(status)
	int status;
CODE:
	RETVAL = (status & CSP_BAD_MEDIA) != 0;
OUTPUT:
	RETVAL

int
sam_CS_OCCUPIED(status)
	int status;
CODE:
	RETVAL = (status & CSP_OCCUPIED) != 0;
OUTPUT:
	RETVAL

int
sam_CS_CLEANING(status)
	int status;
CODE:
	RETVAL = (status & CSP_CLEANING) != 0;
OUTPUT:
	RETVAL

int
sam_CS_BARCODE(status)
	int status;
CODE:
	RETVAL = (status & CSP_BAR_CODE) != 0;
OUTPUT:
	RETVAL

int
sam_CS_WRTPROT(status)
	int status;
CODE:
	RETVAL = (status & CSP_WRITEPROTECT) != 0;
OUTPUT:
	RETVAL

int
sam_CS_RDONLY(status)
	int status;
CODE:
	RETVAL = (status & CSP_READ_ONLY) != 0;
OUTPUT:
	RETVAL

int
sam_CS_RECYCLE(status)
	int status;
CODE:
	RETVAL = (status & CSP_RECYCLE) != 0;
OUTPUT:
	RETVAL

int
sam_CS_UNAVAIL(status)
	int status;
CODE:
	RETVAL = (status & CSP_UNAVAIL) != 0;
OUTPUT:
	RETVAL

int
sam_CS_EXPORT(status)
	int status;
CODE:
	RETVAL = (status & CSP_EXPORT) != 0;
OUTPUT:
	RETVAL

void
sam_stat(path)
	char *path
PREINIT:
	struct sam_stat statbuf;
	int retval;
	int i;
PPCODE:
	retval = sam_stat(path, &statbuf, sizeof statbuf);
	if (retval == 0) {
		EXTEND(SP, 22+MAX_ARCHIVE);
 /*  0 */	PUSHs(sv_2mortal(newSViv(statbuf.st_dev)));
 /*  1 */	PUSHs(sv_2mortal(newSViv(statbuf.st_ino)));
 /*  2 */	PUSHs(sv_2mortal(newSViv(statbuf.st_mode)));
 /*  3 */	PUSHs(sv_2mortal(newSViv(statbuf.st_nlink)));
 /*  4 */	PUSHs(sv_2mortal(newSViv(statbuf.st_uid)));
 /*  5 */	PUSHs(sv_2mortal(newSViv(statbuf.st_gid)));
 /*  6 */	PUSHs(sv_2mortal(newSViv(statbuf.rdev)));
 /*  7 */	PUSHs(sv_2mortal(newSVpv(ull2s(statbuf.st_size), 0)));
 /*  8 */	PUSHs(sv_2mortal(newSViv(statbuf.st_atime)));
 /*  9 */	PUSHs(sv_2mortal(newSViv(statbuf.st_mtime)));
 /* 10 */	PUSHs(sv_2mortal(newSViv(statbuf.st_ctime)));
 /* 11 */	PUSHs(&PL_sv_undef);	/* blksize */
 /* 12 */	PUSHs(&PL_sv_undef);	/* blocks */
 /* 13 */	PUSHs(sv_2mortal(newSViv(statbuf.attr)));
 /* 14 */	PUSHs(sv_2mortal(newSViv(statbuf.attribute_time)));
 /* 15 */	PUSHs(sv_2mortal(newSViv(statbuf.creation_time)));
 /* 16 */	PUSHs(sv_2mortal(newSViv(statbuf.residence_time)));
 /* 17 */	PUSHs(sv_2mortal(newSViv(statbuf.cs_algo)));
 /* 19 */	PUSHs(sv_2mortal(newSViv(statbuf.flags)));
 /* 20 */	PUSHs(sv_2mortal(newSViv(statbuf.gen)));
 /* 21 */	PUSHs(sv_2mortal(newSViv(statbuf.partial_size)));
		for (i=0; i<MAX_ARCHIVE; i++) {
			AV *av = newAV();
			av_extend(av, 7);
			PUSHs(sv_2mortal(newRV_noinc((SV*)av)));
			av_store(av, 0, newSViv(statbuf.copy[i].flags));
			av_store(av, 1, newSViv(statbuf.copy[i].n_vsns));
			av_store(av, 2, newSViv(statbuf.copy[i].creation_time));
			av_store(av, 3, newSVpv(ull2s(statbuf.copy[i].position), 0));
			av_store(av, 4, newSViv(statbuf.copy[i].offset));
			av_store(av, 5, newSVpv(statbuf.copy[i].media, 0));
			av_store(av, 6, newSVpv(statbuf.copy[i].vsn, 0));
		}
	}

void
sam_lstat(path)
	char *path
PREINIT:
	struct sam_stat statbuf;
	int retval;
	int i;
PPCODE:
	retval = sam_lstat(path, &statbuf, sizeof statbuf);
	if (retval == 0) {
		EXTEND(SP, 22+MAX_ARCHIVE);
 /*  0 */	PUSHs(sv_2mortal(newSViv(statbuf.st_dev)));
 /*  1 */	PUSHs(sv_2mortal(newSViv(statbuf.st_ino)));
 /*  2 */	PUSHs(sv_2mortal(newSViv(statbuf.st_mode)));
 /*  3 */	PUSHs(sv_2mortal(newSViv(statbuf.st_nlink)));
 /*  4 */	PUSHs(sv_2mortal(newSViv(statbuf.st_uid)));
 /*  5 */	PUSHs(sv_2mortal(newSViv(statbuf.st_gid)));
 /*  6 */	PUSHs(sv_2mortal(newSViv(statbuf.rdev)));
 /*  7 */	PUSHs(sv_2mortal(newSVpv(ull2s(statbuf.st_size), 0)));
 /*  8 */	PUSHs(sv_2mortal(newSViv(statbuf.st_atime)));
 /*  9 */	PUSHs(sv_2mortal(newSViv(statbuf.st_mtime)));
 /* 10 */	PUSHs(sv_2mortal(newSViv(statbuf.st_ctime)));
 /* 11 */	PUSHs(&PL_sv_undef);	/* blksize */
 /* 12 */	PUSHs(&PL_sv_undef);	/* blocks */
 /* 13 */	PUSHs(sv_2mortal(newSViv(statbuf.attr)));
 /* 14 */	PUSHs(sv_2mortal(newSViv(statbuf.attribute_time)));
 /* 15 */	PUSHs(sv_2mortal(newSViv(statbuf.creation_time)));
 /* 16 */	PUSHs(sv_2mortal(newSViv(statbuf.residence_time)));
 /* 17 */	PUSHs(sv_2mortal(newSViv(statbuf.cs_algo)));
 /* 19 */	PUSHs(sv_2mortal(newSViv(statbuf.flags)));
 /* 20 */	PUSHs(sv_2mortal(newSViv(statbuf.gen)));
 /* 21 */	PUSHs(sv_2mortal(newSViv(statbuf.partial_size)));
		for (i=0; i<MAX_ARCHIVE; i++) {
			AV *av = newAV();
			av_extend(av, 7);
			PUSHs(sv_2mortal(newRV_noinc((SV*)av)));
			av_store(av, 0, newSViv(statbuf.copy[i].flags));
			av_store(av, 1, newSViv(statbuf.copy[i].n_vsns));
			av_store(av, 2, newSViv(statbuf.copy[i].creation_time));
			av_store(av, 3, newSVpv(ull2s(statbuf.copy[i].position), 0));
			av_store(av, 4, newSViv(statbuf.copy[i].offset));
			av_store(av, 5, newSVpv(statbuf.copy[i].media, 0));
			av_store(av, 6, newSVpv(statbuf.copy[i].vsn, 0));
		}
	}

void
sam_vsn_stat(path, copy)
	char *	path
	int	copy
PREINIT:
	struct sam_vsn_stat statbuf;
	int retval;
	int i;
PPCODE:
	retval = sam_vsn_stat(path, copy, &statbuf, sizeof statbuf);
	if (retval == 0) {
		EXTEND(SP, MAX_VSNS);
		for (i=0; i<MAX_VSNS; i++) {
			AV *av = newAV();
			av_extend(av, 4);
			PUSHs(sv_2mortal(newRV_noinc((SV*)av)));
			av_store(av, 0, newSVpv(statbuf.section[i].vsn, 0));
			av_store(av, 1, newSVpv(ull2s(statbuf.section[i].length), 0));
			av_store(av, 2, newSVpv(ull2s(statbuf.section[i].position), 0));
			av_store(av, 3, newSVpv(ull2s(statbuf.section[i].offset), 0));
		}
	}

char *
sam_attrtoa(attr)
	int	attr
CODE:
	RETVAL = sam_attrtoa(attr, NULL);
OUTPUT:
	RETVAL

void
sam_devstat(eq)
	int	eq
PREINIT:
	struct sam_devstat statbuf;
	int retval;
PPCODE:
	retval = sam_devstat(eq, &statbuf, sizeof statbuf);
	if (retval == 0) {
		EXTEND(SP, 7);
/* 0 */		PUSHs(sv_2mortal(newSViv(statbuf.type)));
/* 1 */		PUSHs(sv_2mortal(newSVpv(statbuf.name, 0)));
/* 2 */		PUSHs(sv_2mortal(newSVpv(statbuf.vsn, 0)));
/* 3 */		PUSHs(sv_2mortal(newSVpv(dev_state[statbuf.state], 0)));
/* 4 */		PUSHs(sv_2mortal(newSViv(statbuf.status)));
/* 5 */		PUSHs(sv_2mortal(newSViv(statbuf.space)));
/* 6 */		PUSHs(sv_2mortal(newSViv(statbuf.capacity)));
	}

void
sam_ndevstat(eq)
	int	eq
PREINIT:
	struct sam_ndevstat statbuf;
	int retval;
PPCODE:
	retval = sam_ndevstat(eq, &statbuf, sizeof statbuf);
	if (retval == 0) {
		EXTEND(SP, 7);
/* 0 */		PUSHs(sv_2mortal(newSViv(statbuf.type)));
/* 1 */		PUSHs(sv_2mortal(newSVpv(statbuf.name, 0)));
/* 2 */		PUSHs(sv_2mortal(newSVpv(statbuf.vsn, 0)));
/* 3 */		PUSHs(sv_2mortal(newSVpv(dev_state[statbuf.state], 0)));
/* 4 */		PUSHs(sv_2mortal(newSViv(statbuf.status)));
/* 5 */		PUSHs(sv_2mortal(newSViv(statbuf.space)));
/* 6 */		PUSHs(sv_2mortal(newSViv(statbuf.capacity)));
	}

char *
sam_devstr(status)
	int	status
CODE:
	RETVAL = sam_devstr(status);
OUTPUT:
	RETVAL

void
sam_opencat(path)
	char *	path
PREINIT:
	struct sam_cat_tbl catbuf;
	int retval;
PPCODE:
	retval = sam_opencat(path, &catbuf, sizeof catbuf);
	if (retval >= 0) {
		EXTEND(SP, 4);
/* 0 */		PUSHs(sv_2mortal(newSViv(retval)));
/* 1 */		PUSHs(sv_2mortal(newSViv(catbuf.audit_time)));
/* 2 */		PUSHs(sv_2mortal(newSViv(catbuf.version)));
/* 3 */		PUSHs(sv_2mortal(newSViv(catbuf.count)));
/* 4 */		PUSHs(sv_2mortal(newSVpv(catbuf.media, 0)));
	}

int
sam_closecat(cat_handle)
	int	cat_handle

void
sam_getcatalog(cat_handle, slot)
	int	cat_handle
	int	slot
PREINIT:
	struct sam_cat_ent	catbuf;
	int retval;
PPCODE:
	retval = sam_getcatalog(cat_handle, slot, slot, &catbuf, sizeof catbuf);
	if (retval >= 0) {
		EXTEND(SP, 11);
/* 0 */		PUSHs(sv_2mortal(newSViv(catbuf.type)));
/* 1 */		PUSHs(sv_2mortal(newSViv(catbuf.status)));
/* 2 */		PUSHs(sv_2mortal(newSVpv(catbuf.media, 0)));
/* 3 */		PUSHs(sv_2mortal(newSVpv(catbuf.vsn, 0)));
/* 4 */		PUSHs(sv_2mortal(newSViv(catbuf.access)));
/* 5 */		PUSHs(sv_2mortal(newSViv(catbuf.capacity)));
/* 6 */		PUSHs(sv_2mortal(newSViv(catbuf.space)));
/* 7 */		PUSHs(sv_2mortal(newSViv(catbuf.ptoc_fwa)));
/* 8 */		PUSHs(sv_2mortal(newSViv(catbuf.modification_time)));
/* 9 */		PUSHs(sv_2mortal(newSViv(catbuf.mount_time)));
/*10 */		PUSHs(sv_2mortal(newSVpv(catbuf.bar_code, 0)));
	}


int
sam_archive(name, opns)
	char *	name
	char *	opns

int
sam_cancelstage(name)
	char *	name

int
sam_release(name, opns)
	char *	name
	char *	opns

int
sam_ssum(name, opns)
	char *	name
	char *	opns

int
sam_stage(name, opns)
	char *	name
	char *	opns

int
sam_setfa(name, opns)
	char *	name
	char *	opns

int
sam_advise(fildes, opns)
	int	fildes
	char *	opns

# These two are not documented

#-# int
#-# sam_readrminfo(path, buf, bufsize)
#-# 	char *	path
#-# 	struct sam_rminfo *	buf
#-# 	size_t	bufsize
#-# 
#-# int
#-# sam_request(path, buf, bufsize)
#-# 	char *	path
#-# 	struct sam_rminfo *	buf
#-# 	size_t	bufsize
