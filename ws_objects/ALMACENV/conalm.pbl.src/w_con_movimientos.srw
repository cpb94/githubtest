$PBExportHeader$w_con_movimientos.srw
$PBExportComments$Obsoleto
forward
global type w_con_movimientos from w_int_con_empresa
end type
type dw_1 from datawindow within w_con_movimientos
end type
type pb_1 from upb_salir within w_con_movimientos
end type
end forward

global type w_con_movimientos from w_int_con_empresa
integer x = 50
integer y = 160
integer width = 2880
integer height = 2148
dw_1 dw_1
pb_1 pb_1
end type
global w_con_movimientos w_con_movimientos

on open;call w_int_con_empresa::open;dw_1.SetTransObject(sqlca)

	// Recoger los parametros en caso de que nos llame otra ventana

str_parametros	lstr_parametros

lstr_parametros = Message.PowerObjectParm

// Si me llama otro programa, asigno los datos pertinentes.
   IF lstr_parametros.i_nargumentos > 1 THEN
		integer i
		FOR i =1 TO lstr_parametros.i_nargumentos
			istr_parametros.s_argumentos[i] = lstr_parametros.s_argumentos[i]
		NEXT
		This.TriggerEvent("ue_recuperar")
   END IF

end on

on ue_recuperar;call w_int_con_empresa::ue_recuperar;dw_1.Retrieve( codigo_empresa, istr_parametros.s_argumentos[2], &
					Integer(istr_parametros.s_argumentos[3]), &
					Integer(istr_parametros.s_argumentos[4]))
end on

on w_con_movimientos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_1
end on

on w_con_movimientos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_movimientos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_movimientos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_movimientos
end type

type dw_1 from datawindow within w_con_movimientos
integer x = 23
integer y = 200
integer width = 2766
integer height = 1712
boolean bringtotop = true
string dataobject = "dw_con_movimiento"
boolean livescroll = true
end type

type pb_1 from upb_salir within w_con_movimientos
integer x = 2702
integer y = 32
integer width = 137
integer height = 112
integer taborder = 10
string picturename = "exit!"
end type

