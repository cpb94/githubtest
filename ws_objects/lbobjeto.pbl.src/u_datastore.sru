$PBExportHeader$u_datastore.sru
forward
global type u_datastore from datastore
end type
end forward

global type u_datastore from datastore
end type
global u_datastore u_datastore

on u_datastore.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_datastore.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

