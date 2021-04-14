$PBExportHeader$w_lis_fuera_ventarifas_iniciales.srw
forward
global type w_lis_fuera_ventarifas_iniciales from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_fuera_ventarifas_iniciales
end type
type st_2 from statictext within w_lis_fuera_ventarifas_iniciales
end type
type em_tarifa from u_em_campo within w_lis_fuera_ventarifas_iniciales
end type
type sle_fecha from u_em_campo within w_lis_fuera_ventarifas_iniciales
end type
type st_nombre_tarifa from statictext within w_lis_fuera_ventarifas_iniciales
end type
type dw_fechas from datawindow within w_lis_fuera_ventarifas_iniciales
end type
type st_1 from statictext within w_lis_fuera_ventarifas_iniciales
end type
type st_moneda_tarifa from statictext within w_lis_fuera_ventarifas_iniciales
end type
type st_pagina from statictext within w_lis_fuera_ventarifas_iniciales
end type
type pb_imprimir_preli from picturebutton within w_lis_fuera_ventarifas_iniciales
end type
type dw_preliminar from datawindow within w_lis_fuera_ventarifas_iniciales
end type
type uo_manejo from u_manejo_datawindow within w_lis_fuera_ventarifas_iniciales
end type
type st_5 from statictext within w_lis_fuera_ventarifas_iniciales
end type
type em_inicial from u_em_campo within w_lis_fuera_ventarifas_iniciales
end type
end forward

global type w_lis_fuera_ventarifas_iniciales from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 3557
integer height = 2228
pb_1 pb_1
st_2 st_2
em_tarifa em_tarifa
sle_fecha sle_fecha
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
st_1 st_1
st_moneda_tarifa st_moneda_tarifa
st_pagina st_pagina
pb_imprimir_preli pb_imprimir_preli
dw_preliminar dw_preliminar
uo_manejo uo_manejo
st_5 st_5
em_inicial em_inicial
end type
global w_lis_fuera_ventarifas_iniciales w_lis_fuera_ventarifas_iniciales

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_pagina ()
end prototypes

public subroutine f_control ();Datetime fecha
fecha = DateTime(Date(String(sle_fecha.Text)))
filtro = "IsNUll(venlintarifas_tarifa)"  
dw_preliminar.SetFilter("")
dw_preliminar.SetFilter(filtro)
dw_preliminar.Filter()
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "90" + ")")
String iniciales
iniciales = Trim(em_inicial.text) + "%"
dw_preliminar.Retrieve(codigo_empresa,em_tarifa.text,fecha,iniciales)
f_pagina()

end subroutine

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta articulos fuera de tarifas"
This.title=istr_parametros.s_titulo_ventana
sle_fecha.text  =  String(today())
dw_preliminar.SetTransObject(SQLCA)
dw_fechas.SetTransObject(SQLCA)

end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_lis_fuera_ventarifas_iniciales.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.sle_fecha=create sle_fecha
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.st_1=create st_1
this.st_moneda_tarifa=create st_moneda_tarifa
this.st_pagina=create st_pagina
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_preliminar=create dw_preliminar
this.uo_manejo=create uo_manejo
this.st_5=create st_5
this.em_inicial=create em_inicial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_tarifa
this.Control[iCurrent+4]=this.sle_fecha
this.Control[iCurrent+5]=this.st_nombre_tarifa
this.Control[iCurrent+6]=this.dw_fechas
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_moneda_tarifa
this.Control[iCurrent+9]=this.st_pagina
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.dw_preliminar
this.Control[iCurrent+12]=this.uo_manejo
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_inicial
end on

on w_lis_fuera_ventarifas_iniciales.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.sle_fecha)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.st_1)
destroy(this.st_moneda_tarifa)
destroy(this.st_pagina)
destroy(this.pb_imprimir_preli)
destroy(this.dw_preliminar)
destroy(this.uo_manejo)
destroy(this.st_5)
destroy(this.em_inicial)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_fuera_ventarifas_iniciales
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_fuera_ventarifas_iniciales
end type

type st_empresa from w_int_con_empresa`st_empresa within w_lis_fuera_ventarifas_iniciales
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_lis_fuera_ventarifas_iniciales
integer x = 3319
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_lis_fuera_ventarifas_iniciales
integer x = 37
integer y = 168
integer width = 192
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

type em_tarifa from u_em_campo within w_lis_fuera_ventarifas_iniciales
integer x = 238
integer y = 164
integer taborder = 20
end type

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa_abr(codigo_empresa,em_tarifa.text)
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
fecha = date(var_activa)
sle_fecha.text = String(fecha,"dd/mm/yy")
f_control()
dw_fechas.retrieve(codigo_empresa,em_tarifa.text)   





 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

type sle_fecha from u_em_campo within w_lis_fuera_ventarifas_iniciales
integer x = 507
integer y = 164
integer width = 283
integer taborder = 30
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

type st_nombre_tarifa from statictext within w_lis_fuera_ventarifas_iniciales
integer x = 809
integer y = 164
integer width = 878
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_fechas from datawindow within w_lis_fuera_ventarifas_iniciales
integer x = 1851
integer y = 132
integer width = 617
integer height = 252
boolean bringtotop = true
string dataobject = "dw_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then Return

sle_fecha.text  = String(Date(This.GetItemDateTime(Row,"fecha")))
f_control()
f_activar_campo(em_tarifa)
end event

type st_1 from statictext within w_lis_fuera_ventarifas_iniciales
integer x = 41
integer y = 264
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Moneda:"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_moneda_tarifa from statictext within w_lis_fuera_ventarifas_iniciales
integer x = 352
integer y = 260
integer width = 960
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_pagina from statictext within w_lis_fuera_ventarifas_iniciales
integer x = 599
integer y = 372
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_lis_fuera_ventarifas_iniciales
integer x = 471
integer y = 356
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

on clicked;str_parametros pa
pa.s_listado = dw_preliminar.DataObject
OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_tarifa)
end on

type dw_preliminar from datawindow within w_lis_fuera_ventarifas_iniciales
integer y = 464
integer width = 3438
integer height = 1452
string dataobject = "report_lis_fuera_ventarifas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;str_parametros lstr_param
IF Row = 0 Then Return
  lstr_param.i_nargumentos=5
  lstr_param.s_argumentos[2]=This.GetItemString(Row,"tarifa")
  lstr_param.s_argumentos[3]=String(Date(This.GetItemDateTime(Row,"fecha")))
  lstr_param.s_argumentos[4]=This.GetItemString(Row,"articulo")
  lstr_param.s_argumentos[5]=This.GetItemString(Row,"calidad")
  OpenWithParm(wi_mant_venlintarifas,lstr_param) 

end event

type uo_manejo from u_manejo_datawindow within w_lis_fuera_ventarifas_iniciales
integer y = 308
integer taborder = 50
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type st_5 from statictext within w_lis_fuera_ventarifas_iniciales
integer x = 1339
integer y = 268
integer width = 197
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
string text = "Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_inicial from u_em_campo within w_lis_fuera_ventarifas_iniciales
integer x = 1554
integer y = 264
integer taborder = 40
boolean bringtotop = true
end type

event modificado;call super::modificado;f_control()
end event

