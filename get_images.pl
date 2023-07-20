use strict;
use warnings;
use HTTP::Tiny;
use File::Basename;
use File::Path qw(make_path);

my $output_dir = "./images/";
if(!-d $output_dir){
    make_path($output_dir) or die "cant make directory";
}

my @urls = (
    'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/marnie/marnie_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/kaguyahime/kaguyahime_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/kazetachinu/kazetachinu_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/kokurikozaka/kokurikozaka_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/karigurashi/karigurashi_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/ponyo/ponyo_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/ged/ged_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/chihiro/chihiro_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/howl/howl_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/baron/baron_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/ghiblies/ghiblies_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/yamada/yamada_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/mononoke/mononoke_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/mimi/mimi_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/red-turtle/red-turtle_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/onyourmark/onyourmark_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/omoide/omoide_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/laputa/laputa_images.md',
 'https://raw.githubusercontent.com/rosiro/studio_ghibli_movie_images/main/nausicaa/nausicaa_images.md'
);

for my $url (@urls){
  print "get ".$url."\n";
  my $res = HTTP::Tiny->new->get($url);
  if ( $res->{success} ) {
    my @htmlcontent = split(/\n/,$res->{content});
    for my $htmlline (@htmlcontent){
      if($htmlline =~ /(https?:.*jpg)/){
        my $image_url = $1;
        my $filename = fileparse($image_url);
        print "image = ".$image_url." file = ".$filename."\n";
        my $res_image = HTTP::Tiny->new->get( $image_url );
	sleep(1);
	if($res_image->{success}){
	    open my $image_file, '>', $output_dir.$filename or die "cant open file $!";
	    binmode $image_file;
	    print $image_file $res_image->{content};
	    close $image_file;
	}
	else{
	    print $image_url . " fail";
	}
      }
    }
  }
  else{
      print $res->{status};
  }
}
