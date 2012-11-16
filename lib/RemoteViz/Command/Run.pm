package RemoteViz::Command::Run;

use base qw( CLI::Framework::Command );
use v5.16.1;

#return usage output
sub usage_text{
    my $usage = <<EOF;
Usage:
remoteViz run [app]

example:
remoteViz run glxgears
EOF
}

sub validate{
    my ($self, $cmd_opts, @args) = @_;
    
    if(defined $cmd_opts->{'help'}){
        die $self->usage_text();
    }
    die $self->usage_text() unless defined $args[0];
}

sub option_spec {
    # The option_spec() hook in the Command Class provides the option
    # specification for a particular command.
    [ 'help|h' => 'help' ],
}


sub run{
	my ($self, $opts, @args) = @_;
   
   use VirtualGL;
   my $obj = VirtualGL->new();
   
	$obj->run($args[0]);
   
   return;
}

1;