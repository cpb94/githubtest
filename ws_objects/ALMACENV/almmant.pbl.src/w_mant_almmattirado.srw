$PBExportHeader$w_mant_almmattirado.srw
forward
global type w_mant_almmattirado from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within w_mant_almmattirado
end type
type r_1 from rectangle within w_mant_almmattirado
end type
type r_2 from rectangle within w_mant_almmattirado
end type
end forward

global type w_mant_almmattirado from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2016
integer height = 884
pb_calculadora pb_calculadora
r_1 r_1
r_2 r_2
end type
global w_mant_almmattirado w_mant_almmattirado

event open;call super::open;istr_parametros.s_titulo_ventana = "Introducción de material tirado"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	 IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        		dw_1.Retrieve(codigo_empresa,sle_valor.text)
     END IF
END IF
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"fecha",today())

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "almmattirado"

 dw_1.Retrieve(codigo_empresa, sle_valor.Text)
 CALL Super::ue_recuperar






end event

on w_mant_almmattirado.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.r_1=create r_1
this.r_2=create r_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.r_1
this.Control[iCurrent+3]=this.r_2
end on

on w_mant_almmattirado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.r_1)
destroy(this.r_2)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within w_mant_almmattirado
integer x = 55
integer y = 236
integer width = 1851
integer height = 416
integer taborder = 20
string dataobject = "dw_mant_almmattirado"
borderstyle borderstyle = stylelowered!
end type

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_almmattirado"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_articulo'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulo")
   OpenWithParm(w_mant_articulos_tencer,lstr_param)
CASE 'pb_motivo'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"motivo")
   OpenWithParm(w_mant_motivotirar,lstr_param)
END CHOOSE




end event

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulo"
	bus_titulo     = "AYUDA SELECCION DE ARTICULOS"
	bus_datawindow = "dw_ayuda_articulos"
	bus_filtro     = "" 
CASE "motivo"
	valor_empresa = true
	bus_titulo     = "AYUDA SELECCION DE MOTIVOS"
	bus_datawindow = "dw_ayuda_motivostirar"
	bus_filtro     = "" 
	
END CHOOSE
CALL Super::Key
end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulo"
	bus_titulo     = "AYUDA SELECCION DE ARTICULOS"
	bus_datawindow = "dw_ayuda_articulos"
	bus_filtro     = "" 
CASE "motivo"
	valor_empresa = true
	bus_titulo     = "AYUDA SELECCION DE MOTIVOS"
	bus_datawindow = "dw_ayuda_motivostirar"
	bus_filtro     = "" 
	
END CHOOSE
CALL Super::rbuttondown

end event

type st_1 from wi_mant_ventanas`st_1 within w_mant_almmattirado
integer x = 101
integer y = 100
integer width = 261
fontcharset fontcharset = ansi!
long backcolor = 16777215
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within w_mant_almmattirado
integer x = 855
integer y = 92
integer width = 343
integer taborder = 30
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within w_mant_almmattirado
integer x = 1207
integer y = 92
integer width = 343
integer taborder = 40
end type

type sle_valor from wi_mant_ventanas`sle_valor within w_mant_almmattirado
integer x = 375
integer y = 96
fontcharset fontcharset = ansi!
long backcolor = 16777215
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA "
ue_datawindow     = ""
ue_filtro         =  ""
valor_empresa     = true
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within w_mant_almmattirado
integer x = 1559
integer y = 92
integer width = 343
integer taborder = 50
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within w_mant_almmattirado
integer taborder = 0
end type

type pb_calculadora from u_calculadora within w_mant_almmattirado
integer x = 635
integer y = 92
integer width = 105
integer height = 92
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros

Select count(*) Into :registros 
From almmattirado
where empresa = :codigo_empresa;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :sle_valor.text
   From   almmattirado
	where empresa = :codigo_empresa;
END IF
dw_1.TriggerEvent("Clicked")
end event

type r_1 from rectangle within w_mant_almmattirado
integer linethickness = 4
long fillcolor = 8388608
integer x = 846
integer y = 84
integer width = 1065
integer height = 108
end type

type r_2 from rectangle within w_mant_almmattirado
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 16777215
integer x = 91
integer y = 84
integer width = 667
integer height = 108
end type

