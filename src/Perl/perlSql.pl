#!/usr/bin/perl
use strict;
use warnings;
use v5.10; # for say() function
use DBI;
 
say "____________MARGIN MINDER____________";
# MySQL database configurations
my $dsn = "DBI:mysql:myDB";
my $username = "root";
my $password = '';
# connect to MySQL database
my %attr = (RaiseError=>1,  # error handling enabled 
            AutoCommit=>0); # transaction enabled
my $dbh = DBI->connect($dsn,$username,$password, \%attr);

#do some operations here
#insert_one_row($dbh, "someXYZ", "password", 1);
#delete_all_rows($dbh);
#delete_one_row($dbh,"someXYZ");
#update_one_row($dbh, "usern", "NEW", 1);

# disconnect from the MySQL database
$dbh->disconnect();

#------------SUBROUTINES
sub delete_one_row {
    # delete one row from some_table
    # $dbh: database handle
    # $row_id: id of the row to delete
    my($dbh,$uname)  = @_;
    my $sql = "DELETE FROM `users` WHERE `users`.`uname` = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($uname);
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
    my($dbh,$uname,$pwd,$isAdmin) = @_;
    my $sql= "INSERT INTO users (uname,pwd,isAdmin) VALUE (?,?,?)";
    my $sth= $dbh -> prepare($sql);
    $sth -> execute($uname,$pwd,$isAdmin);
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
  my($dbh,$uname,$pwd,$isAdmin)  = @_;
  my $sql = "UPDATE users
           SET pwd = ?, 
               isAdmin = ?
    WHERE uname = ?";
  my $sth = $dbh->prepare($sql);
  # bind the corresponding parameter
  $sth->bind_param(1,$pwd);
  $sth->bind_param(2,$isAdmin);
  $sth->bind_param(3,$uname);
  # execute the query
  $sth->execute();
  say "Updated row successfully!";
  $sth->finish();
  $dbh->commit();
  say "Updated row successfully!";
}
