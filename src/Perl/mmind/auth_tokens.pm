package mmind::auth_tokens;
use base 'mmind::DBI';

mmind::auth_tokens->table('auth_tokens');

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$uid)  = @_;
    my $sql = "DELETE FROM `auth_tokens` WHERE `auth_tokens`.`uid` = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($uid);
    $dbh->commit();
    say "Deleted row successfully!";
}
 
sub delete_all_rows {
    # delete all rows in some_table
    # $dbh: database handle
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE auth_tokens";
    my $sth = $dbh->prepare($sql);
    $sth->execute(); 
    $dbh->commit();
    say "Deleted all rows successfully!";
}

sub insert_one_row {
  eval {
    # do something risky...
    my($dbh,$uid,$token) = @_;
    my $sql= "INSERT INTO auth_tokens (uid,token) VALUE (?,?)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute($uid,$token);
    # if everything is OK, commit to the database
    $dbh->commit();
    say "Inserted row successfully!";
  };
  if ($@) {
    # handle failure...
    say "Error inserting row";
    $dbh->rollback();
  }
}

sub update_one_row {
  my($dbh,$uid,$token)  = @_;
  my $sql = "UPDATE auth_tokens
           SET token = ?
    WHERE uid = ?";
  my $sth = $dbh->prepare($sql);
  # execute the query
  $sth->execute($token,$uid);
  say "Updated row successfully!";
  $sth->finish();
  $dbh->commit();
  say "Updated row successfully!";
}
