package mmind::received_emails;
use base 'mmind::DBI';

mmind::received_emails->table('received_emails');

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$email_ id)  = @_;
    my $sql = "DELETE FROM `received_emails`
    WHERE `received_emails`.`email_id` = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($email_id);
    $dbh->commit();
    say "Deleted row successfully!";
}
 
sub delete_all_rows {
    # delete all rows in some_table
    # $dbh: database handle
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE received_emails";
    my $sth = $dbh->prepare($sql);
    $sth->execute(); 
    $dbh->commit();
    say "Deleted all rows successfully!";
}

sub insert_one_row {
  eval {
    # do something risky...
    my($dbh,$email_id,$email,$body) = @_;
    my $sql= "INSERT INTO received_emails 
    (email_id,email,body) VALUE (?,?,?)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute($email_id,$email,$body);
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
  my($dbh,$email_id,$email,$body)  = @_;
  my $sql = "UPDATE received_emails
           SET email = ?, 
               body = ?
    WHERE email_id = ?";
  my $sth = $dbh->prepare($sql);
  # execute the query
  $sth->execute($dbh,$email_id,$email,$body);
  say "Updated row successfully!";
  $sth->finish();
  $dbh->commit();
  say "Updated row successfully!";
}
