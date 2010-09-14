package Test;

use lib '../../lib';
use Dancer ':syntax';
use Dancer::Plugin::Authorize;
use Data::Dumper qw/Dumper/;

our $VERSION = '0.1';

get '/' => sub {
    
    my $auth = auth();
    my $errs = auth_err();
    
    return Dumper { auth => $auth, errs => $errs };
    
};

get '/login' => sub {
    
    my $auth = auth('this', 'that');
    my $errs = auth_err();
    
    return Dumper { auth => $auth, errs => $errs };
    
};

get '/login/:user' => sub {
    
    my $auth = auth(params->{user}, 'foobar');
    my $errs = auth_err();
    
    return Dumper { auth => $auth, errs => $errs };
    
};

get '/perm' => sub {
    
    my $asa = auth_asa('admin');
    my $can = auth_can('manage accounts', 'delete');
    
    return Dumper { asa => $asa, can => $can };
    
};

get '/perm/:perm' => sub {
    
    my $asa = auth_asa('guest');
    my $can = auth_can('manage accounts', params->{perm});
    
    return Dumper { asa => $asa, can => $can };
    
};

true;
