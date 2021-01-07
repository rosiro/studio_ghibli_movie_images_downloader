use strict;
use warnings;
use LWP::Simple;
use File::Basename;

my @urls = (
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/marnie/marnie_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/kaguyahime/kaguyahime_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/kazetachinu/kazetachinu_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/kokurikozaka/kokurikozaka_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/karigurashi/karigurashi_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/ponyo/ponyo_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/ged/ged_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/chihiro/chihiro_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/howl/howl_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/baron/baron_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/ghiblies/ghiblies_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/yamada/yamada_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/mononoke/mononoke_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/mimi/mimi_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/red-turtle/red-turtle_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/onyourmark/onyourmark_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/omoide/omoide_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/laputa/laputa_images.md',
 'https://raw.githubusercontent.com/rosiro/ghibli_movie_images/main/nausicaa/nausicaa_images.md'
);

for my $url (@urls){
  print "get ".$url."\n";
  my $lwp = LWP::UserAgent->new();
  my $res = $lwp->get( $url);
  if ( $res->is_success ) {
    my @images = split(/\n/,$res->content);
    for my $image (@images){
      if($image =~ /https?(.+)\/(.+?\.jpg)$/){
        my $image_url = $1.$2;
        my $filename = $2;
        print "image ".$image." file ".$filename."\n";
        my $lwp_image = LWP::UserAgent->new();
        my $res_image = $lwp_image->get( $image, ':content_file' => './'.$filename );
      }
    }
  }
}
