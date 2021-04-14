$PBExportHeader$u_pipe.sru
forward
global type u_pipe from pipeline
end type
end forward

global type u_pipe from pipeline
end type
global u_pipe u_pipe

on u_pipe.create
call pipeline::create
TriggerEvent( this, "constructor" )
end on

on u_pipe.destroy
call pipeline::destroy
TriggerEvent( this, "destructor" )
end on

