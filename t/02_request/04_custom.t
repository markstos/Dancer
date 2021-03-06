use Test::More tests => 7;

use strict;
use warnings FATAL => 'all';

use Dancer::Request;

%ENV = (
          'REQUEST_METHOD' => 'GET',
          'REQUEST_URI' => '/',
          'PATH_INFO' => '/',
          'QUERY_STRING' => 'foo=bar&number=42',
          );

my $req = Dancer::Request->new;
is $req->path, '/', 'path is /';
is $req->method, 'GET', 'method is post';
is_deeply scalar($req->params), {foo => 'bar', number => 42}, 
    'params are parsed';

$req = Dancer::Request->new_for_request('GET', '/stuff');
is $req->path, '/stuff', 'path is changed';
is $req->method, 'GET', 'method is changed';
is_deeply scalar($req->params), {foo => 'bar', number => 42}, 
    'params are not touched';

$req = Dancer::Request->new_for_request('GET', '/stuff', {user => 'sukria'});
is_deeply scalar($req->params), {foo => 'bar', number => 42, user => 'sukria'}, 
    'params are updated';

