#!/usr/bin/perl

use strict;
use warnings;
use Image::Info qw(image_info image_type dim);
use Time::localtime;
use File::stat;

if(scalar @ARGV < 3){
 die "Please pass parameters: [cp/mv] [input-dir] [output-dir] ";
}

my $command = $ARGV[0];
my $in_dir = $ARGV[1];
my $out_dir = $ARGV[2];
print "input directory = [$in_dir] \n";

opendir (DIR, $in_dir) or die $!;

if (-e $out_dir and -d $out_dir) {
        #
}else{
    print "time to create dir $out_dir";
    system "mkdir $out_dir";
}


while(my $file = readdir(DIR)){
  my $type = image_type("$in_dir/$file");
  if (my $error = $type->{error}) {
  }else{
    my $image = "$in_dir/$file";
    my $info = image_info($image);
    my $file_type = $info->{file_media_type};
    my $create_date =  ctime(stat($image)->mtime) ; 
    my @arr = split(' ',$create_date);
    my $month = $arr[1];
    my $year = $arr[4];
    #print "$file type is $file_type date is $year : $month \n";
    my $ydir = "$out_dir/$year";
    if (-e $ydir and -d $ydir) {
    	#
    }else{
        print "time to create year dir $ydir \n";
        system "mkdir $ydir";
    }
    my $mdir = "$ydir/$month";
    if (-e $mdir and -d $mdir) {
        #
    }else{
        print "time to create month dir $mdir \n";
        system "mkdir $mdir";
    }
    
    system "$command $in_dir/$file $mdir/$file";
  } 
}


sub is_vid {

}
