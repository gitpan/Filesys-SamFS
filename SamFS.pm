package Filesys::SamFS;

use strict;
use Carp;
use vars qw($VERSION @ISA @EXPORT_OK %EXPORT_TAGS $AUTOLOAD);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);

@EXPORT_OK = (
# Version defines
	'VERSION',
	'NAME',
	'MAJORV',
	'MINORV',
	'FIXV',

# stat functions and associated constants
	'sam_stat',
	'sam_lstat',
	'sam_attrtoa',
	'sam_vsn_stat',
	'MAX_ARCHIVE',
	'MAX_VSNS',

# mode macros
	'S_IRGRP',
	'S_IROTH',
	'S_IRUSR',
	'S_IRWXG',
	'S_IRWXO',
	'S_IRWXU',
	'S_IWGRP',
	'S_IWOTH',
	'S_IWUSR',
	'S_IXGRP',
	'S_IXOTH',
	'S_IXUSR',
	'S_ISBLK',
	'S_ISCHR',
	'S_ISDIR',
	'S_ISFIFO',
	'S_ISGID',
	'S_ISREG',
	'S_ISUID',
	'S_ISLNK',

# attr macros
	'SS_SAMFS',
	'SS_REMEDIA',
	'SS_ARCHIVED',
	'SS_ARCHDONE',
	'SS_DAMAGED',
	'SS_CSGEN',
	'SS_CSUSE',
	'SS_CSVAL',
	'SS_OFFLINE',
	'SS_ARCHIVE_N',
	'SS_ARCHIVE_R',
	'SS_ARCHIVE_A',
	'SS_RELEASE_A',
	'SS_RELEASE_N',
	'SS_RELEASE_P',
	'SS_STAGE_A',
	'SS_STAGE_N',
	'SS_ISSAMFS',
	'SS_ISREMEDIA',
	'SS_ISARCHIVED',
	'SS_ISARCHDONE',
	'SS_ISDAMAGED',
	'SS_ISOFFLINE',
	'SS_ISARCHIVE_N',
	'SS_ISARCHIVE_A',
	'SS_ISARCHIVE_R',
	'SS_ISRELEASE_A',
	'SS_ISRELEASE_N',
	'SS_ISRELEASE_P',
	'SS_ISSTAGE_A',
	'SS_ISSTAGE_N',
	'SS_ISCSGEN',
	'SS_ISCSUSE',
	'SS_ISCSVAL',

# flag macros
	'SS_STAGEFAIL',
	'SS_STAGING',
	'SS_ISSTAGING',
	'SS_ISSTAGEFAIL',

# Copy flag macros
	'CF_ARCHIVED',
	'CF_ARCH_I',
	'CF_DAMAGED',
	'CF_REARCH',
	'CF_STALE',
	'CF_VAULT',

# devstat and associated constants
	'sam_devstat',
	'sam_ndevstat',
	'sam_devstr',
	'DT_CLASS_MASK',
	'DT_CLASS_SHIFT',
	'DT_DAT',
	'DT_DATA',
	'DT_DISK',
	'DT_DISK_SET',
	'DT_ERASABLE',
	'DT_EXABYTE_TAPE',
	'DT_FAMILY_SET',
	'DT_LINEAR_TAPE',
	'DT_MEDIA_MASK',
	'DT_META',
	'DT_META_SET',
	'DT_MULTIFUNCTION',
	'DT_OPTICAL',
	'DT_RAID',
	'DT_ROBOT',
	'DT_ROBOT_MASK',
	'DT_SCSI_R',
	'DT_SCSI_ROBOT_MASK',
	'DT_SQUARE_TAPE',
	'DT_TAPE',
	'DT_TAPE_R',
	'DT_TAPE_SR',
	'DT_VIDEO_TAPE',
	'DT_WORM_OPTICAL',
	'DT_WORM_OPTICAL_12',
	'DVST_ATTENTION',
	'DVST_AUDIT',
	'DVST_BAD_MEDIA',
	'DVST_CLEANING',
	'DVST_FORWARD',
	'DVST_FS_ACTIVE',
	'DVST_I_E_PORT',
	'DVST_LABELED',
	'DVST_MAINT',
	'DVST_MOUNTED',
	'DVST_OPENED',
	'DVST_POSITION',
	'DVST_PRESENT',
	'DVST_READY',
	'DVST_READ_ONLY',
	'DVST_REQUESTED',
	'DVST_SCANNED',
	'DVST_SCANNING',
	'DVST_SCAN_ERR',
	'DVST_STAGE_ACT',
	'DVST_STOR_FULL',
	'DVST_UNLOAD',
	'DVST_WAIT_IDLE',
	'DVST_WR_LOCK',

# Catalog
	'sam_opencat',
	'sam_closecat',
	'sam_getcatalog',
	'MAX_CAT',
	'BARCODE_LEN',
	'CATALOG_SLOT_DRIVE',
	'CATALOG_SLOT_MAIL',
	'CATALOG_SLOT_MEDIA',
	'CSP_BAD_MEDIA',
	'CSP_BAR_CODE',
	'CSP_CLEANING',
	'CSP_EXPORT',
	'CSP_INUSE',
	'CSP_LABELED',
	'CSP_NEEDS_AUDIT',
	'CSP_OCCUPIED',
	'CSP_READ_ONLY',
	'CSP_RECYCLE',
	'CSP_UNAVAIL',
	'CSP_WRITEPROTECT',
	'CS_BADMEDIA',
	'CS_BARCODE',
	'CS_CLEANING',
	'CS_EXPORT',
	'CS_INUSE',
	'CS_LABELED',
	'CS_NEEDS_AUDIT',
	'CS_OCCUPIED',
	'CS_RDONLY',
	'CS_RECYCLE',
	'CS_UNAVAIL',
	'CS_WRTPROT',

# Not yet
	'RI_blockio',
);

%EXPORT_TAGS = (version => [ qw(
                             VERSION
                             NAME
                             MAJORV
                             MINORV
                             FIXV
                             ) ],
		stat => [ qw(
                             sam_stat
                             sam_lstat
                             sam_attrtoa
                             vsn_stat
                             MAX_ARCHIVE
                             MAX_VSNS
                             ) ],
	        mode => [ qw(
                             S_IRGRP
                             S_IROTH
                             S_IRUSR
                             S_IRWXG
                             S_IRWXO
                             S_IRWXU
                             S_IWGRP
                             S_IWOTH
                             S_IWUSR
                             S_IXGRP
                             S_IXOTH
                             S_IXUSR
                             S_ISBLK
                             S_ISCHR
                             S_ISDIR
                             S_ISFIFO
                             S_ISGID
                             S_ISREG
                             S_ISUID
                             S_ISLNK
                             ) ],
		attr => [ qw(
                             SS_SAMFS
                             SS_REMEDIA
                             SS_ARCHIVED
                             SS_ARCHDONE
                             SS_DAMAGED
                             SS_CSGEN
                             SS_CSUSE
                             SS_CSVAL
                             SS_OFFLINE
                             SS_ARCHIVE_N
                             SS_ARCHIVE_R
                             SS_ARCHIVE_A
                             SS_RELEASE_A
                             SS_RELEASE_N
                             SS_RELEASE_P
                             SS_STAGE_A
                             SS_STAGE_N
                             SS_ISSAMFS
                             SS_ISREMEDIA
                             SS_ISARCHIVED
                             SS_ISARCHDONE
                             SS_ISDAMAGED
                             SS_ISOFFLINE
                             SS_ISARCHIVE_N
                             SS_ISARCHIVE_A
                             SS_ISARCHIVE_R
                             SS_ISRELEASE_A
                             SS_ISRELEASE_N
                             SS_ISRELEASE_P
                             SS_ISSTAGE_A
                             SS_ISSTAGE_N
                             SS_ISCSGEN
                             SS_ISCSUSE
                             SS_ISCSVAL
                             )],
	        flags => [ qw(
                             SS_STAGEFAIL
                             SS_STAGING
                             SS_ISSTAGING
                             SS_ISSTAGEFAIL
                             )],
	        copyflags => [ qw(
                             CF_ARCHIVED
                             CF_ARCH_I
                             CF_DAMAGED
                             CF_REARCH
                             CF_STALE
                             CF_VAULT
                             )],
	        devstat => [ qw(
                             sam_devstat
                             sam_ndevstat
                             sam_devstr
                             DT_CLASS_MASK
                             DT_CLASS_SHIFT
                             DT_DAT
                             DT_DATA
                             DT_DISK
                             DT_DISK_SET
                             DT_ERASABLE
                             DT_EXABYTE_TAPE
                             DT_FAMILY_SET
                             DT_LINEAR_TAPE
                             DT_MEDIA_MASK
                             DT_META
                             DT_META_SET
                             DT_MULTIFUNCTION
                             DT_OPTICAL
                             DT_RAID
                             DT_ROBOT
                             DT_ROBOT_MASK
                             DT_SCSI_R
                             DT_SCSI_ROBOT_MASK
                             DT_SQUARE_TAPE
                             DT_TAPE
                             DT_TAPE_R
                             DT_TAPE_SR
                             DT_VIDEO_TAPE
                             DT_WORM_OPTICAL
                             DT_WORM_OPTICAL_12
                             DVST_ATTENTION
                             DVST_AUDIT
                             DVST_BAD_MEDIA
                             DVST_CLEANING
                             DVST_FORWARD
                             DVST_FS_ACTIVE
                             DVST_I_E_PORT
                             DVST_LABELED
                             DVST_MAINT
                             DVST_MOUNTED
                             DVST_OPENED
                             DVST_POSITION
                             DVST_PRESENT
                             DVST_READY
                             DVST_READ_ONLY
                             DVST_REQUESTED
                             DVST_SCANNED
                             DVST_SCANNING
                             DVST_SCAN_ERR
                             DVST_STAGE_ACT
                             DVST_STOR_FULL
                             DVST_UNLOAD
                             DVST_WAIT_IDLE
                             DVST_WR_LOCK
                             )],
	        catalog => [ qw(
                             sam_opencat
                             sam_closecat
                             sam_getcatalog
                             MAX_CAT
                             BARCODE_LEN
                             CATALOG_SLOT_DRIVE
                             CATALOG_SLOT_MAIL
                             CATALOG_SLOT_MEDIA
                             CSP_BAD_MEDIA
                             CSP_BARCODE
                             CSP_CLEANING
                             CSP_EXPORT
                             CSP_INUSE
                             CSP_LABELED
                             CSP_NEEDS_AUDIT
                             CSP_OCCUPIED
                             CSP_READ_ONLY
                             CSP_RECYCLE
                             CSP_UNAVAIL
                             CSP_WRITEPROTECT
                             CS_BADMEDIA
                             CS_BAR_CODE
                             CS_CLEANING
                             CS_EXPORT
                             CS_INUSE
                             CS_LABELED
                             CS_NEEDS_AUDIT
                             CS_OCCUPIED
                             CS_RDONLY
                             CS_RECYCLE
                             CS_UNAVAIL
                             CS_WRTPROT
                             )],
                             );
$VERSION = '0.021';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "& not defined" if $constname eq 'constant';
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
		croak "Your vendor has not defined SamFS macro $constname";
	}
    }
    no strict 'refs';
    *$AUTOLOAD = sub () { $val };
    goto &$AUTOLOAD;
}

bootstrap Filesys::SamFS $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

sub sam_stat {
  Filesys::SamFS::stat(@_);
}

sub sam_lstat {
  Filesys::SamFS::lstat(@_);
}

sub sam_vsn_stat {
  Filesys::SamFS::vsn_stat(@_);
}

sub sam_attrtoa {
  Filesys::SamFS::attrtoa(@_);
}

sub sam_devstat {
  Filesys::SamFS::devstat(@_);
}

sub sam_ndevstat {
  Filesys::SamFS::ndevstat(@_);
}

sub sam_devstr {
  Filesys::SamFS::devstr(@_);
}

sub sam_opencat {
  Filesys::SamFS::opencat(@_);
}

sub sam_closecat {
  Filesys::SamFS::closecat(@_);
}

sub sam_getcatalog {
  Filesys::SamFS::getcatalog(@_);
}

sub sam_archive {
  Filesys::SamFS::archive(@_);
}

sub sam_cancelstage {
  Filesys::SamFS::cancelstage(@_);
}

sub sam_release {
  Filesys::SamFS::release(@_);
}

sub sam_ssum {
  Filesys::SamFS::ssum(@_);
}

sub sam_stage {
  Filesys::SamFS::stage(@_);
}

sub sam_setfa {
  Filesys::SamFS::setfa(@_);
}

sub sam_advise {
  Filesys::SamFS::advise(@_);
}

1;
__END__

=head1 NAME

Filesys::SamFS - Perl extension mapping the SamFS API to Perl

=head1 SYNOPSIS

use Filesys::SamFS;

=head1 DESCRIPTION

Filesys::SamFS makes the SamFS API available to Perl. SamFS is a
HSM (Hierarchical Storage Management) Filesystem; it manages
files in two storage levels - a cache on disks and an archive
on removable media like magneto-optical disks or tapes.

SamFS is a product of LSC, Inc. For more information, please
refer to http://www.lsci.com/ .

=head1 Exported constants and functions

Filesys::SamFS does not export by default.
All constants and functions are available for explicit import
(i.e. use "Filesys::SamFS (VERSION)").
They have also been bundled up in useful groups for import with tags
(i.e. use "Filesys::SamFS (:version)").

The groups are the following:

=over

=item :version

VERSION
NAME
MAJORV
MINORV
FIXV

=item :stat

sam_stat()
sam_lstat()
sam_vsn_stat()
MAX_ARCHIVE
MAX_VSNS

=item :mode

S_IRGRP
S_IROTH
S_IRUSR
S_IRWXG
S_IRWXO
S_IRWXU
S_IWGRP
S_IWOTH
S_IWUSR
S_IXGRP
S_IXOTH
S_IXUSR
S_ISBLK(mode)
S_ISCHR(mode)
S_ISDIR(mode)
S_ISFIFO(mode)
S_ISGID(mode)
S_ISREG(mode)
S_ISUID(mode)
S_ISLNK(mode)

=item :attr

SS_SAMFS
SS_REMEDIA
SS_ARCHIVED
SS_ARCHDONE
SS_DAMAGED
SS_CSGEN
SS_CSUSE
SS_CSVAL
SS_OFFLINE
SS_ARCHIVE_N
SS_ARCHIVE_R
SS_ARCHIVE_A
SS_RELEASE_A
SS_RELEASE_N
SS_RELEASE_P
SS_STAGE_A
SS_STAGE_N
SS_ISSAMFS(attr)
SS_ISREMEDIA(attr)
SS_ISARCHIVED(attr)
SS_ISARCHDONE(attr)
SS_ISDAMAGED(attr)
SS_ISOFFLINE(attr)
SS_ISARCHIVE_N(attr)
SS_ISARCHIVE_A(attr)
SS_ISARCHIVE_R(attr)
SS_ISRELEASE_A(attr)
SS_ISRELEASE_N(attr)
SS_ISRELEASE_P(attr)
SS_ISSTAGE_A(attr)
SS_ISSTAGE_N(attr)
SS_ISCSGEN(attr)
SS_ISCSUSE(attr)
SS_ISCSVAL(attr)

=item :flags

SS_STAGEFAIL
SS_STAGING
SS_ISSTAGING(flags)
SS_ISSTAGEFAIL(flags)

=item :copyflags

CF_ARCHIVED
CF_ARCH_I
CF_DAMAGED
CF_REARCH
CF_STALE
CF_VAULT

=item :devstat

sam_devstat(eq)
sam_ndevstat(eq)
sam_devstr(status)
DT_CLASS_MASK
DT_CLASS_SHIFT
DT_DAT
DT_DATA
DT_DISK
DT_DISK_SET
DT_ERASABLE
DT_EXABYTE_TAPE
DT_FAMILY_SET
DT_LINEAR_TAPE
DT_MEDIA_MASK
DT_META
DT_META_SET
DT_MULTIFUNCTION
DT_OPTICAL
DT_RAID
DT_ROBOT
DT_ROBOT_MASK
DT_SCSI_R
DT_SCSI_ROBOT_MASK
DT_SQUARE_TAPE
DT_TAPE
DT_TAPE_R
DT_TAPE_SR
DT_VIDEO_TAPE
DT_WORM_OPTICAL
DT_WORM_OPTICAL_12
DVST_ATTENTION
DVST_AUDIT
DVST_BAD_MEDIA
DVST_CLEANING
DVST_FORWARD
DVST_FS_ACTIVE
DVST_I_E_PORT
DVST_LABELED
DVST_MAINT
DVST_MOUNTED
DVST_OPENED
DVST_POSITION
DVST_PRESENT
DVST_READY
DVST_READ_ONLY
DVST_REQUESTED
DVST_SCANNED
DVST_SCANNING
DVST_SCAN_ERR
DVST_STAGE_ACT
DVST_STOR_FULL
DVST_UNLOAD
DVST_WAIT_IDLE
DVST_WR_LOCK

=item :catalog

sam_opencat
sam_closecat
sam_getcatalog
MAX_CAT
BARCODE_LEN
CATALOG_SLOT_DRIVE
CATALOG_SLOT_MAIL
CATALOG_SLOT_MEDIA
CSP_BAD_MEDIA
CSP_BAR_CODE
CSP_CLEANING
CSP_EXPORT
CSP_INUSE
CSP_LABELED
CSP_NEEDS_AUDIT
CSP_OCCUPIED
CSP_READ_ONLY
CSP_RECYCLE
CSP_UNAVAIL
CSP_WRITEPROTECT
CS_BADMEDIA(status)
CS_BARCODE(status)
CS_CLEANING(status)
CS_EXPORT(status)
CS_INUSE(status)
CS_LABELED(status)
CS_NEEDS_AUDIT(status)
CS_OCCUPIED(status)
CS_RDONLY(status)
CS_RECYCLE(status)
CS_UNAVAIL(status)
CS_WRTPROT(status)

=back

=head1 Interface

=head2 stat

B<Filesys::SamFS::stat($path)> (importable as sam_stat) returns a list, much like
the standard Perl function stat.
The first 13 elements are the same as for stat.
Since blksize and blocks are not returned by the sam_stat function in
the SamFS API, these elements are always returned as B<undef>.
The additional elements are specific to SamFS filesystems.

Example usage:

C<($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
$atime,$mtime,$ctime,undef,undef,
# So far, much like stat()
$attr,$attribute_time,$creation_time,$residence_time,
$cs_algo,$flags,$gen,$partial_size,@copyref)
           = Filesys::SamFS::stat($path);>

C<@copyref> is a list of MAX_ARCHIVE elements, each an array reference.
The arrays referenced contain the elements flags, n_vsns, creation_time
and position.

B<Filesys::SamFS::stat($path)> returns an empty list on error.
$! is set in this case.

B<Note>: SamFS uses 64 bit integers for sizes and positions.
Since perl on Solaris works with only 32 bit integers, we have an
impedance problem here.
The XS solves this problem by returning these elements as strings.
This is sufficient for printing the values.
For I<manipulation>, it is recommended to use B<Math::BigInt>.
In this case, this affects the I<size> element.

B<Filesys::SamFS::lstat($path)> (importable as sam_lstat) has the same
interface as sam_stat, but when given the path of a symbolic link,
will return information about the link rather than the file it points to.
I.e. it has the same relation to B<sam_stat> as B<lstat> has to B<stat>.

Note that these functions also work for a I<path> that does
not lie on a SamFS filesystem.
The elements specific to SamFS are returned as zero in this case,
but blksize and blocks are still returned as B<undef>.
(This is so because the SamFS API function sam_stat()/sam_lstat()
just do not provide these elements.)

B<Filesys::SamFS::vsn_stat($path)> (importable as sam_vsn_stat)
returns a list of MAX_VSNS array references.
Each array referenced contains the elements vsn, length, position and offset.
All of them are strings.

B<Filesys::SamFS::vsn_stat($path)> returns an empty list on error.
$! is set in this case.

B<Filesys::SamFS::attrtoa($attr)> (importable as sam_attrtoa)
translates a numeric attribute word into a symbolic string,
which is returned.

B<Filesys::SamFS::devstat($eq)> (importable as sam_devstat)
and B<Filesys::SamFS::ndevstat($eq)> (importable as sam_ndevstat)
both return a list of values or no values at all in the case
of an error.

($type, $name, $vsn, $state, $status, $space, $capacity) = Filesys::SamFS::ndevstat($eq);

B<Filesys::SamFS::devstr($status)> ((importable as sam_devstr)
can be used to translate the binary status value into a string.
This string is returned.

B<sam_archive($path, $opns)> (importable as sam_archive)
sets archive attributes on the file or directory pointed to by $path.
Please refer to sam_archive(3) for details.

B<sam_cancelstage($path)> (importable as sam_cancelstage)
cancels a staging operation of the file pointed to by $path.
Please refer to sam_cancelstage(3) for details.

B<sam_release($path, $opns)> (importable as sam_release)
sets release attributes on the file or directory pointed to by $path.
Please refer to sam_release(3) for details.

B<sam_ssum($path, $opns)> (importable as sam_ssum)
sets the checksum attributes for the file ppointed to by $path.
Please refer to sam_ssum(3) for details.

B<sam_stage($path, $opns)> (importable as sam_stage)
sets stage attributes on the file or directory pointed to by $path.
Please refer to sam_stage(3) for details.

B<sam_setfa($path, $opns)> (importable as sam_setfa)
sets attributes on the file or directory pointed to by $path.
Please refer to sam_setfa(3) for details.

B<sam_advise($fildes, $opns)> (importable as sam_advise)
requests special I/O modes from SamFS.
$fildes is the numeric filedescriptor of an open file.
(Use fileno(FILEHANDLE) to retrieve the filedescriptor for
a filehandle or $io->fileno when using IO::Handle.)
Please refer to sam_advise(3) for details.

=head1 Unimplemented functions

sam_readrminfo

sam_request

Both of these are not documented in the manpages, and the header
file does not provide enough information.

=head1 AUTHOR

Lupe Christoph <lupe@lupe-christoph.de>

=head1 SEE ALSO

perl(1), the SamFS man pages, e.g. sam_stat(3).

=cut
