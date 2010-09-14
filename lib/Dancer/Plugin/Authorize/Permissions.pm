# ABSTRACT: Dancer::Plugin::Authorize Permissions base class and guide!

package Dancer::Plugin::Authorize::Permissions;
BEGIN {
  $Dancer::Plugin::Authorize::Permissions::VERSION = '0.01';
}

use strict;
use warnings;

use Dancer qw/:syntax/;


sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

sub credentials {
    my $self = shift;
    if (@_) {
        return session 'user' => @_;
    }
    else {
        return session('user');
    }
}

sub permissions {
    my $self = shift;
    if (@_) {
        return session 'roles' => @_;
    }
    else {
        return session('roles');
    }
}

sub errors {
    my ($self, @errors) = @_;
    my $user = session('user');
    push @{$user->{error}}, @errors; 
    return session 'user' => $user;
}

1;
__END__
=pod

=head1 NAME

Dancer::Plugin::Authorize::Permissions - Dancer::Plugin::Authorize Permissions base class and guide!

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    package Dancer::Plugin::Authorize::Permissions::MyPermissionsClass;
    use base 'Dancer::Plugin::Authorize::Permissions';
    
    sub subject_asa {
        my ($self, $options, @arguments) = @_;
        my $role = shift @arguments;
        my $settings = $class::settings;
        
        # Note! for permissions classes interacting with a database, storing all
        # roles and actions with the user session will boost application
        # performance and prevent polling repetitive information, e.g.
        # $self->permissions($all_roles);
        
        if ($role) {
            my $user = $self->credentials;
            if (grep $role, @{$user->{roles}} ) {
                return 1;
            }
        }
        
    }
    
    1;

=head1 DESCRIPTION

The Dancer::Plugin::Authorize::Permissions class should be used as a base class in
your custom role-based acess control/permissions classes. When used as a base class, this
class provides instantiation and simple error handling for your classes. 

=head1 AUTHOR

Al Newkirk <awncorp@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by awncorp.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

