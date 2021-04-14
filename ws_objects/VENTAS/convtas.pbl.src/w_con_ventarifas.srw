$PBExportHeader$w_con_ventarifas.srw
forward
global type w_con_ventarifas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_ventarifas
end type
type pb_2 from upb_imprimir within w_con_ventarifas
end type
type st_2 from statictext within w_con_ventarifas
end type
type em_tarifa from u_em_campo within w_con_ventarifas
end type
type sle_fecha from u_em_campo within w_con_ventarifas
end type
type st_nombre_tarifa from statictext within w_con_ventarifas
end type
type dw_listado from datawindow within w_con_ventarifas
end type
type st_moneda_tarifa from statictext within w_con_ventarifas
end type
type uo_1 from u_manejo_datawindow within w_con_ventarifas
end type
type dw_fechas from datawindow within w_con_ventarifas
end type
type em_descripcion from u_em_campo within w_con_ventarifas
end type
type st_9 from statictext within w_con_ventarifas
end type
type cb_procesar from u_boton within w_con_ventarifas
end type
type cb_salir from u_boton within w_con_ventarifas
end type
type dw_detalle from u_datawindow_consultas within w_con_ventarifas
end type
end forward

global type w_con_ventarifas from w_int_con_empresa
integer width = 3223
integer height = 2560
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_tarifa em_tarifa
sle_fecha sle_fecha
st_nombre_tarifa st_nombre_tarifa
dw_listado dw_listado
st_moneda_tarifa st_moneda_tarifa
uo_1 uo_1
dw_fechas dw_fechas
em_descripcion em_descripcion
st_9 st_9
cb_procesar cb_procesar
cb_salir cb_salir
dw_detalle dw_detalle
end type
global w_con_ventarifas w_con_ventarifas

type variables
string filtro,bloqueado
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();Datetime fecha

IF sle_fecha.Text = "00-00-00" Then
	dw_detalle.Reset()
	Return
END IF
fecha = DateTime(Date(String(sle_fecha.Text)))
String descripcion
descripcion = "%"+em_descripcion.text+"%"
dw_detalle.Retrieve(codigo_empresa,em_tarifa.text,fecha,descripcion)

end subroutine

event ue_listar;
dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
fecha = DateTime(Date(String(sle_fecha.Text)))
dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)


filtro = ' descripcion like "%'+em_descripcion.text+'%" '

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de tarifas"
This.title=istr_parametros.s_titulo_ventana
sle_fecha.text  =  String(today())
bloqueado = "N"
dw_detalle.SetTransObject(SQLCA)
dw_fechas.SetTransObject(SQLCA)



end event

on w_con_ventarifas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.sle_fecha=create sle_fecha
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_listado=create dw_listado
this.st_moneda_tarifa=create st_moneda_tarifa
this.uo_1=create uo_1
this.dw_fechas=create dw_fechas
this.em_descripcion=create em_descripcion
this.st_9=create st_9
this.cb_procesar=create cb_procesar
this.cb_salir=create cb_salir
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_tarifa
this.Control[iCurrent+5]=this.sle_fecha
this.Control[iCurrent+6]=this.st_nombre_tarifa
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.st_moneda_tarifa
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.dw_fechas
this.Control[iCurrent+11]=this.em_descripcion
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.cb_procesar
this.Control[iCurrent+14]=this.cb_salir
this.Control[iCurrent+15]=this.dw_detalle
end on

on w_con_ventarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.sle_fecha)
destroy(this.st_nombre_tarifa)
destroy(this.dw_listado)
destroy(this.st_moneda_tarifa)
destroy(this.uo_1)
destroy(this.dw_fechas)
destroy(this.em_descripcion)
destroy(this.st_9)
destroy(this.cb_procesar)
destroy(this.cb_salir)
destroy(this.dw_detalle)
end on

event close;call super::close;If bloqueado="S" Then 
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"
End IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.triggerEvent("pagina_arriba")
end event

event activate;call super::activate;w_con_ventarifas = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ventarifas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ventarifas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ventarifas
integer x = 27
integer y = 8
integer width = 2885
end type

type pb_1 from upb_salir within w_con_ventarifas
integer x = 2958
integer width = 128
integer height = 120
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_ventarifas
integer x = 489
integer y = 260
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_ventarifas
integer y = 132
integer width = 206
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within w_con_ventarifas
integer x = 229
integer y = 128
integer taborder = 60
end type

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF

st_moneda_tarifa.text=f_nombre_moneda(f_moneda_ventarifas(codigo_empresa,em_tarifa.text))

String tarifa,var_empresa,var_codigo
Datetime var_activa
tarifa =em_tarifa.text

  SELECT ventarifas.empresa,ventarifas.codigo,ventarifas.activa  
    INTO :var_empresa,:var_codigo,:var_activa  
    FROM ventarifas  
   WHERE (ventarifas.empresa = :codigo_empresa ) AND  
         (ventarifas.codigo  = :tarifa )   
ORDER BY ventarifas.empresa ASC,ventarifas.codigo ASC  ;


Date fecha
String v_moneda

fecha = date(var_activa)
sle_fecha.text = String(fecha,"dd/mm/yy")

v_moneda=f_moneda_ventarifas(codigo_empresa,em_tarifa.text)
//***
if v_moneda="1" then
	f_mascara_columna(dw_detalle,"precio","###,###,###,###.00")
else
	f_mascara_columna(dw_detalle,"precio",f_mascara_precios_moneda(v_moneda))
end if
f_control()
dw_fechas.retrieve(codigo_empresa,em_tarifa.text)   





 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

type sle_fecha from u_em_campo within w_con_ventarifas
integer x = 494
integer y = 128
integer width = 283
integer taborder = 80
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

on getfocus;call u_em_campo::getfocus;If sle_fecha.text = "00/00/00" Then
  em_tarifa.TriggerEvent("modificado")
END IF




end on

on modificado;call u_em_campo::modificado;Datetime fecha,fecha1
String   tarifa
fecha   = Datetime(Date(sle_fecha.text))
tarifa  = em_tarifa.text

  SELECT venmapatarifas.f_alta  
    INTO :fecha1  
    FROM venmapatarifas  
   WHERE ( venmapatarifas.empresa = :codigo_empresa ) AND  
         ( venmapatarifas.tarifa = :tarifa ) AND  
         ( venmapatarifas.fecha = :fecha )   ;
  IF SQLCA.SQLCODE =100   THEN
      MessageBox("Tarifa no definida en el mapa","No existe la tarifa a esa fecha ",Exclamation!, OK!,1)
      em_tarifa.TriggerEvent("modificado")
      sle_fecha.SetFocus()
      RETURN
  END IF

end on

type st_nombre_tarifa from statictext within w_con_ventarifas
integer x = 782
integer y = 128
integer width = 1029
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_ventarifas
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 100
boolean bringtotop = true
string dataobject = "report_con_ventarifas"
boolean livescroll = true
end type

type st_moneda_tarifa from statictext within w_con_ventarifas
integer x = 1815
integer y = 128
integer width = 425
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
end type

type uo_1 from u_manejo_datawindow within w_con_ventarifas
integer x = 14
integer y = 212
integer width = 603
integer height = 148
end type

on valores;call u_manejo_datawindow::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_tarifa)
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_fechas from datawindow within w_con_ventarifas
integer x = 2478
integer y = 124
integer width = 613
integer height = 240
boolean bringtotop = true
string dataobject = "dw_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row =0 Then Return

sle_fecha.text  = String(Date(This.GetItemDateTime(row,"fecha")))
f_control()

f_activar_campo(em_tarifa)
end event

type em_descripcion from u_em_campo within w_con_ventarifas
integer x = 955
integer y = 256
integer width = 818
integer height = 92
integer taborder = 120
end type

event tecla_enter;call super::tecla_enter;f_control()
end event

type st_9 from statictext within w_con_ventarifas
integer x = 631
integer y = 268
integer width = 320
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Busqueda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_procesar from u_boton within w_con_ventarifas
boolean visible = false
integer x = 1810
integer y = 216
integer width = 425
integer height = 80
integer taborder = 20
string text = "F3  Aceptar"
end type

event clicked;call super::clicked;dw_detalle.AcceptText()
dw_detalle.Update()
cb_salir.TriggerEvent(Clicked!)
COMMIT;
end event

type cb_salir from u_boton within w_con_ventarifas
boolean visible = false
integer x = 1810
integer y = 296
integer width = 425
integer height = 80
integer taborder = 10
boolean bringtotop = true
string text = "Esc Salir"
end type

event clicked;call super::clicked;cb_salir.visible = FALSE
cb_procesar.visible = FALSE
dw_fechas.enabled = TRUE
em_descripcion.enabled = TRUE
em_tarifa.enabled = TRUE
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"
f_control()
f_activar_campo(em_tarifa)
end event

type dw_detalle from u_datawindow_consultas within w_con_ventarifas
integer y = 372
integer width = 3113
integer height = 1924
integer taborder = 0
string dataobject = "dw_con_ventarifas"
boolean vscrollbar = true
end type

event clicked;call super::clicked;IF bloqueado = "S" Then Return
IF This.RowCOunt() <> 0 Then
 titulo        =  Parent.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 
 longitud      =  len(trim(em_tarifa.text))
 criterio[2]   =  trim(em_tarifa.text)+space(20-longitud)
 datetime fecha
 fecha = dw_fechas.GetItemDatetime(dw_fechas.GetRow(),"fecha")
 longitud      =  len(trim(String(fecha)))
 criterio[3]   =  trim(String(fecha))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]+criterio[3]
 tabla         =  "venmapatarifas"

 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
  COMMIT Using SQLCA; //Solucion nivel insolacion
   bloqueado = "S"
	cb_salir.visible = TRUE
	cb_procesar.visible = TRUE
	dw_fechas.enabled = FALSE
	em_descripcion.enabled = FALSE
	em_tarifa.enabled = FALSE
ELSE
	f_activar_campo(em_tarifa)
END IF
	
END IF	
end event

