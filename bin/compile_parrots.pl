#!/usr/bin/env perl

use strict;
use warnings;
use File::Spec::Functions;
use Data::Dumper;
use Cwd;
use 5.010;

$|++;
my $cwd      = cwd;
my $src_dir  = catdir($ENV{HOME}, qw/src parrot/);
die 'Cannot access source dir $src_dir !' unless -d $src_dir;

my @parrot_dirs = grep { -d $_ } glob catdir($src_dir,'parrot*');
#warn Dumper [ @parrot_dirs ];

for my $parrot_dir (@parrot_dirs) {
    say "Compiling $parrot_dir";
    chdir $parrot_dir;
    trace_cmd("make realclean",0); # maybe make this a cmd line flag?
    trace_cmd("$^X Configure.pl --optimize --prefix=$parrot_dir/installed_parrot",1);
    trace_cmd("make -j2",1);
    trace_cmd("make install",1);
}

sub trace_cmd {
    my ($cmd,$handle_errors) = @_;
    say $cmd;
    system "$cmd &>/dev/null";
    handle_errors($?) if $handle_errors && $?;
}

sub handle_errors {
    my ($exit_code) = @_;
    if ($exit_code == -1) {
        print "Error: failed to execute: $!\n";
    } elsif ($exit_code & 127) {
        printf "Error: child died with signal %d, %s coredump\n",
            ($exit_code & 127),  ($exit_code & 128) ? 'with' : 'without';
    } else {
        printf "Error: child exited with value %d\n", $? >> 8;
    }
}
