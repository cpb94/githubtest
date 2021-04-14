$PBExportHeader$w_int_etiquetas_contactos.srw
$PBExportComments$Listado etiquetas y cartas a contactos. Gestion llamadas mailing.
forward
global type w_int_etiquetas_contactos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_contactos
end type
type rb_pendientes from radiobutton within w_int_etiquetas_contactos
end type
type rb_todos from radiobutton within w_int_etiquetas_contactos
end type
type st_enunciado from statictext within w_int_etiquetas_contactos
end type
type em_fecha from u_em_campo within w_int_etiquetas_contactos
end type
type dw_listado from datawindow within w_int_etiquetas_contactos
end type
type rb_repetir from radiobutton within w_int_etiquetas_contactos
end type
type pb_preliminar_etiqueta from picturebutton within w_int_etiquetas_contactos
end type
type pb_imprimir_etiqueta from picturebutton within w_int_etiquetas_contactos
end type
type st_1 from statictext within w_int_etiquetas_contactos
end type
type dw_preliminar from datawindow within w_int_etiquetas_contactos
end type
type st_pagina from statictext within w_int_etiquetas_contactos
end type
type pb_anterior from picturebutton within w_int_etiquetas_contactos
end type
type pb_ultimo from picturebutton within w_int_etiquetas_contactos
end type
type pb_primero from picturebutton within w_int_etiquetas_contactos
end type
type pb_siguiente from picturebutton within w_int_etiquetas_contactos
end type
type pb_imprimir_carta from picturebutton within w_int_etiquetas_contactos
end type
type pb_preliminar_carta from picturebutton within w_int_etiquetas_contactos
end type
type st_2 from statictext within w_int_etiquetas_contactos
end type
type pb_imprimir_preli from picturebutton within w_int_etiquetas_contactos
end type
type st_texto from statictext within w_int_etiquetas_contactos
end type
type gb_5 from groupbox within w_int_etiquetas_contactos
end type
type gb_1 from groupbox within w_int_etiquetas_contactos
end type
type gb_3 from groupbox within w_int_etiquetas_contactos
end type
type gb_2 from groupbox within w_int_etiquetas_contactos
end type
type cb_1 from u_boton within w_int_etiquetas_contactos
end type
type uo_contacto from u_em_campo_2 within w_int_etiquetas_contactos
end type
type st_desde from statictext within w_int_etiquetas_contactos
end type
type em_fecha_desde from u_em_campo within w_int_etiquetas_contactos
end type
type gb_4 from groupbox within w_int_etiquetas_contactos
end type
end forward

global type w_int_etiquetas_contactos from w_int_con_empresa
integer width = 2898
integer height = 2016
pb_1 pb_1
rb_pendientes rb_pendientes
rb_todos rb_todos
st_enunciado st_enunciado
em_fecha em_fecha
dw_listado dw_listado
rb_repetir rb_repetir
pb_preliminar_etiqueta pb_preliminar_etiqueta
pb_imprimir_etiqueta pb_imprimir_etiqueta
st_1 st_1
dw_preliminar dw_preliminar
st_pagina st_pagina
pb_anterior pb_anterior
pb_ultimo pb_ultimo
pb_primero pb_primero
pb_siguiente pb_siguiente
pb_imprimir_carta pb_imprimir_carta
pb_preliminar_carta pb_preliminar_carta
st_2 st_2
pb_imprimir_preli pb_imprimir_preli
st_texto st_texto
gb_5 gb_5
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
cb_1 cb_1
uo_contacto uo_contacto
st_desde st_desde
em_fecha_desde em_fecha_desde
gb_4 gb_4
end type
global w_int_etiquetas_contactos w_int_etiquetas_contactos

type variables
string tipo
Integer  registro
String opcion
Integer ii_valor_zoom,contador
end variables

forward prototypes
public function boolean f_control ()
public subroutine f_pagina ()
public subroutine f_reset ()
public subroutine f_marcar_cartas ()
public subroutine f_marcar_etiquetas ()
end prototypes

public function boolean f_control ();Integer numero  
DateTime  fecha

fecha =DateTime(Date(em_fecha.text))

SELECT count(*)INTO :numero  
FROM   mllamadas  
WHERE ( mllamadas.empresa = :codigo_empresa ) AND  
     ( mllamadas.fecha   <= :fecha ) AND  
     ( mllamadas.imp_etiquetas = 'N' );
If IsNull(numero) Then numero =0
If numero=0 Then
  return True
Else
  Return False
End If

end function

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

public subroutine f_reset ();//dw_preliminar.Reset()
//dw_report.Reset()
//
end subroutine

public subroutine f_marcar_cartas ();if rb_repetir.checked = True then return
DateTime fecha1,fecha2,fecha
String contacto
fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha.text))
fecha  = DateTime(Today())

IF MessageBox("Marcar la opcion desada","Desa Marcar las cartas como listadas",Question!, YesNo!,2) = 1 Then

IF Trim(uo_contacto.em_codigo.text) <> "" Then
  contacto = uo_contacto.em_codigo.text
  UPDATE mllamadas  
     SET enviados = "S",
         f_listado = :fecha
   WHERE ( mllamadas.empresa = :codigo_empresa ) AND  
         ( mllamadas.fecha >= :fecha1 ) AND  
         ( mllamadas.fecha <= :fecha2 ) AND  
         ( mllamadas.enviados = 'N' ) AND
         ( mllamadas.contacto = :contacto );
 ELSE
  UPDATE mllamadas  
     SET enviados = "S",
         f_listado = :fecha
   WHERE ( mllamadas.empresa = :codigo_empresa ) AND  
         ( mllamadas.fecha >= :fecha1 ) AND  
         ( mllamadas.fecha <= :fecha2 ) AND  
         ( mllamadas.enviados = 'N' )   ;
END IF
   COMMIT;
END IF
end subroutine

public subroutine f_marcar_etiquetas ();if rb_repetir.checked = True then return
DateTime fecha1,fecha2
String   contacto
fecha1 = DateTime(Date(em_fecha_desde.text))
fecha2 = DateTime(Date(em_fecha.text))
IF MessageBox("Marcar la opcion desada","Desa Marcar las etiquetas como listadas",Question!, YesNo!,2) = 1 Then
 IF len(Trim(uo_contacto.em_codigo.text)) <> 0 Then
  contacto = uo_contacto.em_codigo.text
  UPDATE mllamadas  
     SET imp_etiquetas = "S"
   WHERE ( mllamadas.empresa = :codigo_empresa ) AND  
         ( mllamadas.fecha >= :fecha1 ) AND  
         ( mllamadas.fecha <= :fecha2 ) AND  
         ( mllamadas.imp_etiquetas = 'N' ) AND
         ( mllamadas.contacto = :contacto )   ;
 ELSE
  UPDATE mllamadas  
     SET imp_etiquetas = "S"
   WHERE ( mllamadas.empresa = :codigo_empresa ) AND  
         ( mllamadas.fecha >= :fecha1 ) AND  
         ( mllamadas.fecha <= :fecha2 ) AND  
         ( mllamadas.imp_etiquetas = 'N' )   ;
  END IF
   COMMIT;
END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado etiquetas contactos"
This.title=istr_parametros.s_titulo_ventana
tipo ="P"
em_fecha.text = String(today())
em_fecha_desde.text = String(today())

end event

on w_int_etiquetas_contactos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.rb_pendientes=create rb_pendientes
this.rb_todos=create rb_todos
this.st_enunciado=create st_enunciado
this.em_fecha=create em_fecha
this.dw_listado=create dw_listado
this.rb_repetir=create rb_repetir
this.pb_preliminar_etiqueta=create pb_preliminar_etiqueta
this.pb_imprimir_etiqueta=create pb_imprimir_etiqueta
this.st_1=create st_1
this.dw_preliminar=create dw_preliminar
this.st_pagina=create st_pagina
this.pb_anterior=create pb_anterior
this.pb_ultimo=create pb_ultimo
this.pb_primero=create pb_primero
this.pb_siguiente=create pb_siguiente
this.pb_imprimir_carta=create pb_imprimir_carta
this.pb_preliminar_carta=create pb_preliminar_carta
this.st_2=create st_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_texto=create st_texto
this.gb_5=create gb_5
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_1=create cb_1
this.uo_contacto=create uo_contacto
this.st_desde=create st_desde
this.em_fecha_desde=create em_fecha_desde
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.rb_pendientes
this.Control[iCurrent+3]=this.rb_todos
this.Control[iCurrent+4]=this.st_enunciado
this.Control[iCurrent+5]=this.em_fecha
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.rb_repetir
this.Control[iCurrent+8]=this.pb_preliminar_etiqueta
this.Control[iCurrent+9]=this.pb_imprimir_etiqueta
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_preliminar
this.Control[iCurrent+12]=this.st_pagina
this.Control[iCurrent+13]=this.pb_anterior
this.Control[iCurrent+14]=this.pb_ultimo
this.Control[iCurrent+15]=this.pb_primero
this.Control[iCurrent+16]=this.pb_siguiente
this.Control[iCurrent+17]=this.pb_imprimir_carta
this.Control[iCurrent+18]=this.pb_preliminar_carta
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.pb_imprimir_preli
this.Control[iCurrent+21]=this.st_texto
this.Control[iCurrent+22]=this.gb_5
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.gb_3
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.cb_1
this.Control[iCurrent+27]=this.uo_contacto
this.Control[iCurrent+28]=this.st_desde
this.Control[iCurrent+29]=this.em_fecha_desde
this.Control[iCurrent+30]=this.gb_4
end on

on w_int_etiquetas_contactos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.rb_pendientes)
destroy(this.rb_todos)
destroy(this.st_enunciado)
destroy(this.em_fecha)
destroy(this.dw_listado)
destroy(this.rb_repetir)
destroy(this.pb_preliminar_etiqueta)
destroy(this.pb_imprimir_etiqueta)
destroy(this.st_1)
destroy(this.dw_preliminar)
destroy(this.st_pagina)
destroy(this.pb_anterior)
destroy(this.pb_ultimo)
destroy(this.pb_primero)
destroy(this.pb_siguiente)
destroy(this.pb_imprimir_carta)
destroy(this.pb_preliminar_carta)
destroy(this.st_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_texto)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.uo_contacto)
destroy(this.st_desde)
destroy(this.em_fecha_desde)
destroy(this.gb_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_contactos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_contactos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_contactos
integer width = 2683
end type

type pb_1 from upb_salir within w_int_etiquetas_contactos
integer x = 2729
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type rb_pendientes from radiobutton within w_int_etiquetas_contactos
integer x = 32
integer y = 164
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pendientes"
boolean checked = true
end type

on clicked;tipo="P"
rb_todos.checked=FALSE
rb_repetir.checked=FALSE
st_enunciado.text = " Fecha Hasta:"
st_desde.visible = TRUE
em_fecha_desde.visible = TRUE
f_activar_campo(em_fecha_desde)
end on

type rb_todos from radiobutton within w_int_etiquetas_contactos
integer x = 32
integer y = 240
integer width = 338
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

on clicked;tipo="T"
st_enunciado.text = " Fecha Hasta:"
rb_pendientes.checked=FALSE
rb_repetir.checked=FALSE
st_desde.visible = TRUE
em_fecha_desde.visible = TRUE
f_activar_campo(em_fecha_desde)
end on

type st_enunciado from statictext within w_int_etiquetas_contactos
integer x = 878
integer y = 188
integer width = 393
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Hasta"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_etiquetas_contactos
integer x = 878
integer y = 280
integer width = 393
integer height = 92
integer taborder = 40
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_int_etiquetas_contactos
boolean visible = false
integer x = 37
integer y = 48
integer width = 247
integer height = 76
integer taborder = 130
boolean bringtotop = true
boolean livescroll = true
end type

type rb_repetir from radiobutton within w_int_etiquetas_contactos
integer x = 32
integer y = 320
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Repetir"
end type

on clicked;tipo="R"
rb_pendientes.checked=FALSE
rb_todos.checked=FALSE
st_enunciado.text = " Dia a Repetir:"
st_desde.visible = FALSE
em_fecha_desde.visible = FALSE
f_activar_campo(em_fecha)
end on

type pb_preliminar_etiqueta from picturebutton within w_int_etiquetas_contactos
integer x = 1760
integer y = 184
integer width = 119
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\prelimi.bmp"
end type

event clicked;Integer periodo
periodo = year(Date(em_fecha.text))
Datetime fecha1,fecha2,fecha_listado
fecha_listado = DateTime(Date(em_fecha.text))
f_reset()
fecha1= Datetime(Date(em_fecha_desde.text))
fecha2= Datetime(Date(em_fecha.text))

If tipo = "R" Then
  fecha1= DateTime(MDY(01,01,periodo))
  fecha2= DateTime(MDY(12,31,periodo))
END IF

IF tipo = "R" Then	dw_preliminar.DataObject    = "report_etiquetas_contactos_repetir"
IF tipo = "P" Then	dw_preliminar.DataObject    = "report_etiquetas_contactos_pdtes"
IF tipo = "T" Then	dw_preliminar.DataObject    = "report_etiquetas_contactos_nuevo"
IF Trim(uo_contacto.em_codigo.text) <> "" Then
		dw_preliminar.DataObject    = "report_etiquetas_un_contacto"
END IF

dw_preliminar.SetTransObject(SQLCA)
dw_preliminar.visible=TRUE

Integer registros
ii_valor_zoom = 60
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + String(ii_valor_zoom) + ")")
IF Trim(uo_contacto.em_codigo.text) <> "" Then
	dw_preliminar.retrieve(codigo_empresa,periodo,fecha1,fecha2,uo_contacto.em_codigo.text)
ELSE
	IF tipo = "R" Then
		dw_preliminar.retrieve(codigo_empresa,periodo,fecha_listado)
	ELSE
		IF tipo = "T" Then
			dw_preliminar.retrieve(codigo_empresa,fecha1,fecha2)
		else
			dw_preliminar.retrieve(codigo_empresa,periodo,fecha1,fecha2)
		end if
	END IF
END IF
st_texto.text= String(dw_preliminar.RowCount()) + " Etiquetas"
f_pagina()
f_activar_campo(em_fecha)
  


end event

type pb_imprimir_etiqueta from picturebutton within w_int_etiquetas_contactos
integer x = 1641
integer y = 184
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;str_parametros pa
pb_preliminar_etiqueta.TriggerEvent(Clicked!)
dw_report = dw_preliminar
pa.s_listado = dw_report.DataObject
OpenWithParm(w_impresoras_v2,dw_report)
IF Message.DoubleParm <> -1 THEN
	f_marcar_etiquetas()
END IF
f_activar_campo(em_fecha)
end event

type st_1 from statictext within w_int_etiquetas_contactos
integer x = 1335
integer y = 184
integer width = 297
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Etiquetas "
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_preliminar from datawindow within w_int_etiquetas_contactos
integer x = 9
integer y = 584
integer width = 2843
integer height = 1228
boolean bringtotop = true
string dataobject = "report_cartas_contactos_preliminar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event clicked;IF Row =0 Then Return
This.SetRowFocusIndicator(Hand!)
end event

type st_pagina from statictext within w_int_etiquetas_contactos
integer x = 1650
integer y = 492
integer width = 434
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_anterior from picturebutton within w_int_etiquetas_contactos
integer x = 151
integer y = 484
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\prior1.bmp"
string disabledname = "c:\bmp\prior2.bmp"
end type

on clicked;dw_preliminar.ScrollPriorPage()
f_pagina()
f_activar_campo(em_fecha)
end on

type pb_ultimo from picturebutton within w_int_etiquetas_contactos
integer x = 375
integer y = 484
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\last1.bmp"
string disabledname = "c:\bmp\last2.bmp"
end type

on clicked;dw_preliminar.ScrollToRow(999999)
f_pagina()
f_activar_campo(em_fecha)
end on

type pb_primero from picturebutton within w_int_etiquetas_contactos
integer x = 41
integer y = 484
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\first1.bmp"
string disabledname = "c:\bmp\first2.bmp"
end type

on clicked;dw_preliminar.ScrollToRow(0)
f_pagina()
f_activar_campo(em_fecha)
end on

type pb_siguiente from picturebutton within w_int_etiquetas_contactos
integer x = 261
integer y = 484
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\next1.bmp"
string disabledname = "c:\bmp\next2.bmp"
end type

on clicked;dw_preliminar.ScrollNextPage()
f_pagina()
f_activar_campo(em_fecha)
end on

type pb_imprimir_carta from picturebutton within w_int_etiquetas_contactos
integer x = 1641
integer y = 284
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;str_parametros pa
pb_preliminar_carta.TriggerEvent(Clicked!)
dw_report = dw_preliminar
pa.s_listado = dw_report.DataObject
OpenWithParm(w_impresoras_v2,dw_report)
IF Message.DoubleParm <> -1 THEN
	f_marcar_cartas()
END IF
f_activar_campo(em_fecha)
end event

type pb_preliminar_carta from picturebutton within w_int_etiquetas_contactos
integer x = 1760
integer y = 284
integer width = 119
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\prelimi.bmp"
end type

event clicked;Integer periodo
periodo = year(Date(em_fecha.text))
Datetime fecha2,fecha1,fecha_listado
fecha_listado = DateTime(Date(em_fecha.text))
fecha1= Datetime(Date(em_fecha_desde.text))
fecha2= Datetime(Date(em_fecha.text))
If tipo = "R" Then
  fecha1= DateTime(MDY(01,01,periodo))
  fecha2= DateTime(MDY(12,31,periodo))
END IF
IF tipo = "T" Then dw_preliminar.DataObject    = "report_cartas_contactos"
IF tipo = "P" Then dw_preliminar.DataObject    = "report_cartas_contactos_pendientes"
IF tipo = "R" Then dw_preliminar.DataObject    = "report_cartas_contactos_repetir"
IF Trim(uo_contacto.em_codigo.text) <> "" Then
	dw_preliminar.DataObject    = "report_cartas_un_contacto"
END IF
dw_preliminar.SetTransObject(SQLCA)

dw_preliminar.visible=TRUE
Integer registros
ii_valor_zoom = 77
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + String(ii_valor_zoom) + ")")

IF Trim(uo_contacto.em_codigo.text) <> "" Then
	dw_preliminar.retrieve(codigo_empresa,periodo,fecha1,fecha2,uo_contacto.em_codigo.text)
ELSE	
	IF tipo = "R" Then
		dw_preliminar.retrieve(codigo_empresa,periodo,fecha_listado)
	ELSE	
		dw_preliminar.retrieve(codigo_empresa,periodo,fecha1,fecha2)
	END IF
END IF

st_texto.text= String(dw_preliminar.RowCount()) + " Cartas"
f_pagina()
f_activar_campo(em_fecha)
  


end event

type st_2 from statictext within w_int_etiquetas_contactos
integer x = 1335
integer y = 284
integer width = 297
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cartas "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_int_etiquetas_contactos
integer x = 494
integer y = 484
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

on clicked;str_parametros pa
pa.s_listado = dw_preliminar.DataObject
OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_fecha)
end on

type st_texto from statictext within w_int_etiquetas_contactos
integer x = 731
integer y = 492
integer width = 704
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_int_etiquetas_contactos
integer x = 1321
integer y = 144
integer width = 576
integer height = 248
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_int_etiquetas_contactos
integer x = 9
integer y = 436
integer width = 631
integer height = 148
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type gb_3 from groupbox within w_int_etiquetas_contactos
integer x = 1509
integer y = 436
integer width = 718
integer height = 148
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type gb_2 from groupbox within w_int_etiquetas_contactos
integer x = 635
integer y = 436
integer width = 882
integer height = 148
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type cb_1 from u_boton within w_int_etiquetas_contactos
integer x = 2034
integer y = 232
integer height = 92
integer taborder = 150
string text = "&Contacto"
end type

on clicked;call u_boton::clicked;uo_contacto.visible = TRUE
f_activar_campo(uo_contacto.em_campo)
end on

type uo_contacto from u_em_campo_2 within w_int_etiquetas_contactos
boolean visible = false
integer x = 1970
integer y = 232
integer width = 768
integer height = 112
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de contactos"
ue_datawindow = "dw_ayuda_contactos"
ue_filtro     = ""
valor_empresa = TRUE

end on

on modificado;call u_em_campo_2::modificado;uo_contacto.em_campo.text=f_razon_o_compuesto_contacto(codigo_empresa,uo_contacto.em_codigo.text)
IF Trim(uo_contacto.em_campo.text)="" THEN 
 IF Trim(uo_contacto.em_codigo.text)<>"" Then uo_contacto.em_campo.SetFocus()
 uo_contacto.em_campo.text=""
 uo_contacto.em_codigo.text=""
END IF


end on

on uo_contacto.destroy
call u_em_campo_2::destroy
end on

type st_desde from statictext within w_int_etiquetas_contactos
integer x = 485
integer y = 188
integer width = 393
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Desde"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha_desde from u_em_campo within w_int_etiquetas_contactos
integer x = 485
integer y = 280
integer width = 393
integer height = 92
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type gb_4 from groupbox within w_int_etiquetas_contactos
integer x = 471
integer y = 152
integer width = 818
integer height = 240
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

