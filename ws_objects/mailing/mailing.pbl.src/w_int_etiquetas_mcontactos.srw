$PBExportHeader$w_int_etiquetas_mcontactos.srw
forward
global type w_int_etiquetas_mcontactos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_mcontactos
end type
type rb_si from radiobutton within w_int_etiquetas_mcontactos
end type
type rb_todos from radiobutton within w_int_etiquetas_mcontactos
end type
type report_etiquetas from datawindow within w_int_etiquetas_mcontactos
end type
type report_cartas from datawindow within w_int_etiquetas_mcontactos
end type
type em_carta from u_em_campo within w_int_etiquetas_mcontactos
end type
type st_1 from statictext within w_int_etiquetas_mcontactos
end type
type st_nombre_carta from statictext within w_int_etiquetas_mcontactos
end type
type dw_proceso from datawindow within w_int_etiquetas_mcontactos
end type
type rb_no from radiobutton within w_int_etiquetas_mcontactos
end type
type dw_proceso_paises from datawindow within w_int_etiquetas_mcontactos
end type
type rb1_si from radiobutton within w_int_etiquetas_mcontactos
end type
type rb1_todos from radiobutton within w_int_etiquetas_mcontactos
end type
type rb1_no from radiobutton within w_int_etiquetas_mcontactos
end type
type gb1_1 from groupbox within w_int_etiquetas_mcontactos
end type
type rb2_si from radiobutton within w_int_etiquetas_mcontactos
end type
type rb2_todos from radiobutton within w_int_etiquetas_mcontactos
end type
type rb2_no from radiobutton within w_int_etiquetas_mcontactos
end type
type gb2_1 from groupbox within w_int_etiquetas_mcontactos
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_mcontactos
end type
type pb_imprimir_cartas from upb_imprimir within w_int_etiquetas_mcontactos
end type
type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_mcontactos
end type
type pb_preliminar_cartas from upb_preliminar within w_int_etiquetas_mcontactos
end type
type st_2 from statictext within w_int_etiquetas_mcontactos
end type
type st_3 from statictext within w_int_etiquetas_mcontactos
end type
type st_pagina from statictext within w_int_etiquetas_mcontactos
end type
type pb_imprimir_preli from picturebutton within w_int_etiquetas_mcontactos
end type
type st_texto from statictext within w_int_etiquetas_mcontactos
end type
type gb1_2 from groupbox within w_int_etiquetas_mcontactos
end type
type pb_ultimo from picturebutton within w_int_etiquetas_mcontactos
end type
type pb_siguiente from picturebutton within w_int_etiquetas_mcontactos
end type
type pb_anterior from picturebutton within w_int_etiquetas_mcontactos
end type
type pb_primero from picturebutton within w_int_etiquetas_mcontactos
end type
type uo_idiomas from u_marca_lista within w_int_etiquetas_mcontactos
end type
type uo_paises from u_marca_lista within w_int_etiquetas_mcontactos
end type
type dw_preliminar from datawindow within w_int_etiquetas_mcontactos
end type
type gb_1 from groupbox within w_int_etiquetas_mcontactos
end type
type gb_2 from groupbox within w_int_etiquetas_mcontactos
end type
type uo_mconcepto from u_em_campo_2 within w_int_etiquetas_mcontactos
end type
type st_4 from statictext within w_int_etiquetas_mcontactos
end type
end forward

global type w_int_etiquetas_mcontactos from w_int_con_empresa
integer width = 2949
integer height = 1628
pb_1 pb_1
rb_si rb_si
rb_todos rb_todos
report_etiquetas report_etiquetas
report_cartas report_cartas
em_carta em_carta
st_1 st_1
st_nombre_carta st_nombre_carta
dw_proceso dw_proceso
rb_no rb_no
dw_proceso_paises dw_proceso_paises
rb1_si rb1_si
rb1_todos rb1_todos
rb1_no rb1_no
gb1_1 gb1_1
rb2_si rb2_si
rb2_todos rb2_todos
rb2_no rb2_no
gb2_1 gb2_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
pb_imprimir_cartas pb_imprimir_cartas
pb_preliminar_etiquetas pb_preliminar_etiquetas
pb_preliminar_cartas pb_preliminar_cartas
st_2 st_2
st_3 st_3
st_pagina st_pagina
pb_imprimir_preli pb_imprimir_preli
st_texto st_texto
gb1_2 gb1_2
pb_ultimo pb_ultimo
pb_siguiente pb_siguiente
pb_anterior pb_anterior
pb_primero pb_primero
uo_idiomas uo_idiomas
uo_paises uo_paises
dw_preliminar dw_preliminar
gb_1 gb_1
gb_2 gb_2
uo_mconcepto uo_mconcepto
st_4 st_4
end type
global w_int_etiquetas_mcontactos w_int_etiquetas_mcontactos

type variables
string filtro,activo,distribuidor,tipo, filtroidiomas,montaje,filtropaises
Integer  registro
String opcion

end variables

forward prototypes
public subroutine f_filtros ()
public subroutine f_pagina ()
end prototypes

public subroutine f_filtros ();Integer numero,registros,x1,y1
y1=0
filtroidiomas  =  ""
filtropaises   =  ""

numero = uo_idiomas.dw_marca.RowCount()
IF numero =0 Then return

FOR x1 = 1 To numero
IF uo_idiomas.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF trim(filtroidiomas) = "" Then
    montaje = " idioma = '" + uo_idiomas.dw_marca.GetItemString(x1,"codigo") + "'"
 Else
    montaje = " Or idioma = '" + uo_idiomas.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtroidiomas = filtroidiomas + montaje
END IF
NEXT

y1=0
numero = uo_paises.dw_marca.RowCount()
IF numero =0 Then return
FOR x1 = 1 To numero
IF uo_paises.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF Trim(filtropaises)="" Then
    montaje = " pais = '" + uo_paises.dw_marca.GetItemString(x1,"codigo") + "'"
 Else
    montaje = " Or pais = '" + uo_paises.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtropaises = filtropaises + montaje
END IF
NEXT

If activo="S" Then  filtro = " activo = 'S' and "
If activo="N" Then  filtro = " activo = 'N' and "
IF activo="T" Then  filtro = " (activo = 'N'  or activo = 'S' ) and "
IF distribuidor = "S" Then  filtro = filtro + " distribuidor = 'S'  and "
IF distribuidor = "N" Then  filtro = filtro + " distribuidor = 'N'  and  "
IF distribuidor = "T" Then  filtro = filtro + " (distribuidor = 'S'  or distribuidor = 'N'  ) and "
IF tipo = "S"  Then  filtro = filtro + " tipoter = 'S'  "
IF tipo = "C"  Then  filtro = filtro + " tipoter = 'C'  "
IF tipo = "T"  Then  filtro = filtro + " (tipoter = 'S'  or tipoter = 'C' )"
IF (Trim(filtroidiomas) <> "" OR Trim(filtro) <> "") and Trim(filtropaises)<>"" THEN
  filtropaises = "(" + filtropaises + ") and "
END IF

IF Trim(filtro) <> "" and (filtroidiomas ) <> ""  THEN
  filtroidiomas = "(" + filtroidiomas + ") and "
END IF
filtro = filtropaises + filtroidiomas + filtro




end subroutine

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

event ue_listar;Integer registros
  dw_report.SetTransObject(SQLCA)
  filtro = ""
  dw_report.SetFilter(filtro)
  dw_report.Filter()
  f_filtros()
  dw_report.SetFilter(filtro)
  dw_report.Filter()
  IF opcion="ETIQUETAS" THEN dw_report.retrieve(codigo_empresa,uo_mconcepto.em_codigo)
  IF opcion="CARTAS"    THEN dw_report.retrieve(codigo_empresa,em_carta.text)
   
 registros = dw_report.RowCount()
 IF registros=0 Then
   MessageBox("No existen registros","No realiza el listado",Exclamation!, OK!,1)
   Return
 END IF




 CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado etiquetas clientes"
This.title=istr_parametros.s_titulo_ventana
tipo ="C"
distribuidor="T"
activo="S"

Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
dw_proceso_paises.SetTransObject(SQLCA)

registros=dw_proceso.retrieve()
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"idioma")
  var_texto   = dw_proceso.GetItemString(x1,"texto")
  marca="S"
  uo_idiomas.dw_marca.InsertRow(x1)
  uo_idiomas.dw_marca.setitem(x1,"marca",marca)
  uo_idiomas.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_idiomas.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_idiomas.st_titulo1.text="Idioma"
uo_idiomas.st_titulo2.text="Texto"


registros=dw_proceso_paises.retrieve()
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso_paises.GetItemString(x1,"pais")
  var_texto   = dw_proceso_paises.GetItemString(x1,"nombre")
  marca="S"
  uo_paises.dw_marca.InsertRow(x1)
  uo_paises.dw_marca.setitem(x1,"marca",marca)
  uo_paises.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_paises.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_paises.st_titulo1.text="Pais"
uo_paises.st_titulo2.text="Nombre"


end event

on w_int_etiquetas_mcontactos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.rb_si=create rb_si
this.rb_todos=create rb_todos
this.report_etiquetas=create report_etiquetas
this.report_cartas=create report_cartas
this.em_carta=create em_carta
this.st_1=create st_1
this.st_nombre_carta=create st_nombre_carta
this.dw_proceso=create dw_proceso
this.rb_no=create rb_no
this.dw_proceso_paises=create dw_proceso_paises
this.rb1_si=create rb1_si
this.rb1_todos=create rb1_todos
this.rb1_no=create rb1_no
this.gb1_1=create gb1_1
this.rb2_si=create rb2_si
this.rb2_todos=create rb2_todos
this.rb2_no=create rb2_no
this.gb2_1=create gb2_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.pb_imprimir_cartas=create pb_imprimir_cartas
this.pb_preliminar_etiquetas=create pb_preliminar_etiquetas
this.pb_preliminar_cartas=create pb_preliminar_cartas
this.st_2=create st_2
this.st_3=create st_3
this.st_pagina=create st_pagina
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_texto=create st_texto
this.gb1_2=create gb1_2
this.pb_ultimo=create pb_ultimo
this.pb_siguiente=create pb_siguiente
this.pb_anterior=create pb_anterior
this.pb_primero=create pb_primero
this.uo_idiomas=create uo_idiomas
this.uo_paises=create uo_paises
this.dw_preliminar=create dw_preliminar
this.gb_1=create gb_1
this.gb_2=create gb_2
this.uo_mconcepto=create uo_mconcepto
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.rb_si
this.Control[iCurrent+3]=this.rb_todos
this.Control[iCurrent+4]=this.report_etiquetas
this.Control[iCurrent+5]=this.report_cartas
this.Control[iCurrent+6]=this.em_carta
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_nombre_carta
this.Control[iCurrent+9]=this.dw_proceso
this.Control[iCurrent+10]=this.rb_no
this.Control[iCurrent+11]=this.dw_proceso_paises
this.Control[iCurrent+12]=this.rb1_si
this.Control[iCurrent+13]=this.rb1_todos
this.Control[iCurrent+14]=this.rb1_no
this.Control[iCurrent+15]=this.gb1_1
this.Control[iCurrent+16]=this.rb2_si
this.Control[iCurrent+17]=this.rb2_todos
this.Control[iCurrent+18]=this.rb2_no
this.Control[iCurrent+19]=this.gb2_1
this.Control[iCurrent+20]=this.pb_imprimir_etiquetas
this.Control[iCurrent+21]=this.pb_imprimir_cartas
this.Control[iCurrent+22]=this.pb_preliminar_etiquetas
this.Control[iCurrent+23]=this.pb_preliminar_cartas
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.st_3
this.Control[iCurrent+26]=this.st_pagina
this.Control[iCurrent+27]=this.pb_imprimir_preli
this.Control[iCurrent+28]=this.st_texto
this.Control[iCurrent+29]=this.gb1_2
this.Control[iCurrent+30]=this.pb_ultimo
this.Control[iCurrent+31]=this.pb_siguiente
this.Control[iCurrent+32]=this.pb_anterior
this.Control[iCurrent+33]=this.pb_primero
this.Control[iCurrent+34]=this.uo_idiomas
this.Control[iCurrent+35]=this.uo_paises
this.Control[iCurrent+36]=this.dw_preliminar
this.Control[iCurrent+37]=this.gb_1
this.Control[iCurrent+38]=this.gb_2
this.Control[iCurrent+39]=this.uo_mconcepto
this.Control[iCurrent+40]=this.st_4
end on

on w_int_etiquetas_mcontactos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.rb_si)
destroy(this.rb_todos)
destroy(this.report_etiquetas)
destroy(this.report_cartas)
destroy(this.em_carta)
destroy(this.st_1)
destroy(this.st_nombre_carta)
destroy(this.dw_proceso)
destroy(this.rb_no)
destroy(this.dw_proceso_paises)
destroy(this.rb1_si)
destroy(this.rb1_todos)
destroy(this.rb1_no)
destroy(this.gb1_1)
destroy(this.rb2_si)
destroy(this.rb2_todos)
destroy(this.rb2_no)
destroy(this.gb2_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.pb_imprimir_cartas)
destroy(this.pb_preliminar_etiquetas)
destroy(this.pb_preliminar_cartas)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_pagina)
destroy(this.pb_imprimir_preli)
destroy(this.st_texto)
destroy(this.gb1_2)
destroy(this.pb_ultimo)
destroy(this.pb_siguiente)
destroy(this.pb_anterior)
destroy(this.pb_primero)
destroy(this.uo_idiomas)
destroy(this.uo_paises)
destroy(this.dw_preliminar)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.uo_mconcepto)
destroy(this.st_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_mcontactos
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_mcontactos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_mcontactos
integer x = 18
integer y = 24
integer width = 2683
integer height = 108
end type

type pb_1 from upb_salir within w_int_etiquetas_mcontactos
integer x = 2715
integer y = 24
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type rb_si from radiobutton within w_int_etiquetas_mcontactos
integer x = 466
integer y = 376
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sí"
boolean checked = true
end type

on clicked;activo="S"
rb_todos.checked=FALSE
rb_no.checked=FALSE

f_activar_campo(em_carta)
end on

type rb_todos from radiobutton within w_int_etiquetas_mcontactos
integer x = 466
integer y = 496
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

on clicked;activo="T"
rb_si.checked=FALSE
rb_no.checked=FALSE
f_activar_campo(em_carta)
end on

type report_etiquetas from datawindow within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 1627
integer width = 370
integer height = 112
boolean bringtotop = true
string dataobject = "report_etiquetas_clientes_mconceptos"
boolean livescroll = true
end type

type report_cartas from datawindow within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 1257
integer width = 347
integer height = 112
boolean bringtotop = true
string dataobject = "report_cartas_clientes"
boolean livescroll = true
end type

type em_carta from u_em_campo within w_int_etiquetas_mcontactos
integer x = 242
integer y = 160
integer taborder = 10
end type

on modificado;call u_em_campo::modificado;st_nombre_carta.text=f_nombre_carta(codigo_empresa,em_carta.text)	
IF Trim(st_nombre_carta.text)="" THEN 
 IF Trim(st_nombre_carta.text)<>"" Then f_activar_campo(em_carta)
 em_carta.text=""
END IF


end on

on getfocus;call u_em_campo::getfocus;ue_titulo     = "AYUDA SELECCION CARTAS"
ue_datawindow = "dw_ayuda_cartas"
ue_filtro     = ""		


end on

type st_1 from statictext within w_int_etiquetas_mcontactos
integer y = 164
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Carta  "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_carta from statictext within w_int_etiquetas_mcontactos
integer x = 498
integer y = 164
integer width = 741
integer height = 80
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

type dw_proceso from datawindow within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 37
integer y = 72
integer width = 494
integer height = 108
boolean bringtotop = true
string dataobject = "dw_proceso_idiomas"
boolean livescroll = true
end type

type rb_no from radiobutton within w_int_etiquetas_mcontactos
integer x = 466
integer y = 432
integer width = 251
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No"
end type

on clicked;activo="N"
rb_todos.checked=FALSE
rb_si.checked=FALSE
f_activar_campo(em_carta)
end on

type dw_proceso_paises from datawindow within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 544
integer y = 72
integer width = 704
integer height = 108
boolean bringtotop = true
string dataobject = "dw_proceso_paises"
boolean livescroll = true
end type

type rb1_si from radiobutton within w_int_etiquetas_mcontactos
integer x = 73
integer y = 372
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sí"
end type

on clicked;distribuidor="S"
rb1_todos.checked=FALSE
rb1_no.checked=FALSE

f_activar_campo(em_carta)
end on

type rb1_todos from radiobutton within w_int_etiquetas_mcontactos
integer x = 73
integer y = 496
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
boolean checked = true
end type

on clicked;distribuidor="T"
rb1_si.checked=FALSE
rb1_no.checked=FALSE
f_activar_campo(em_carta)
end on

type rb1_no from radiobutton within w_int_etiquetas_mcontactos
integer x = 73
integer y = 432
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No"
end type

on clicked;distribuidor="N"
rb1_todos.checked=FALSE
rb1_si.checked=FALSE
f_activar_campo(em_carta)
end on

type gb1_1 from groupbox within w_int_etiquetas_mcontactos
integer x = 18
integer y = 308
integer width = 366
integer height = 272
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Distribuidor"
end type

type rb2_si from radiobutton within w_int_etiquetas_mcontactos
integer x = 823
integer y = 372
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Clientes"
boolean checked = true
end type

on clicked;tipo="C"
rb2_todos.checked=FALSE
rb2_no.checked=FALSE

f_activar_campo(em_carta)
end on

type rb2_todos from radiobutton within w_int_etiquetas_mcontactos
integer x = 823
integer y = 492
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

on clicked;tipo="T"
rb2_si.checked=FALSE
rb2_no.checked=FALSE
f_activar_campo(em_carta)
end on

type rb2_no from radiobutton within w_int_etiquetas_mcontactos
integer x = 823
integer y = 428
integer width = 389
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Subclientes"
end type

on clicked;tipo="S"
rb2_todos.checked=FALSE
rb2_si.checked=FALSE
f_activar_campo(em_carta)
end on

type gb2_1 from groupbox within w_int_etiquetas_mcontactos
integer x = 777
integer y = 308
integer width = 466
integer height = 272
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tipos"
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_mcontactos
integer x = 384
integer y = 612
integer height = 100
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;if trim(uo_mconcepto.em_campo.text)="" then
	f_mensaje("!A t e n c i ó n ","Debe introducir el concepto")
	f_activar_campo(uo_mconcepto.em_campo)
	return
End if
	
dw_report = report_etiquetas
opcion="ETIQUETAS"
PArent.TriggerEvent("ue_listar")
f_activar_campo(em_carta)
end event

type pb_imprimir_cartas from upb_imprimir within w_int_etiquetas_mcontactos
integer x = 1006
integer y = 612
integer height = 100
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;if trim(uo_mconcepto.em_campo.text)="" then
	f_mensaje("!A t e n c i ó n ","Debe introducir el concepto")
	f_activar_campo(uo_mconcepto.em_campo)
	return
End if

IF Trim(em_carta.text)="" or IsNull(em_carta.text) Then
    MessageBox("Campo obligatorio","Introduzca la carta",Exclamation!, OK!,1)
    em_carta.SetFocus()
    RETURN
END IF
dw_report = report_cartas

opcion="CARTAS"
w_int_etiquetas_clientes.TriggerEvent("ue_listar")
f_activar_campo(em_carta)
end event

type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_mcontactos
integer x = 498
integer y = 612
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;if trim(uo_mconcepto.em_campo.text)="" then
	f_mensaje("!A t e n c i ó n ","Debe introducir el concepto")
	f_activar_campo(uo_mconcepto.em_campo)
	return
End if

dw_preliminar.DataObject    = "report_etiquetas_clientes"
filtro = ""
dw_preliminar.SetFilter(filtro)
dw_preliminar.SetTransObject(SQLCA)
f_filtros()

dw_preliminar.visible       = True
pb_anterior.visible         = True
pb_primero.visible          = True
pb_siguiente.visible        = True
pb_ultimo.visible           = True
pb_imprimir_preli.visible   = True
st_texto.visible            = True
st_pagina.visible           = True


Integer registros
dw_preliminar.SetFilter(filtro)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = 66 ")
dw_preliminar.retrieve(codigo_empresa)
st_texto.text= String(dw_preliminar.RowCount()) + " Etiquetas"
f_pagina()
f_activar_campo(em_carta)
  


end event

type pb_preliminar_cartas from upb_preliminar within w_int_etiquetas_mcontactos
integer x = 1120
integer y = 612
integer width = 128
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;if trim(uo_mconcepto.em_campo.text)="" then
	f_mensaje("!A t e n c i ó n ","Debe introducir el concepto")
	f_activar_campo(uo_mconcepto.em_campo)
	return
End if

IF Trim(em_carta.text)="" or IsNull(em_carta.text) Then
    MessageBox("Campo obligatorio","Introduzca la carta",Exclamation!, OK!,1)
    em_carta.SetFocus()
    RETURN
END IF
filtro = ""
dw_preliminar.SetFilter(filtro)
dw_preliminar.DataObject    = "report_cartas_clientes"
dw_preliminar.SetTransObject(SQLCA)
f_filtros()
dw_preliminar.visible= True
pb_anterior.visible  = True
pb_primero.visible   = True
pb_siguiente.visible = True
pb_ultimo.visible    = True
pb_imprimir_preli.visible   = True
st_texto.visible = True
st_pagina.visible = True

Integer registros
dw_preliminar.SetFilter(filtro)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = 66 ")
dw_preliminar.retrieve(codigo_empresa,em_carta.text)
st_texto.text= String(dw_preliminar.RowCount()) + " Cartas"
f_pagina()
f_activar_campo(em_carta)
  


end event

type st_2 from statictext within w_int_etiquetas_mcontactos
integer x = 27
integer y = 612
integer width = 357
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Etiquetas  "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_etiquetas_mcontactos
integer x = 649
integer y = 612
integer width = 357
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cartas    "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_pagina from statictext within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 1568
integer y = 240
integer width = 608
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 2661
integer y = 232
integer width = 105
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

on clicked;str_parametros pa
pa.s_listado = dw_preliminar.DataObject
OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_carta)
end on

type st_texto from statictext within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 741
integer y = 240
integer width = 704
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type gb1_2 from groupbox within w_int_etiquetas_mcontactos
integer x = 402
integer y = 308
integer width = 361
integer height = 272
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Activos"
end type

type pb_ultimo from picturebutton within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 2546
integer y = 232
integer width = 105
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\last1.bmp"
string disabledname = "\bmp\last2.bmp"
end type

on clicked;dw_preliminar.ScrollToRow(999999)
f_pagina()
f_activar_campo(em_carta)
end on

type pb_siguiente from picturebutton within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 2423
integer y = 232
integer width = 105
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\next1.bmp"
string disabledname = "\bmp\next2.bmp"
end type

on clicked;dw_preliminar.ScrollNextPage()
f_pagina()
f_activar_campo(em_carta)
end on

type pb_anterior from picturebutton within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 2304
integer y = 232
integer width = 105
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\prior1.bmp"
string disabledname = "\bmp\prior2.bmp"
end type

on clicked;dw_preliminar.ScrollPriorPage()
f_pagina()
f_activar_campo(em_carta)
end on

type pb_primero from picturebutton within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 2185
integer y = 232
integer width = 105
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\first1.bmp"
string disabledname = "\bmp\first2.bmp"
end type

on clicked;dw_preliminar.ScrollToRow(0)
f_pagina()
f_activar_campo(em_carta)
end on

type uo_idiomas from u_marca_lista within w_int_etiquetas_mcontactos
integer x = 1353
integer y = 740
integer height = 664
end type

on uo_idiomas.destroy
call u_marca_lista::destroy
end on

type uo_paises from u_marca_lista within w_int_etiquetas_mcontactos
integer y = 740
integer height = 664
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

type dw_preliminar from datawindow within w_int_etiquetas_mcontactos
boolean visible = false
integer x = 5
integer y = 320
integer width = 2871
integer height = 1092
integer taborder = 40
boolean titlebar = true
string title = "Preliminar"
boolean vscrollbar = true
boolean livescroll = true
end type

on doubleclicked;dw_preliminar.visible= False
pb_anterior.visible  = False
pb_primero.visible   = False
pb_siguiente.visible = False
pb_ultimo.visible    = False
pb_imprimir_preli.visible   = False
st_texto.visible = False
st_pagina.visible = False



end on

type gb_1 from groupbox within w_int_etiquetas_mcontactos
integer x = 18
integer y = 572
integer width = 608
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_int_etiquetas_mcontactos
integer x = 640
integer y = 572
integer width = 608
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_mconcepto from u_em_campo_2 within w_int_etiquetas_mcontactos
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1362
integer y = 456
integer width = 1065
integer height = 80
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mconcepto.em_campo.text=f_nombre_mconcepto(codigo_empresa,uo_mconcepto.em_codigo.text)
IF Trim(uo_mconcepto.em_campo.text)="" THEN 
 IF Trim(uo_mconcepto.em_codigo.text)<>"" Then uo_mconcepto.em_campo.SetFocus()
 uo_mconcepto.em_campo.text=""
 uo_mconcepto.em_codigo.text=""
 Return	
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion conceptos"
ue_datawindow = "dw_ayuda_mconceptos"
ue_filtro     = ""
valor_empresa = True

end event

on uo_mconcepto.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_etiquetas_mcontactos
integer x = 1362
integer y = 372
integer width = 1065
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Selección Concepto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

