use utf8;

#------------------------------------------------------------------------
# Compiled template generated by the Template Toolkit version 2.27
#------------------------------------------------------------------------

Template::Document->new({
    METADATA => {
        'modtime' => '1543816005',
        'name' => 'templates/header.tt',
    },
    BLOCK => sub {
    my $context = shift || die "template sub called without context\n";
    my $stash   = $context->stash;
    my $output  = '';
    my $_tt_error;
    
    eval { BLOCK: {
$output .=  "<header>\n  Pasty\n  <a \@click=\"onSave\">Save</a>\n  <a \@click=\"onCreate\">New</a>\n  <a \@click=\"onDupandEdit\">Duplicate & Edit</a>\n  <a \@click=\"getTextOnly\">Just Text</a>\n</header>";
    } };
    if ($@) {
        $_tt_error = $context->catch($@, \$output);
        die $_tt_error unless $_tt_error->type eq 'return';
    }

    return $output;
},
    DEFBLOCKS => {

    },
});
