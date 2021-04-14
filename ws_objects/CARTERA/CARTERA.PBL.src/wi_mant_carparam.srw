$PBExportHeader$wi_mant_carparam.srw
$PBExportComments$€
forward
global type wi_mant_carparam from wi_mvent_con_empresa
end type
type gb_1 from groupbox within wi_mant_carparam
end type
end forward

global type wi_mant_carparam from wi_mvent_con_empresa
integer width = 2629
integer height = 1100
gb_1 gb_1
end type
global wi_mant_carparam wi_mant_carparam

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,Integer(sle_valor.Text))
end subroutine

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "carparam"

f_control()
CALL Super::ue_recuperar
end event

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento parametros de Cartera"
	istr_parametros.s_listado         = "report_carparam"
   This.title = istr_parametros.s_titulo_ventana
   f_mascara_columna(dw_1,"orden",f_mascara_decimales(0))
   sle_valor.text=String(year(today()))
   f_control()
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         f_control()
      END IF
   END IF


	
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"anyo",Integer(sle_valor.text))



end event

on wi_mant_carparam.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on wi_mant_carparam.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carparam
integer x = 18
integer y = 320
integer width = 2519
integer height = 416
string dataobject = "dw_carparam"
end type

event dw_1::key; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo

 CASE "tipodoc"
      bus_datawindow = "dw_ayuda_cartipodoc"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "tipodoc"
      bus_datawindow = "dw_ayuda_cartipodoc"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;string ls_objeto
str_parametros lstr_param
valor_empresa= TRUE
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_transportistas"

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_carpeta'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipodoc")
   OpenWithParm(wi_mant_cartipodoc,lstr_param) 
	
END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carparam
integer x = 594
integer y = 212
integer width = 215
string text = "Año:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carparam
integer x = 1353
integer y = 208
integer width = 389
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carparam
integer x = 1742
integer y = 208
integer width = 389
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carparam
integer x = 818
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carparam
integer x = 2130
integer y = 208
integer width = 389
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carparam
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carparam
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carparam
integer width = 2354
end type

type gb_1 from groupbox within wi_mant_carparam
integer x = 1344
integer y = 172
integer width = 1184
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

