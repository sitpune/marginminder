package MMind::DBI;
use base 'Class::DBI';

MMind::DBI->connection('DBI::mysql:margin_minder', 'root', '#yourPasswordHere');

