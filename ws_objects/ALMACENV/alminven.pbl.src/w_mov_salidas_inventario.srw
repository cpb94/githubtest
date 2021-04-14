$PBExportHeader$w_mov_salidas_inventario.srw
forward
global type w_mov_salidas_inventario from w_int_con_empresa
end type
type pb_1 from upb_salir within w_mov_salidas_inventario
end type
type dw_detalle from datawindow within w_mov_salidas_inventario
end type
end forward

global type w_mov_salidas_inventario from w_int_con_empresa
integer width = 2889
integer height = 1552
pb_1 pb_1
dw_detalle dw_detalle
end type
global w_mov_salidas_inventario w_mov_salidas_inventario

type variables
DateTime var_fecha

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Movimientos incluidos para salidas inventario"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_detalle.Retrieve(codigo_empresa)



end event

on w_mov_salidas_inventario.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_detalle
end on

on w_mov_salidas_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mov_salidas_inventario
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mov_salidas_inventario
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mov_salidas_inventario
integer x = 27
integer y = 8
integer width = 2414
end type

type pb_1 from upb_salir within w_mov_salidas_inventario
integer x = 2711
integer y = 8
integer width = 123
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type dw_detalle from datawindow within w_mov_salidas_inventario
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 101
integer y = 160
integer width = 2510
integer height = 1188
string dataobject = "dw_mov_salidas_inventario"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return

String cod_mov
Integer numero


cod_mov =  f_valor_columna(This,row,"tipomov")


Select Count(*) Into :numero From almmovsalinv
Where  almmovsalinv.empresa = :codigo_empresa
And    almmovsalinv.tipomov = :cod_mov;
If IsNull(numero) Then numero = 0
IF numero = 0 Then
   INSERT INTO almmovsalinv
         ( empresa,   
           tipomov)  
  VALUES ( :codigo_empresa,   
           :cod_mov )  ;

Else
  DELETE FROM almmovsalinv
   WHERE ( almmovsalinv.empresa = :codigo_empresa ) AND  
         ( almmovsalinv.tipomov = :cod_mov )   ;

END IF
COMMIT;
Retrieve(codigo_empresa)
end event

