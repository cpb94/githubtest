$PBExportHeader$w_familias_exclu_incre_promocion.srw
forward
global type w_familias_exclu_incre_promocion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_familias_exclu_incre_promocion
end type
type dw_detalle from datawindow within w_familias_exclu_incre_promocion
end type
end forward

global type w_familias_exclu_incre_promocion from w_int_con_empresa
integer width = 2889
integer height = 1600
pb_1 pb_1
dw_detalle dw_detalle
end type
global w_familias_exclu_incre_promocion w_familias_exclu_incre_promocion

type variables
DateTime var_fecha

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Familias excluidas incremento % promocion"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_detalle.Retrieve(codigo_empresa)



end event

on w_familias_exclu_incre_promocion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_detalle
end on

on w_familias_exclu_incre_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_detalle)
end on

event activate;call super::activate;w_familias_exclu_incre_promocion = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_familias_exclu_incre_promocion
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_familias_exclu_incre_promocion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_familias_exclu_incre_promocion
integer x = 27
integer y = 8
integer width = 2665
end type

type pb_1 from upb_salir within w_familias_exclu_incre_promocion
integer x = 2706
integer y = 4
integer width = 123
integer height = 108
integer taborder = 0
end type

type dw_detalle from datawindow within w_familias_exclu_incre_promocion
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer x = 439
integer y = 144
integer width = 1806
integer height = 1188
string dataobject = "dw_con_familias_excluidas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return

String cod_mov
Integer numero


cod_mov =  f_valor_columna(This,row,"codigo")


Select Count(*) Into :numero From profam
Where  profam.empresa = :codigo_empresa
And    profam.familia  = :cod_mov;
If IsNull(numero) Then numero = 0
IF numero = 0 Then
   INSERT INTO profam
         ( empresa,   
           familia)  
  VALUES ( :codigo_empresa,   
           :cod_mov )  ;

Else
  DELETE FROM profam
   WHERE ( profam.empresa = :codigo_empresa ) AND  
         ( profam.familia = :cod_mov )   ;

END IF
COMMIT;
Retrieve(codigo_empresa)
end event

