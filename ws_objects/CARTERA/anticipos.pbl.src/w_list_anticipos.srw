$PBExportHeader$w_list_anticipos.srw
forward
global type w_list_anticipos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_list_anticipos
end type
type em_anyo from editmask within w_list_anticipos
end type
type st_8 from statictext within w_list_anticipos
end type
type em_vencimiento from u_em_campo within w_list_anticipos
end type
type em_plazo_real from u_em_campo within w_list_anticipos
end type
type st_9 from statictext within w_list_anticipos
end type
type st_nombre_banco from statictext within w_list_anticipos
end type
type dw_1 from datawindow within w_list_anticipos
end type
type cb_consultar from commandbutton within w_list_anticipos
end type
type cb_desmarcar from commandbutton within w_list_anticipos
end type
type gb_5 from groupbox within w_list_anticipos
end type
type gb_3 from groupbox within w_list_anticipos
end type
type gb_2 from groupbox within w_list_anticipos
end type
type gb_1 from groupbox within w_list_anticipos
end type
type pb_cartas from picturebutton within w_list_anticipos
end type
type st_5 from statictext within w_list_anticipos
end type
type dw_listado from datawindow within w_list_anticipos
end type
type rb_1 from radiobutton within w_list_anticipos
end type
type rb_2 from radiobutton within w_list_anticipos
end type
type em_banco from u_em_campo within w_list_anticipos
end type
type st_1 from statictext within w_list_anticipos
end type
type docs from multilineedit within w_list_anticipos
end type
type cb_marcar from commandbutton within w_list_anticipos
end type
end forward

global type w_list_anticipos from w_int_con_empresa
integer width = 2793
integer height = 1644
pb_1 pb_1
em_anyo em_anyo
st_8 st_8
em_vencimiento em_vencimiento
em_plazo_real em_plazo_real
st_9 st_9
st_nombre_banco st_nombre_banco
dw_1 dw_1
cb_consultar cb_consultar
cb_desmarcar cb_desmarcar
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
pb_cartas pb_cartas
st_5 st_5
dw_listado dw_listado
rb_1 rb_1
rb_2 rb_2
em_banco em_banco
st_1 st_1
docs docs
cb_marcar cb_marcar
end type
global w_list_anticipos w_list_anticipos

type variables
string filtro

editmask isle_campo

integer var_ejercicio
string es_nacional
boolean inst_nuevo


str_paramemp em
int dec_moneda
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Impresión de Anticipos"
This.title=istr_parametros.s_titulo_ventana


dw_1.settransobject(sqlca)
dw_listado.settransobject(sqlca)

em_anyo.text = string(year(today()))

pb_cartas.enabled = false


em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)

//f_mascara_columna(dw_1,"importe",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_listado,"importe",f_mascara_decimales(dec_moneda))

rb_1.checked = true
rb_2.checked = false






end event

on w_list_anticipos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_anyo=create em_anyo
this.st_8=create st_8
this.em_vencimiento=create em_vencimiento
this.em_plazo_real=create em_plazo_real
this.st_9=create st_9
this.st_nombre_banco=create st_nombre_banco
this.dw_1=create dw_1
this.cb_consultar=create cb_consultar
this.cb_desmarcar=create cb_desmarcar
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.pb_cartas=create pb_cartas
this.st_5=create st_5
this.dw_listado=create dw_listado
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_banco=create em_banco
this.st_1=create st_1
this.docs=create docs
this.cb_marcar=create cb_marcar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_anyo
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.em_vencimiento
this.Control[iCurrent+5]=this.em_plazo_real
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.st_nombre_banco
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.cb_consultar
this.Control[iCurrent+10]=this.cb_desmarcar
this.Control[iCurrent+11]=this.gb_5
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.pb_cartas
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.dw_listado
this.Control[iCurrent+18]=this.rb_1
this.Control[iCurrent+19]=this.rb_2
this.Control[iCurrent+20]=this.em_banco
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.docs
this.Control[iCurrent+23]=this.cb_marcar
end on

on w_list_anticipos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_anyo)
destroy(this.st_8)
destroy(this.em_vencimiento)
destroy(this.em_plazo_real)
destroy(this.st_9)
destroy(this.st_nombre_banco)
destroy(this.dw_1)
destroy(this.cb_consultar)
destroy(this.cb_desmarcar)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.pb_cartas)
destroy(this.st_5)
destroy(this.dw_listado)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.docs)
destroy(this.cb_marcar)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_list_anticipos
integer x = 2185
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_list_anticipos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_list_anticipos
integer x = 9
integer y = 4
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_list_anticipos
integer x = 2615
integer y = 8
integer width = 146
integer height = 136
integer taborder = 0
end type

type em_anyo from editmask within w_list_anticipos
integer x = 1563
integer y = 180
integer width = 192
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type st_8 from statictext within w_list_anticipos
integer x = 2958
integer y = 324
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Vencimiento :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_vencimiento from u_em_campo within w_list_anticipos
integer x = 3378
integer y = 332
integer width = 270
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = ""
end type

type em_plazo_real from u_em_campo within w_list_anticipos
integer x = 3442
integer y = 424
integer width = 206
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = "0"
end type

type st_9 from statictext within w_list_anticipos
integer x = 2935
integer y = 424
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Plazo Real :"
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_list_anticipos
integer x = 453
integer y = 200
integer width = 914
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_list_anticipos
integer x = 41
integer y = 352
integer width = 2720
integer height = 828
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_list_anticipos"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string punte,moneda
dec divisas, cambio

if dwo.name = "punt" then
	punte = dw_1.getitemstring(row,"punt")
	if punte = "S" then
		dw_1.setitem(row,"punt","N")
		dw_1.setitem(row,"importe",0)
	else
		dw_1.setitem(row,"punt","S")
		divisas = dw_1.getitemnumber(row,"divisasfinan")
		moneda = dw_1.getitemstring(row,"moneda")
		cambio = f_cambio_moneda(moneda)
		dw_1.setitem(row, "importe", round( divisas / cambio , 2)		)
		//dw_1.setitem(row,"importe",round(f_cambio_moneda(moneda) * divisas,dec_moneda)  )
	end if
	
end if
end event

type cb_consultar from commandbutton within w_list_anticipos
integer x = 2002
integer y = 172
integer width = 329
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;int registros ,i,situ
dec divisas, cambio
string moneda
registros = dw_1.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text))

// Por defecto ponemos como punteado el que tiene situación 0 (no listado)
if registros > 0 then
	pb_cartas.enabled = true
	for i = 1 to registros
		situ = dw_1.getitemnumber(i,"situacion")		
		if situ = 0 then 
			dw_1.setitem(i,"punt","S")	
			divisas = dw_1.getitemnumber(i,"divisasfinan")
			moneda = dw_1.getitemstring(i,"moneda")
			cambio = f_cambio_moneda(moneda)
			dw_1.setitem(i, "importe", round( divisas / cambio , 2) )
			//dw_1.setitem(i,"importe",round(f_cambio_moneda(moneda) * divisas,dec_moneda)  )
		end if		
	next

else
	pb_cartas.enabled = false
	
	
end if


end event

type cb_desmarcar from commandbutton within w_list_anticipos
integer x = 411
integer y = 1180
integer width = 366
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desmarcar"
end type

event clicked;int i
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i,"punt","N")	
	dw_1.setitem(i,"importe",0)	
next
end event

type gb_5 from groupbox within w_list_anticipos
integer x = 46
integer y = 1260
integer width = 581
integer height = 188
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Modelo carta"
end type

type gb_3 from groupbox within w_list_anticipos
integer x = 1920
integer y = 108
integer width = 494
integer height = 200
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_list_anticipos
integer x = 1417
integer y = 104
integer width = 480
integer height = 204
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Año Anticipo"
end type

type gb_1 from groupbox within w_list_anticipos
integer x = 59
integer y = 104
integer width = 1353
integer height = 204
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Banco Anticipo"
end type

type pb_cartas from picturebutton within w_list_anticipos
event clicked pbm_bnclicked
integer x = 2405
integer y = 1288
integer width = 183
integer height = 160
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\bmp\imp32.bmp"
string disabledname = "\bmp\imp32_no.bmp"
alignment htextalign = left!
end type

event clicked;int i,cuantos,opci
string punte

cuantos = 0
for i = 1 to dw_1.rowcount()
	punte = dw_1.getitemstring(i,"punt")
	if punte = "S" then
		cuantos = cuantos + 1
	end if
next



if cuantos >0 then
	
	opci = 2 //messagebox("Atención","¿ Desea imprimir la CABECERA en la carta ?",question!,yesno!,1)
				
else
	f_mensaje("Atención","NO hay ANTICIPOS seleccionados ")
	return
end if


// Si se quiere imprimir la cabecera
string cabecera
if opci = 1 then
	cabecera = "S"
else	
	cabecera = "N"
end if



//***********************************************************************
// IMPRESIÓN ANTICIPOS
// **********************************************************************


// Según el tipo de carta elegido
if rb_1.checked then 	
	dw_listado.dataobject = "report_carta_anticipo2"
else
	dw_listado.dataobject = "report_carta_anticipo_poliza"
end if

dw_listado.settransobject(sqlca)

for i = 1 to dw_1.rowcount()
	punte = dw_1.getitemstring(i,"punt")
	if punte = "S" then
		int el_anyo,la_prorroga,el_contador
		dec{2} el_importe
		string el_banco
		
		el_anyo = dw_1.getitemnumber(i,"anyo")
		el_banco = dw_1.getitemstring(i,"bancofinan")
		la_prorroga = dw_1.getitemnumber(i,"num_prorroga")
		el_contador = dw_1.getitemnumber(i,"contador")
		el_importe = dw_1.getitemnumber(i,"importe")

		dw_listado.retrieve(codigo_empresa,el_anyo,el_banco,la_prorroga,el_contador,cabecera,el_importe,em.moneda_emp, docs.text)		
		f_imprimir_datawindow(dw_listado)
		
	end if
next

int opcion
opcion = messagebox("Atención","¿ La impresión es correcta ?",question!,yesno!,1)
if opcion = 1 then
	for i = 1 to dw_1.rowcount()
		punte = dw_1.getitemstring(i,"punt")
		if punte = "S" then		
			
			el_anyo = dw_1.getitemnumber(i,"anyo")
			el_banco = dw_1.getitemstring(i,"bancofinan")
			la_prorroga = dw_1.getitemnumber(i,"num_prorroga")
			el_contador = dw_1.getitemnumber(i,"contador")
			
						
			// cambiamos la situación del anticipo. situación 1 
			update carfinan
			set situacion = 1
			where (empresa = :codigo_empresa) and
					(bancofinan = :el_banco) and
					(contador = :el_contador) and
					(num_prorroga = :la_prorroga) and
					(anyo = :el_anyo);
		
		
		end if
	next
	
end if	

end event

type st_5 from statictext within w_list_anticipos
integer x = 2258
integer y = 1192
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Carta al Banco"
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_list_anticipos
boolean visible = false
integer x = 754
integer y = 116
integer width = 338
integer height = 172
integer taborder = 120
boolean bringtotop = true
string dataobject = "report_carta_anticipo2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type rb_1 from radiobutton within w_list_anticipos
integer x = 128
integer y = 1316
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Normal"
boolean checked = true
end type

type rb_2 from radiobutton within w_list_anticipos
integer x = 128
integer y = 1364
integer width = 430
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Declaración"
end type

type em_banco from u_em_campo within w_list_anticipos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 142
integer y = 192
integer width = 283
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

end event

event modificado;call super::modificado;st_nombre_banco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombre_banco.text)="" THEN 
 IF Trim(st_nombre_banco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF
end event

type st_1 from statictext within w_list_anticipos
integer x = 805
integer y = 1184
integer width = 873
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Documentos que se adjuntan:"
boolean focusrectangle = false
end type

type docs from multilineedit within w_list_anticipos
integer x = 809
integer y = 1248
integer width = 1426
integer height = 200
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_marcar from commandbutton within w_list_anticipos
integer x = 41
integer y = 1180
integer width = 366
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar"
end type

event clicked;int i
dec divisas, cambio
string moneda
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i,"punt","S")	
	divisas = dw_1.getitemnumber(i,"divisasfinan")
	moneda = dw_1.getitemstring(i,"moneda")	
	cambio = f_cambio_moneda(moneda)
	dw_1.setitem(i,"importe", round( divisas / cambio , 2 )		)
next
end event

