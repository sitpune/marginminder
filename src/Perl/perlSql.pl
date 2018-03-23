#!/usr/bin/perl
use strict;
use warnings;
use v5.10; # for say() function
use DBI;
 
say "____________MARGIN MINDER____________";
# MySQL database configurations
my $dsn = "DBI:mysql:myDB";
my $username = "technetium";
my $password = 'marginMinder';
# connect to MySQL database
my %attr = (RaiseError=>1,  # error handling enabled 
            AutoCommit=>0); # transaction enabled
my $dbh = DBI->connect($dsn,$username,$password, \%attr);

# create tables
my @ddl =     (
  # create some_table table
      "CREATE TABLE some_table (
      
    ) ENGINE=InnoDB;"
); 
# execute all create table statements        
for my $sql(@ddl){
  $dbh->do($sql);
}        
say "All tables created successfully!";

#do some operations here

# disconnect from the MySQL database
$dbh->disconnect();

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$row_id)  = @_;
    my $sql = "DELETE FROM some_table WHERE row_id = ?";
    my $sth = $dbh->prepare($sql);
    return $sth->execute($row_id);
}
 
sub delete_all_rows {
    # delete all rows in some_table
    # $dbh: database handle
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE clinks";
    my $sth = $dbh->prepare($sql);
    return $sth->execute(); 
}

sub insert_one_row {
  eval {
    # do something risky...
    my($dbh,) = @_;
    my $sql= "INSERT INTO some_table (column heads comma separated) VALUE (some no. of ?s)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute(actual vals here);
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
  my($dbh,$row_id)  = @_;
  my $sql = "UPDATE some_table
           SET col1 = ?,
               col2 = ?, 
               col3 = ?
    WHERE row_id = ?";
  my $sth = $dbh->prepare($sql);
  # bind the corresponding parameter
  $sth->bind_param(1,$col1Val);
  $sth->bind_param(2,$col2Val);
  $sth->bind_param(3,$col3Val);
  $sth->bind_param(4,$row_id);
  # execute the query
  $sth->execute();
  say "Updated row successfully!";
  $sth->finish();
}
