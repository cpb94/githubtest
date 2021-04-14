$PBExportHeader$wi_mant_vencuentasegunfam.srw
forward
global type wi_mant_vencuentasegunfam from wi_mvent_con_empresa
end type
type st_nombre_familia from statictext within wi_mant_vencuentasegunfam
end type
end forward

global type wi_mant_vencuentasegunfam from wi_mvent_con_empresa
integer width = 2331
integer height = 932
st_nombre_familia st_nombre_familia
end type
global wi_mant_vencuentasegunfam wi_mant_vencuentasegunfam

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.object.empresa[dw_1.getrow()] = codigo_empresa
dw_1.object.familia[dw_1.getrow()] = sle_valor.text
dw_1.object.ult_digitos_segun_serie[dw_1.getrow()] = 'S'

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "vencuentasegunfam"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de cuentas segun familias"
	//istr_parametros.s_listado        = "report_ventipolin"
   This.title = istr_parametros.s_titulo_ventana
   
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		//dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		sle_valor.triggerevent("modificado")
	END IF
END IF

	
end event

on wi_mant_vencuentasegunfam.create
int iCurrent
call super::create
this.st_nombre_familia=create st_nombre_familia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nombre_familia
end on

on wi_mant_vencuentasegunfam.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_familia)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vencuentasegunfam
integer x = 5
integer y = 336
integer width = 1728
integer height = 328
string dataobject = "dw_vencuentasegunfam"
end type

event dw_1::valores_numericos;//f_valores_numericos(dw_1,"cuenta")
end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
  CASE "cuenta_mat_propio"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
  CASE "cuenta_mat_compra"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_vencuentasegunfam"
CHOOSE CASE ls_objeto
CASE 'pb_cuenta'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta_mat_propio")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pb_cuenta2'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta_mat_compra")
   OpenWithParm(wi_mant_contaplan,lstr_param)  

END CHOOSE





end event

event dw_1::rbuttondown;bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
   CASE "cuenta_mat_propio"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
  CASE "cuenta_mat_compra"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vencuentasegunfam
integer x = 155
integer y = 220
integer width = 283
string text = "Familia :"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vencuentasegunfam
integer x = 1765
integer y = 332
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vencuentasegunfam
integer x = 1765
integer y = 452
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vencuentasegunfam
integer x = 443
integer y = 208
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_familias"
ue_titulo     =  "AYUDA SELECCION FAMILIAS"
ue_filtro     =  ""
isle_campo    = This
end event

event sle_valor::modificado;call super::modificado;st_nombre_familia.text = f_nombre_familia(codigo_empresa,sle_valor.text)

if trim(st_nombre_familia.text) = "" then
	sle_valor.text = ""
	sle_valor.setfocus()
end if
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vencuentasegunfam
integer x = 1765
integer y = 572
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vencuentasegunfam
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vencuentasegunfam
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vencuentasegunfam
integer width = 2121
end type

type st_nombre_familia from statictext within wi_mant_vencuentasegunfam
integer x = 727
integer y = 216
integer width = 1010
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

