$PBExportHeader$w_con_riesgos_bancos_cartera.srw
$PBExportComments$€
forward
global type w_con_riesgos_bancos_cartera from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_riesgos_bancos_cartera
end type
type cb_consulta from u_boton within w_con_riesgos_bancos_cartera
end type
type dw_listado from datawindow within w_con_riesgos_bancos_cartera
end type
type dw_1 from datawindow within w_con_riesgos_bancos_cartera
end type
type pb_1 from upb_imprimir within w_con_riesgos_bancos_cartera
end type
end forward

global type w_con_riesgos_bancos_cartera from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2930
integer height = 2240
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
dw_listado dw_listado
dw_1 dw_1
pb_1 pb_1
end type
global w_con_riesgos_bancos_cartera w_con_riesgos_bancos_cartera

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Dec j,riesgo
String banco,nombre

dw_data.Retrieve(codigo_empresa)
For j = 1 To dw_data.RowCOunt()
	banco = dw_data.Object.banco[j]

	SELECT carbancos.riesgo,carbancos.nombre  
	INTO   :riesgo,   :nombre  
	FROM   carbancos  
	WHERE  carbancos.empresa = :codigo_empresa 
	AND    carbancos.banco   = :banco;
	
	dw_data.Object.riesgo[j]       = riesgo
	dw_data.Object.nombre_banco[j] = nombre

Next

end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
This.title = " CONSULTA RIESGOS BANCOS"


end event

on w_con_riesgos_bancos_cartera.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.pb_1
end on

on w_con_riesgos_bancos_cartera.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_riesgos_bancos_cartera
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_riesgos_bancos_cartera
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_riesgos_bancos_cartera
integer x = 27
integer y = 24
integer width = 2642
end type

type pb_2 from upb_salir within w_con_riesgos_bancos_cartera
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_riesgos_bancos_cartera
integer x = 37
integer y = 144
integer width = 325
integer height = 96
integer taborder = 10
string text = "&Consulta"
end type

event clicked;f_cargar(dw_1)

end event

type dw_listado from datawindow within w_con_riesgos_bancos_cartera
boolean visible = false
integer x = 640
integer y = 152
integer width = 256
integer height = 72
string dataobject = "report_con_riesgos_bancos_cartera"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_riesgos_bancos_cartera
integer x = 9
integer y = 252
integer width = 2857
integer height = 1768
integer taborder = 40
string dataobject = "dw_con_riesgos_bancos_cartera"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")


	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado,lstr_param)

End If
end event

type pb_1 from upb_imprimir within w_con_riesgos_bancos_cartera
integer x = 361
integer y = 144
integer taborder = 20
boolean bringtotop = true
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

