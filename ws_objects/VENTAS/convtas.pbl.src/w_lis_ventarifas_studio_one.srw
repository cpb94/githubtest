$PBExportHeader$w_lis_ventarifas_studio_one.srw
forward
global type w_lis_ventarifas_studio_one from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_ventarifas_studio_one
end type
type st_2 from statictext within w_lis_ventarifas_studio_one
end type
type em_tarifa from u_em_campo within w_lis_ventarifas_studio_one
end type
type sle_fecha from u_em_campo within w_lis_ventarifas_studio_one
end type
type st_nombre_tarifa from statictext within w_lis_ventarifas_studio_one
end type
type dw_fechas from datawindow within w_lis_ventarifas_studio_one
end type
type st_moneda_tarifa from statictext within w_lis_ventarifas_studio_one
end type
type st_pagina from statictext within w_lis_ventarifas_studio_one
end type
type pb_imprimir_preli from picturebutton within w_lis_ventarifas_studio_one
end type
type uo_idioma from u_em_campo_2 within w_lis_ventarifas_studio_one
end type
type st_1 from statictext within w_lis_ventarifas_studio_one
end type
type st_3 from statictext within w_lis_ventarifas_studio_one
end type
type st_4 from statictext within w_lis_ventarifas_studio_one
end type
type cb_procesar from commandbutton within w_lis_ventarifas_studio_one
end type
type cabecera from dropdownlistbox within w_lis_ventarifas_studio_one
end type
type ddlb_1 from dropdownlistbox within w_lis_ventarifas_studio_one
end type
type st_5 from statictext within w_lis_ventarifas_studio_one
end type
type uo_manejo from u_manejo_datawindow within w_lis_ventarifas_studio_one
end type
type dw_preliminar from datawindow within w_lis_ventarifas_studio_one
end type
end forward

global type w_lis_ventarifas_studio_one from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3557
integer height = 2220
pb_1 pb_1
st_2 st_2
em_tarifa em_tarifa
sle_fecha sle_fecha
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
st_moneda_tarifa st_moneda_tarifa
st_pagina st_pagina
pb_imprimir_preli pb_imprimir_preli
uo_idioma uo_idioma
st_1 st_1
st_3 st_3
st_4 st_4
cb_procesar cb_procesar
cabecera cabecera
ddlb_1 ddlb_1
st_5 st_5
uo_manejo uo_manejo
dw_preliminar dw_preliminar
end type
global w_lis_ventarifas_studio_one w_lis_ventarifas_studio_one

type variables
string filtro,bmp

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_pagina ()
end prototypes

public subroutine f_control ();Datetime fecha
IF sle_fecha.Text = "00-00-00" Then 
	dw_preliminar.reset()
	Return
END IF

String impre
impre="N"
if ddlb_1.text ="Si" then impre ="S"

if cabecera.text <>"No" then
	bmp ="\bmp\equipe.bmp"
End if

fecha = DateTime(Date(String(sle_fecha.Text)))
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "90" + ")")
dw_preliminar.Retrieve(codigo_empresa,em_tarifa.text,fecha,uo_idioma.em_codigo.text,bmp,impre)
//f_pagina()

end subroutine

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de tarifas"
This.title=istr_parametros.s_titulo_ventana
sle_fecha.text  =  String(today())
dw_preliminar.SetTransObject(SQLCA)
dw_fechas.SetTransObject(SQLCA)
uo_idioma.em_codigo.text = codigo_idioma
uo_idioma.em_campo.text=f_nombre_idioma(uo_idioma.em_codigo.text)
cabecera.text = "Si"
ddlb_1.text = "Si"

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

on w_lis_ventarifas_studio_one.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.sle_fecha=create sle_fecha
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.st_moneda_tarifa=create st_moneda_tarifa
this.st_pagina=create st_pagina
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_idioma=create uo_idioma
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.cb_procesar=create cb_procesar
this.cabecera=create cabecera
this.ddlb_1=create ddlb_1
this.st_5=create st_5
this.uo_manejo=create uo_manejo
this.dw_preliminar=create dw_preliminar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_tarifa
this.Control[iCurrent+4]=this.sle_fecha
this.Control[iCurrent+5]=this.st_nombre_tarifa
this.Control[iCurrent+6]=this.dw_fechas
this.Control[iCurrent+7]=this.st_moneda_tarifa
this.Control[iCurrent+8]=this.st_pagina
this.Control[iCurrent+9]=this.pb_imprimir_preli
this.Control[iCurrent+10]=this.uo_idioma
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.cb_procesar
this.Control[iCurrent+15]=this.cabecera
this.Control[iCurrent+16]=this.ddlb_1
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.uo_manejo
this.Control[iCurrent+19]=this.dw_preliminar
end on

on w_lis_ventarifas_studio_one.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.sle_fecha)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.st_moneda_tarifa)
destroy(this.st_pagina)
destroy(this.pb_imprimir_preli)
destroy(this.uo_idioma)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_procesar)
destroy(this.cabecera)
destroy(this.ddlb_1)
destroy(this.st_5)
destroy(this.uo_manejo)
destroy(this.dw_preliminar)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

event ue_f5;call super::ue_f5;cb_procesar.TriggerEvent("Clicked")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_ventarifas_studio_one
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_ventarifas_studio_one
end type

type st_empresa from w_int_con_empresa`st_empresa within w_lis_ventarifas_studio_one
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_lis_ventarifas_studio_one
integer x = 3227
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_lis_ventarifas_studio_one
integer x = 18
integer y = 140
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

type em_tarifa from u_em_campo within w_lis_ventarifas_studio_one
integer x = 219
integer y = 136
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
sle_fecha.text = String(fecha,"dd-mm-yy")
//f_control()
dw_fechas.retrieve(codigo_empresa,em_tarifa.text)   





 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

type sle_fecha from u_em_campo within w_lis_ventarifas_studio_one
integer x = 1317
integer y = 336
integer width = 283
integer height = 92
integer taborder = 50
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event getfocus;call super::getfocus;//If sle_fecha.text = "00-00-00" Then
//  em_tarifa.TriggerEvent("modificado")
//END IF
//
//
//
//
end event

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

type st_nombre_tarifa from statictext within w_lis_ventarifas_studio_one
integer x = 480
integer y = 136
integer width = 987
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_fechas from datawindow within w_lis_ventarifas_studio_one
integer x = 2939
integer y = 128
integer width = 439
integer height = 304
boolean bringtotop = true
string dataobject = "dw_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then Return

sle_fecha.text  = String(Date(This.GetItemDateTime(Row,"fecha")))
//f_control()
//f_activar_campo(em_tarifa)
end event

type st_moneda_tarifa from statictext within w_lis_ventarifas_studio_one
integer x = 1467
integer y = 136
integer width = 905
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_pagina from statictext within w_lis_ventarifas_studio_one
integer x = 64
integer y = 236
integer width = 379
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_lis_ventarifas_studio_one
integer x = 475
integer y = 328
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

type uo_idioma from u_em_campo_2 within w_lis_ventarifas_studio_one
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1600
integer y = 336
integer width = 393
integer height = 92
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_idioma.em_campo.text=f_nombre_idioma(uo_idioma.em_codigo.text)
IF Trim(uo_idioma.em_campo.text)="" THEN 
 IF Trim(uo_idioma.em_codigo.text) <> "" Then uo_idioma.em_campo.SetFocus()
 uo_idioma.em_campo.text  = ""
 uo_idioma.em_codigo.text = ""
END IF
//f_activar_campo(uo_idioma.em_campo)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de idiomas"
ue_datawindow = "dw_ayuda_idiomas"
ue_filtro     = ""
valor_empresa=  FALSE
end event

on uo_idioma.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_lis_ventarifas_studio_one
integer x = 1600
integer y = 252
integer width = 398
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Idioma"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_lis_ventarifas_studio_one
integer x = 763
integer y = 344
integer width = 315
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_lis_ventarifas_studio_one
integer x = 1317
integer y = 252
integer width = 283
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F.Activa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_procesar from commandbutton within w_lis_ventarifas_studio_one
integer x = 2542
integer y = 328
integer width = 361
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Procesar"
end type

event clicked;
f_activar_campo(em_tarifa)
f_control()

end event

type cabecera from dropdownlistbox within w_lis_ventarifas_studio_one
integer x = 1097
integer y = 336
integer width = 197
integer height = 216
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"No","Si"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_lis_ventarifas_studio_one
integer x = 1097
integer y = 236
integer width = 197
integer height = 228
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Si","No"}
end type

type st_5 from statictext within w_lis_ventarifas_studio_one
integer x = 635
integer y = 252
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Imprime precios"
boolean focusrectangle = false
end type

type uo_manejo from u_manejo_datawindow within w_lis_ventarifas_studio_one
integer x = 5
integer y = 284
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_preliminar from datawindow within w_lis_ventarifas_studio_one
integer y = 448
integer width = 3470
integer height = 1492
string dataobject = "report_lis_ventarifas"
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

