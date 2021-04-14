$PBExportHeader$u_datawindow_consultas.sru
forward
global type u_datawindow_consultas from u_datawindow
end type
end forward

global type u_datawindow_consultas from u_datawindow
event ue_valores pbm_custom04
end type
global u_datawindow_consultas u_datawindow_consultas

type variables

end variables

event ue_valores;call super::ue_valores;// Introducir  ue_marca_linea = False  si no queremos quwe se seleccione
// por defecto.
ue_marca_linea = TRUE
end event

