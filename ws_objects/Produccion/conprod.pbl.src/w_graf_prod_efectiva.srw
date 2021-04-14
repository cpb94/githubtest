$PBExportHeader$w_graf_prod_efectiva.srw
forward
global type w_graf_prod_efectiva from w_int_con_empresa
end type
type pb_1 from upb_salir within w_graf_prod_efectiva
end type
type pb_2 from upb_imprimir within w_graf_prod_efectiva
end type
type cb_1 from commandbutton within w_graf_prod_efectiva
end type
type gb_1 from groupbox within w_graf_prod_efectiva
end type
type gb_6 from groupbox within w_graf_prod_efectiva
end type
type dw_informe from datawindow within w_graf_prod_efectiva
end type
type em_fdesde from u_em_campo within w_graf_prod_efectiva
end type
type em_fhasta from u_em_campo within w_graf_prod_efectiva
end type
type cbx_finde from checkbox within w_graf_prod_efectiva
end type
type dw_3fue_ink from datawindow within w_graf_prod_efectiva
end type
type dw_ink from datawindow within w_graf_prod_efectiva
end type
type dw_encajado from datawindow within w_graf_prod_efectiva
end type
type dw_mono from datawindow within w_graf_prod_efectiva
end type
type dw_3fue_ink_mono from datawindow within w_graf_prod_efectiva
end type
type st_1 from statictext within w_graf_prod_efectiva
end type
type st_2 from statictext within w_graf_prod_efectiva
end type
type sle_semanas from singlelineedit within w_graf_prod_efectiva
end type
type dw_graf_pvid from datawindow within w_graf_prod_efectiva
end type
type dw_3fue from datawindow within w_graf_prod_efectiva
end type
type dw_bico from datawindow within w_graf_prod_efectiva
end type
type uo_familia from u_em_campo_2 within w_graf_prod_efectiva
end type
type gb_8 from groupbox within w_graf_prod_efectiva
end type
end forward

global type w_graf_prod_efectiva from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 8512
integer height = 3688
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
cbx_finde cbx_finde
dw_3fue_ink dw_3fue_ink
dw_ink dw_ink
dw_encajado dw_encajado
dw_mono dw_mono
dw_3fue_ink_mono dw_3fue_ink_mono
st_1 st_1
st_2 st_2
sle_semanas sle_semanas
dw_graf_pvid dw_graf_pvid
dw_3fue dw_3fue
dw_bico dw_bico
uo_familia uo_familia
gb_8 gb_8
end type
global w_graf_prod_efectiva w_graf_prod_efectiva

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data, string seccion[], boolean mostrar_texto, string familia)
end prototypes

public subroutine f_control (datawindow data, string seccion[], boolean mostrar_texto, string familia);Datetime  fecha1,fecha2
string mes, cliente
dec{0} total_cenefas, total_bico, total_3f, total_4f, total_mold3f, total_mold4f, total_pedidos
dec{0} total_dec, total_esq, total_tacos
long fila_actual


data.SetTransObject(SQLCA)
data.Reset()
fecha1 = datetime(em_fdesde.text)
fecha2 = datetime(em_fhasta.text)


data.retrieve(codigo_empresa, fecha1, fecha2, seccion, familia) 
data.setredraw(false)		
if mostrar_texto then
	data.object.T1.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text
end if


data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Producción Frente a Producción efectiva"
This.title=istr_parametros.s_titulo_ventana


em_fhasta.text = string(RelativeDate(today(), -1),"dd-mm-yy")
sle_semanas.text = '1'
em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")







end event

on w_graf_prod_efectiva.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.cbx_finde=create cbx_finde
this.dw_3fue_ink=create dw_3fue_ink
this.dw_ink=create dw_ink
this.dw_encajado=create dw_encajado
this.dw_mono=create dw_mono
this.dw_3fue_ink_mono=create dw_3fue_ink_mono
this.st_1=create st_1
this.st_2=create st_2
this.sle_semanas=create sle_semanas
this.dw_graf_pvid=create dw_graf_pvid
this.dw_3fue=create dw_3fue
this.dw_bico=create dw_bico
this.uo_familia=create uo_familia
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.cbx_finde
this.Control[iCurrent+10]=this.dw_3fue_ink
this.Control[iCurrent+11]=this.dw_ink
this.Control[iCurrent+12]=this.dw_encajado
this.Control[iCurrent+13]=this.dw_mono
this.Control[iCurrent+14]=this.dw_3fue_ink_mono
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.sle_semanas
this.Control[iCurrent+18]=this.dw_graf_pvid
this.Control[iCurrent+19]=this.dw_3fue
this.Control[iCurrent+20]=this.dw_bico
this.Control[iCurrent+21]=this.uo_familia
this.Control[iCurrent+22]=this.gb_8
end on

on w_graf_prod_efectiva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.cbx_finde)
destroy(this.dw_3fue_ink)
destroy(this.dw_ink)
destroy(this.dw_encajado)
destroy(this.dw_mono)
destroy(this.dw_3fue_ink_mono)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_semanas)
destroy(this.dw_graf_pvid)
destroy(this.dw_3fue)
destroy(this.dw_bico)
destroy(this.uo_familia)
destroy(this.gb_8)
end on

event ue_f5;string secciones[]
string familia = '%'

if uo_familia.em_campo.text <> "" then 
	familia = uo_familia.em_codigo.text
else
	familia = '%'
end if


secciones[1] = '3'
f_control(dw_informe,secciones, true, familia)
secciones[1] = '1'
f_control(dw_3fue,secciones, false, familia)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_graf_prod_efectiva
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_graf_prod_efectiva
end type

type st_empresa from w_int_con_empresa`st_empresa within w_graf_prod_efectiva
integer x = 27
integer width = 8430
integer height = 80
end type

type pb_1 from upb_salir within w_graf_prod_efectiva
integer x = 8311
integer y = 136
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_graf_prod_efectiva
integer x = 8183
integer y = 136
integer taborder = 0
end type

event clicked;string secciones[]
string familia = '%'

if uo_familia.em_campo.text <> "" then 
	familia = uo_familia.em_codigo.text
else
	familia = '%'
end if

secciones[1] = '3'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_informe,secciones,true, familia)
f_imprimir_datawindow(dw_informe)

secciones[1] = '2'
secciones[2] = '0'
secciones[3] = '0'
f_control(dw_mono, secciones, false, familia)

secciones[1] = '1'
secciones[2] = '2'
secciones[3] = '10'
f_control(dw_3fue_ink_mono, secciones, false, familia)

secciones[1] = '1'
secciones[2] = '0'
secciones[3] = '0'
f_control(dw_3fue,secciones, false, familia)
f_imprimir_datawindow(dw_3fue)

secciones[1] = '10'
secciones[2] = '0'
secciones[3] = '0'
f_control(dw_ink, secciones, false, familia)

secciones[1] = '1'
secciones[2] = '10'
secciones[3] = '0'
f_control(dw_3fue_ink,secciones, false, familia)

secciones[1] = '9'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_encajado, secciones, false, familia)



f_imprimir_datawindow(dw_3fue_ink)


end event

type cb_1 from commandbutton within w_graf_prod_efectiva
integer x = 7858
integer y = 136
integer width = 288
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;boolean mostrar_texto
string secciones[]
mostrar_texto = True
String familia

if not cbx_finde.checked then
	dw_informe.DataObject = "dw_graf_prod_efectiva_laborales"
	dw_3fue.DataObject = "dw_graf_prod_3fue_laborales"
	dw_3fue_ink.DataObject = "dw_graf_prod_3fue_ink_laborales"
	dw_mono.DataObject = "dw_graf_mono_laborales"
	dw_3fue_ink_mono.DataObject = "dw_graf_3fue_ink_mono_laborales"
	dw_ink.DataObject = "dw_graf_ink_laborales"
	dw_encajado.DataObject = "dw_graf_encajado_laborales"
	dw_graf_pvid.DataObject = "dw_graf_pvid_laborales"
	dw_bico.DataObject = "dw_graf_prod_bico_laborales"
else
	dw_informe.DataObject = "dw_graf_prod_efectiva"
	dw_3fue.DataObject = "dw_graf_prod_3fue"
	dw_3fue_ink.DataObject = "dw_graf_prod_3fue_ink"
	dw_mono.DataObject = "dw_graf_mono"
	dw_3fue_ink_mono.DataObject = "dw_graf_3fue_ink_mono"
	dw_ink.DataObject = "dw_graf_ink"
	dw_encajado.DataObject = "dw_graf_encajado"
	dw_graf_pvid.DataObject = "dw_graf_pvid"
	dw_bico.DataObject = "dw_graf_prod_bico"
end if

if uo_familia.em_campo.text <> "" then 
	familia = uo_familia.em_codigo.text
else
	familia = '%'
end if

secciones[1] = '3'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_informe, secciones,mostrar_texto, familia)
mostrar_texto = False

secciones[1] = '2'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_mono, secciones, mostrar_texto, familia)

secciones[1] = '1'
secciones[2] = '2'
secciones[3] = '10'
f_control(dw_3fue_ink_mono, secciones, mostrar_texto, familia)

secciones[1] = '1'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_3fue, secciones, mostrar_texto, familia)

secciones[1] = '10'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_ink, secciones, mostrar_texto, familia)


secciones[1] = '6'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_graf_pvid, secciones, mostrar_texto, familia)

secciones[1] = '1'
secciones[2] = '10'
secciones[3] = '0'


f_control(dw_3fue_ink, secciones, mostrar_texto, familia)


secciones[1] = '9'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_encajado, secciones, mostrar_texto, familia)

secciones[1] = '0'
secciones[2] = '0'
secciones[3] = '0'

f_control(dw_bico, secciones, mostrar_texto, familia)


end event

type gb_1 from groupbox within w_graf_prod_efectiva
integer x = 69
integer y = 108
integer width = 763
integer height = 152
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_6 from groupbox within w_graf_prod_efectiva
integer x = 7822
integer y = 96
integer width = 635
integer height = 148
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_graf_prod_efectiva
integer x = 32
integer y = 276
integer width = 2775
integer height = 1608
boolean bringtotop = true
string dataobject = "dw_graf_prod_efectiva"
boolean vscrollbar = true
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_graf_prod_efectiva
integer x = 96
integer y = 160
integer width = 352
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_graf_prod_efectiva
integer x = 453
integer y = 160
integer width = 352
integer height = 76
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type cbx_finde from checkbox within w_graf_prod_efectiva
integer x = 1467
integer y = 164
integer width = 809
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Incluir fines de semana"
boolean lefttext = true
end type

type dw_3fue_ink from datawindow within w_graf_prod_efectiva
integer x = 2811
integer y = 1892
integer width = 2816
integer height = 812
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_graf_prod_3fue_ink"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_ink from datawindow within w_graf_prod_efectiva
integer x = 2811
integer y = 1088
integer width = 2830
integer height = 796
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_graf_ink"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_encajado from datawindow within w_graf_prod_efectiva
integer x = 5646
integer y = 1896
integer width = 2816
integer height = 812
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_graf_encajado"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_mono from datawindow within w_graf_prod_efectiva
integer x = 32
integer y = 1892
integer width = 2775
integer height = 812
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_graf_mono"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_3fue_ink_mono from datawindow within w_graf_prod_efectiva
integer x = 5655
integer y = 1080
integer width = 2816
integer height = 812
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_graf_3fue_ink_mono"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_1 from statictext within w_graf_prod_efectiva
integer x = 6907
integer y = 176
integer width = 878
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217856
long backcolor = 12632256
string text = "El informe trabaja con buenas"
boolean focusrectangle = false
end type

type st_2 from statictext within w_graf_prod_efectiva
integer x = 846
integer y = 164
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Semanas:"
boolean focusrectangle = false
end type

type sle_semanas from singlelineedit within w_graf_prod_efectiva
integer x = 1152
integer y = 156
integer width = 201
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event losefocus;if long(sle_semanas.text) = 1 then
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")
else
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), ( -7 * ( long( sle_semanas.text ) -1 ) ) - 6 ),"dd-mm-yy")
end if

end event

type dw_graf_pvid from datawindow within w_graf_prod_efectiva
integer x = 5655
integer y = 276
integer width = 2816
integer height = 812
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_graf_encajado"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_3fue from datawindow within w_graf_prod_efectiva
integer x = 2811
integer y = 276
integer width = 2830
integer height = 812
integer taborder = 30
string dataobject = "dw_graf_prod_3fue"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_bico from datawindow within w_graf_prod_efectiva
integer x = 2811
integer y = 2708
integer width = 2816
integer height = 812
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_graf_prod_bico"
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_familia from u_em_campo_2 within w_graf_prod_efectiva
event destroy ( )
integer x = 2359
integer y = 152
integer width = 526
integer taborder = 80
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_8 from groupbox within w_graf_prod_efectiva
integer x = 2336
integer y = 88
integer width = 567
integer height = 184
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "FAMILIA"
end type

