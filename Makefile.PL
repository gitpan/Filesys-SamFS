use ExtUtils::MakeMaker;

# Gather some variables for tests.
$| = 1;

eval { require 't/vars.pl'; };

print <<'EOF';
We need some information about your installation of SamFS to be able
to run the tests. Please answer a few questions.

We would like to know where the SamFS include files and
libraries are located.

We will need a directory in a SamFS filesystem where we can create
files and symlinks for the stat() and lstat() tests.

Then we need the equipment ordinal of a tape drive or MO drive
to test the ndevstat() call. Note that this call can only be
executed by the superuser. Refer to the README for instructions.

Finally, we need the location of a catalog file to test the
catalog calls.

All tests we run are non-destructive. The only changes we make are
the files and symlinks that will be created in the directory
you specify. Anything else happens either here or in your perl
installation when you do the 'make install'.

EOF

$SamFS_dir = '/opt/SUNWsamfs';

do {{
  print "Where is SamFS located [$SamFS_dir]: ";
  $answer = <STDIN>;
  chomp $answer;
  $answer = $SamFS_dir unless length($answer);
  unless (-d $answer) {
    print "Sorry, but $answer is not a directory. Please try again.\n";
    next;
  }
  unless (-d "$answer/include") {
    print "Sorry, but $answer/include does not exist. Please try again.\n";
    next;
  }
  unless (-d "$answer/lib") {
    print "Sorry, but $answer/lib does not exist. Please try again.\n";
    next;
  }
}} until (-d $answer && -d "$answer/include" && -d "$answer/lib");
$SamFS_dir = $answer;

print "\n";

do {{
  print "A directory in a SamFS filesystem writable by this user [$dir]: ";
  $answer = <STDIN>;
  chomp $answer;
  $answer = $dir unless length($answer);
  unless (length($answer)) {
    print "Sorry, but you have to provide an answer. There is no default.\n";
    next;
  }
  unless (-d $answer) {
    print "Sorry, but $answer is not a directory. Please try again.\n";
    next;
  }
  unless (-w _) {
    print "Sorry, but $answer is not writeable by you. Please try again.\n";
    next;
  }
}} until (-d _ && -w _);
$dir = $answer;

print "\n";

do {{
  print "The equipment ordinal of a tape drive or MO drive [$eq]: ";
  $answer = <STDIN>;
  chomp $answer;
  $answer = $eq unless length($answer);
  unless (length($answer)) {
    print "Sorry, but you have to provide an answer. There is no default.\n";
    next;
  }
  unless ($answer =~ /^\d+$/) {
    print "Sorry, but the answer must be numeric. Please try again.\n";
    next;
  }
}} until ($answer =~ /^\d+$/);
print "\n";
$eq = $answer;

$catalog = '/etc/fs/samfs/sam_historian' unless defined $catalog;
do {{
  print "The location of a catalog file [$catalog]: ";
  $answer = <STDIN>;
  chomp $answer;
  $answer = $catalog unless length($answer);
  unless (-e $answer) {
    print "Sorry, but $answer does not exist. Please try again.\n";
    next;
  }
  unless (-f _) {
    print "Sorry, but $answer is not a file. Please try again.\n";
    next;
  }
  unless (-r _) {
    print "Sorry, but $answer is not readable by you. Please try again.\n";
    next;
  }
}} until (-e _ && -f _) && -r _;
$catalog = $answer;

open (VARS, '>t/vars.pl') || die "Can't open t/vars.pl for writing: $!\n";
print VARS <<"EOF";
\$dir = '$dir';
\$eq = $eq;
\$catalog = '$catalog';
EOF
close(VARS);

print <<"EOF";

We will now create a file '$dir/archived'.
Please make sure that this file has been archived before running
any test. This file is used to test the stat() system call.
EOF

open(ARCHIVED, ">$dir/archived") ||
  die "Cannot open $dir/archived for writing: $!\n";
seek(DATA, 0, 0);
print ARCHIVED <DATA>;
close(ARCHIVED);

# Early versions of SamFS omitted the definition of sam_devstr from
# lib.h. Find out if it is defined in *this* version. We do this
# dynamically to avoid pinpointing the version that introduced teh
# definition.

WriteMakefile(
	      'NAME'	     => 'Filesys::SamFS',
	      'VERSION_FROM' => 'SamFS.pm',
              'DEFINE'       => "@ARGV",
	      'LIBS'	     => ["-R$SamFS_dir/lib -L$SamFS_dir/lib -lsam"],
	      'INC'	     => "-I$SamFS_dir/include",
	      'PM'           => {'SamFS.pm' => '$(INST_LIBDIR)/SamFS.pm'},
	      'MAN3PODS'     => {'SamFS.pm' => '$(INST_MAN3DIR)/Filesys::SamFS.$(MAN3EXT)'},
	      'realclean'    => {FILES => 't/vars.pl'}
);

sub MY::postamble {
  return <<'EOF';
.SUFFIXES: .pod .html
.pod:
	$(FULLPERL) -MPod::Text -e "pod2text('$<')" > $@
.pod.html:
	$(FULLPERL) -MPod::Html -e "pod2html('--noindex', '--outfile', '$@', '$<')"

docfiles: README README.html Changes Changes.html
EOF
}

__DATA__
We need this for the cute "copy this file to $dir/archived".
