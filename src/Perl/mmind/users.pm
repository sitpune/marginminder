package mmind::users;
use base 'mmind::DBI';

mmind::users->table('users');

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$uid)  = @_;
    my $sql = "DELETE FROM `users` WHERE `users`.`uid` = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($uid);
    $dbh->commit();
    say "Deleted row successfully!";
}
 
sub delete_all_rows {
    # delete all rows in some_table
    # $dbh: database handle
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE users";
    my $sth = $dbh->prepare($sql);
    $sth->execute(); 
    $dbh->commit();
    say "Deleted all rows successfully!";
}

sub insert_one_row {
  eval {
    # do something risky...
    my($dbh,$uid,$password,$email,$phone,$role_id) = @_;
    my $sql= "INSERT INTO users (uid,email,phone,password,role_id) VALUE (?,?,?,?,?)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute($uid,$email,$phone,$password,$role_id);
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
  my($dbh,$uid,$password,$email,$phone,$role_id)  = @_;
  my $sql = "UPDATE users
           SET email = ?, 
               phone = ?,
		password = ?,
		role_id = ?
    WHERE uid = ?";
  my $sth = $dbh->prepare($sql);
  # execute the query
  $sth->execute($email,$phone,$password,$role_id,$uid);
  say "Updated row successfully!";
  $sth->finish();
  $dbh->commit();
  say "Updated row successfully!";
}
