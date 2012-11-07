package RemoteViz::Command::Request;

use base qw( CLI::Framework::Command );
use v5.16.1;

sub usage_text{
    my $usage = <<EOF;
Usage:
remoteViz req [--cmd-opt]

available cmd-opt:
-g		=> 'set geometry / resolution'
-d		=> 'set description'       
            
example:
#request a session with 1024x768 geometry
remoteViz req -g 1024x768 -d "testing"

EOF
}

sub validate{
    my ($self, $cmd_opts, @args) = @_;
    
    if(defined $cmd_opts->{'help'}){
        die $self->usage_text();
    }
}

sub option_spec {
    # The option_spec() hook in the Command Class provides the option
    # specification for a particular command.
    [ 'g=s'    => 'set geometry' ],
    [ 'd=s'   => 'set description' ],
    [ 'help|h' => 'help' ],
}


sub run{
	my ($self, $opts, @args) = @_;
   
   my $opt;
   
   if($opts->{'g'}){
   		$opt = 1;	
   }
   if($opts->{'d'}){
   		$opt = 2;	
   }
   if(($opts->{'d'}) and $opts->{'g'}){
   		$opt = 3;	
   }
   
   use TurboVNC;
   
   my $obj = TurboVNC->new();
   
   given($opt){
   		when(3){
   			$obj->set_vncserver($opts->{'g'},$opts->{'d'});
   		}
   		when(2){
   			$obj->set_vncserver(undef,$opts->{'d'});
   		}
   		when(1){
   			$obj->set_vncserver($opts->{'g'},undef);
   		}
   		default {
   			$obj->set_vncserver();
   		}
   }
   
   return;
}

1;