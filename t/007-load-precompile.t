use v6.c;

use Test;
use nqp;
use CompUnit::PrecompilationRepository::Document;
use File::Directory::Tree;

plan 1;

my $precomp-store = CompUnit::PrecompilationStore::File.new(prefix => "cache".IO );
my $precomp = CompUnit::PrecompilationRepository::Document.new(store => $precomp-store);

constant doc-name = "simple";
my $key = nqp::sha1(doc-name);
$precomp.precompile(("t/doctest/" ~ doc-name ~ ".pod6").IO, $key, :force );
my $handle = $precomp.load($key)[0];
my $precompiled-pod = nqp::atkey($handle.unit,'$=pod')[0];

#--MARKER-- Test 1
is-deeply $precompiled-pod, $=pod[0], "Load precompiled pod"; 

rmtree("cache"); 

=begin pod

=TITLE powerfull cache

Perl6 is quite awesome.

=end pod