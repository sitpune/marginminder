package mmind::received_texts;
use base 'mmind::DBI';

mmind::received_texts->table('received_texts');

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$text_id)  = @_;
    my $sql = "DELETE FROM `received_texts` WHERE `received_texts`.`text_id` = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($text_id);
    $dbh->commit();
    say "Deleted row successfully!";
}
 
sub delete_all_rows {
    # delete all rows in some_table
    # $dbh: database handle
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE received_texts";
    my $sth = $dbh->prepare($sql);
    $sth->execute(); 
    $dbh->commit();
    say "Deleted all rows successfully!";
}

sub insert_one_row {
  eval {
    # do something risky...
    my($dbh,$text_id,$phone.$text) = @_;
    my $sql= "INSERT INTO received_texts (text_id,phone,text) VALUE (?,?,?)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute($text_id,$phone,$text);
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
  my($dbh,$text_id,$phone,$text)  = @_;
  my $sql = "UPDATE received_texts
           SET phone = ?, 
               text = ?
    WHERE text_id = ?";
  my $sth = $dbh->prepare($sql);
  # execute the query
  $sth->execute($text_id,$phone,$text);
  say "Updated row successfully!";
  $sth->finish();
  $dbh->commit();
  say "Updated row successfully!";
}
