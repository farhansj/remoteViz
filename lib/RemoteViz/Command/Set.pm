package RemoteViz::Command::Set;

use base qw( CLI::Framework::Command );
use v5.16.1;

my $supported_args = "password";

#return usage output
sub usage_text{
    my $usage = <<EOF;
Usage:
remoteViz set [--cmd-opt] [cmd-arg]

available cmd-arg:
password      
            
example:
#set vnc password
remoteViz set $supported_args

EOF
}

sub validate{
    my ($self, $cmd_opts, @args) = @_;
    
    if(defined $cmd_opts->{'help'}){
        die $self->usage_text();
    }
    
    unless(defined $args[0]){
   		die $self->usage_text();
    } 
}

sub option_spec {
    # The option_spec() hook in the Command Class provides the option
    # specification for a particular command.
    [ 'help|h' => 'help' ],
}


sub run{
	my ($self, $opts, @args) = @_;
   
   use TurboVNC;
   my $obj = TurboVNC->new();
   
   if($args[0] =~ /\bpassword\b/i){
   		$obj->set_passwd();
   }else{
   		say "$args[0] not supported on set command";
   		say "try set $supported_args";
   		exit 255;
   }
   
   return;
}

1;