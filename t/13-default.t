use strict;
use warnings;
use Test::More;

{
    package ClassBase;

    use Moose;
    use MooseX::ClassAttribute;

    class_has 'attributes' => (
        is => 'ro',
        lazy => 1,
        default => sub {
          my $class = shift;
          my @atts = $class->meta->get_all_attributes;
          return [ sort map { $_->name } @atts ];
        },
    );

    has att1 => (is => 'ro');
    has att2 => (is => 'ro');
}

{
    package ClassChild;
    use Moose;

    extends 'ClassBase';

    has att3 => (is => 'ro');
}

is_deeply(ClassBase->attributes, [ 'att1', 'att2' ]);
is_deeply(ClassChild->attributes, [ 'att1', 'att2', 'att3' ]);

{
    package ClassBase2;

    use Moose;
    use MooseX::ClassAttribute;

    class_has 'attributes' => (
        is => 'ro',
        lazy => 1,
        default => sub {
          my $class = shift;
          my @atts = $class->meta->get_all_attributes;
          return [ sort map { $_->name } @atts ];
        },
    );

    has att1 => (is => 'ro');
    has att2 => (is => 'ro');
}

{
    package ClassChild2;
    use Moose;

    extends 'ClassBase2';

    has att3 => (is => 'ro');
}

is_deeply(ClassChild2->attributes, [ 'att1', 'att2', 'att3' ]);
is_deeply(ClassBase2->attributes, [ 'att1', 'att2' ]);

done_testing();
