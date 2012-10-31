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
   
   return;
}

1;