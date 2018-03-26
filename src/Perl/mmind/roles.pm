package mmind::roles;
use base 'mmind::DBI';

mmind::roles->table('roles');

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$role_id)  = @_;
    my $sql = "DELETE FROM `roles` WHERE `roles`.`role_id` = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($role_id);
    $dbh->commit();
    say "Deleted row successfully!";
}
 
sub delete_all_rows {
    # delete all rows in some_table
    # $dbh: database handle
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE roles";
    my $sth = $dbh->prepare($sql);
    $sth->execute(); 
    $dbh->commit();
    say "Deleted all rows successfully!";
}

sub insert_one_row {
  eval {
    # do something risky...
    my($dbh,$role_id,$name) = @_;
    my $sql= "INSERT INTO roles (role_id,name) VALUE (?,?)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute($role_id,$name);
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
  my($dbh,$role_id,$name)  = @_;
  my $sql = "UPDATE roles
           SET name = ?
    WHERE role_id = ?";
  my $sth = $dbh->prepare($sql);
  # execute the query
  $sth->execute($role_id,$name);
  say "Updated row successfully!";
  $sth->finish();
  $dbh->commit();
  say "Updated row successfully!";
}
