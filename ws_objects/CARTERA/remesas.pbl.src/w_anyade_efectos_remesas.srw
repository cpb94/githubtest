$PBExportHeader$w_anyade_efectos_remesas.srw
$PBExportComments$incluido en w_modifica_remesas
forward
global type w_anyade_efectos_remesas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_anyade_efectos_remesas
end type
type em_banco from u_em_campo within w_anyade_efectos_remesas
end type
type st_1 from statictext within w_anyade_efectos_remesas
end type
type st_nombre_banco from statictext within w_anyade_efectos_remesas
end type
type em_remesa from u_em_campo within w_anyade_efectos_remesas
end type
type st_fecha from statictext within w_anyade_efectos_remesas
end type
type st_4 from statictext within w_anyade_efectos_remesas
end type
type st_2 from statictext within w_anyade_efectos_remesas
end type
type st_3 from statictext within w_anyade_efectos_remesas
end type
type dw_1 from datawindow within w_anyade_efectos_remesas
end type
type p_bandera from picture within w_anyade_efectos_remesas
end type
type st_16 from statictext within w_anyade_efectos_remesas
end type
type st_7 from statictext within w_anyade_efectos_remesas
end type
type em_vto_desde from editmask within w_anyade_efectos_remesas
end type
type em_vto_hasta from editmask within w_anyade_efectos_remesas
end type
type st_9 from statictext within w_anyade_efectos_remesas
end type
type cb_1 from commandbutton within w_anyade_efectos_remesas
end type
type uo_tipodoc from u_marca_lista within w_anyade_efectos_remesas
end type
type gb_1 from groupbox within w_anyade_efectos_remesas
end type
type st_12 from statictext within w_anyade_efectos_remesas
end type
type cb_continuar from commandbutton within w_anyade_efectos_remesas
end type
type dw_detalle from datawindow within w_anyade_efectos_remesas
end type
type dw_efectos_marcados from datawindow within w_anyade_efectos_remesas
end type
type uo_tiporem from u_em_campo_2 within w_anyade_efectos_remesas
end type
type st_13 from statictext within w_anyade_efectos_remesas
end type
type em_anyorem from u_em_campo within w_anyade_efectos_remesas
end type
type dw_remesas from datawindow within w_anyade_efectos_remesas
end type
end forward

global type w_anyade_efectos_remesas from w_int_con_empresa
integer x = 18
integer y = 108
integer width = 3511
integer height = 2080
pb_1 pb_1
em_banco em_banco
st_1 st_1
st_nombre_banco st_nombre_banco
em_remesa em_remesa
st_fecha st_fecha
st_4 st_4
st_2 st_2
st_3 st_3
dw_1 dw_1
p_bandera p_bandera
st_16 st_16
st_7 st_7
em_vto_desde em_vto_desde
em_vto_hasta em_vto_hasta
st_9 st_9
cb_1 cb_1
uo_tipodoc uo_tipodoc
gb_1 gb_1
st_12 st_12
cb_continuar cb_continuar
dw_detalle dw_detalle
dw_efectos_marcados dw_efectos_marcados
uo_tiporem uo_tiporem
st_13 st_13
em_anyorem em_anyorem
dw_remesas dw_remesas
end type
global w_anyade_efectos_remesas w_anyade_efectos_remesas

type variables
string filtro

integer var_ejercicio

string tipo_doc,es_nacional,situacion_efectos
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_refrescar ()
public subroutine f_procesar ()
end prototypes

public subroutine f_control ();Dec 		registros
Datetime fecha1
String	situ
integer i
string marca

dw_detalle.Reset()

dw_detalle.SetTransObject(sqlca)

situ = '0'

// Recogemos los tipos de documento
string tipodoc[]
string tipo

for i = 1 to uo_tipodoc.dw_marca.rowcount()
	marca = 	uo_tipodoc.dw_marca.getitemstring(i,"marca")
	if marca = "S" then
		tipo = uo_tipodoc.dw_marca.getitemstring(i,"codigo")		
		tipodoc[upperbound(tipodoc) + 1] = tipo		
	end if		
next


dw_detalle.Retrieve(codigo_empresa,tipodoc,Datetime(Date(em_vto_desde.text)),DateTime(Date(em_vto_hasta.text)),situ,es_nacional)


registros = dw_detalle.RowCount()
If registros = 0 Then Return

dw_detalle.visible   = true
em_vto_desde.enabled = false
em_vto_hasta.enabled = false

cb_continuar.enabled = false

dw_detalle.enabled   = true

dw_detalle.setfocus()
end subroutine

public subroutine f_refrescar ();long indice,total,anyo,orden,posicion
dec  var_importe,var_total,var_dif

//em_total.text = "0"
f_control()
total = dw_efectos_marcados.rowcount()
for indice = 1 to total
	anyo      = dw_efectos_marcados.object.anyo[indice]
	orden     = dw_efectos_marcados.object.orden[indice]	
	posicion  = dw_detalle.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_detalle.rowcount())
	if posicion > 0 then
		dw_detalle.object.libre[posicion] = "S"
		var_importe        = dw_detalle.object.importe[posicion]
		//var_total          = dec(em_total.text) + var_importe
		//var_dif            = var_max - var_total
		//em_total.text      = string(var_total)
		//em_diferencia.text = string(var_dif)
	else
		dw_efectos_marcados.deleterow(indice)	 		
	end if
next


end subroutine

public subroutine f_procesar ();long     anyo,orden,remesa,anyo_remesa
string   banco,tipo_remesa,naciextra,situacion
dec      importe,divisas
long     indice,total
datetime fecha_rem
boolean  bien = true
total = dw_detalle.rowcount()
if messagebox("Atención","¿ Desea incluir en la remesa los efectos seleccionados ?",question!,yesno!,2) = 1 then
	for indice = 1 to total
		if dw_detalle.object.libre[indice] = "S" then	
			anyo        = dw_detalle.object.anyo[indice]
			orden       = dw_detalle.object.orden[indice]
			banco       = em_banco.text
			anyo_remesa = dec(em_anyorem.text)
			remesa      = dec(em_remesa.text)
			fecha_rem   = datetime(date(st_fecha.text))
			tipo_remesa = uo_tiporem.em_codigo.text
			if es_nacional = "S" then
				naciextra = "N"
				situacion = "1"
			else
				naciextra = "E"
				situacion = "6"
			end if
			importe     = dw_detalle.object.importe[indice]
			divisas     = dw_detalle.object.divisas[indice]
			update carefectos
			set    banco        = :banco,
					 remesa       = :remesa,
					 fremesa      = :fecha_rem,
					 situacion    = :situacion,
					 anyo_remesa  = :anyo_remesa,					 
					 tipo_remesa  = :tipo_remesa
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo
			and    orden        = :orden;
			
			if sqlca.sqlcode = 0 then
				update carremesas
				set importe = importe +:importe,
					 divisas = divisas +:divisas
				where empresa    = :codigo_empresa
				and   anyo       = :anyo_remesa
				and   banco      = :banco
				and   naci_extra = :naciextra
				and   remesa     = :remesa;
				if sqlca.sqlcode <> 0 then
					messagebox("Atención","Se ha producido un error al actualizar la remesa.")
					bien = false
				end if
			else
				bien = false
				messagebox("Atención","Se ha producido un error al actualizar el efecto en cartera.")
			end if
		end if
	next
	if bien then
		dw_efectos_marcados.reset()
		commit;
	else
		rollback;
	end if
	em_remesa.triggerevent("modificado")
	dw_detalle.reset()
	em_banco.enabled     = true
	em_anyorem.enabled   = true
	em_remesa.enabled    = true
	dw_detalle.visible   = false
	em_vto_desde.enabled = true
	em_vto_hasta.enabled = true
	cb_continuar.enabled = true
	dw_detalle.enabled   = false
end if
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Inclusión de efectos en remesas"
This.title=istr_parametros.s_titulo_ventana

dw_remesas.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)

em_anyorem.text = string(year(today()))
if tipo_vista = "Nacional" then
	es_nacional = "S"
	situacion_efectos = "1"
	p_bandera.picturename = "\bmp\nacional.bmp"
else
	IF tipo_vista = "Exportacion" THEN
		es_nacional = "N"
		situacion_efectos = "6"
		p_bandera.picturename = "\bmp\export.bmp"
	ELSE
		MessageBox("ERROR","Debe seleccionar Nacional o Exportacion",Exclamation!)
		es_nacional = "X"
		p_bandera.picturename = ""
	END IF
end if
str_paramemp em
em = f_paramemp(codigo_empresa)
Integer x3,registros3 
String var_codigo3,var_texto3,marca3
DataStore dw_comodin
//dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'")
f_cargar_cursor_nuevo("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'", dw_comodin)
dw_comodin.setsort("number(tipodoc)")
dw_comodin.sort()
registros3=dw_comodin.RowCOunt()
If registros3<>0 THEN
 FOR x3= 1 To registros3
  var_codigo3  = dw_comodin.GetItemString(x3,"tipodoc")
  var_texto3   = dw_comodin.GetItemString(x3,"texto")
  marca3="S"
  uo_tipodoc.dw_marca.InsertRow(x3)
  uo_tipodoc.dw_marca.setitem(x3,"marca",marca3)
  uo_tipodoc.dw_marca.setitem(x3,"codigo",var_codigo3)
  uo_tipodoc.dw_marca.setitem(x3,"texto",var_texto3)
NEXT
END IF
uo_tipodoc.st_titulo1.text="Tipo Doc."
uo_tipodoc.st_titulo2.text="Descripcion"

destroy dw_comodin
end event

on w_anyade_efectos_remesas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_banco=create em_banco
this.st_1=create st_1
this.st_nombre_banco=create st_nombre_banco
this.em_remesa=create em_remesa
this.st_fecha=create st_fecha
this.st_4=create st_4
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.p_bandera=create p_bandera
this.st_16=create st_16
this.st_7=create st_7
this.em_vto_desde=create em_vto_desde
this.em_vto_hasta=create em_vto_hasta
this.st_9=create st_9
this.cb_1=create cb_1
this.uo_tipodoc=create uo_tipodoc
this.gb_1=create gb_1
this.st_12=create st_12
this.cb_continuar=create cb_continuar
this.dw_detalle=create dw_detalle
this.dw_efectos_marcados=create dw_efectos_marcados
this.uo_tiporem=create uo_tiporem
this.st_13=create st_13
this.em_anyorem=create em_anyorem
this.dw_remesas=create dw_remesas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_banco
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_nombre_banco
this.Control[iCurrent+5]=this.em_remesa
this.Control[iCurrent+6]=this.st_fecha
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.p_bandera
this.Control[iCurrent+12]=this.st_16
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.em_vto_desde
this.Control[iCurrent+15]=this.em_vto_hasta
this.Control[iCurrent+16]=this.st_9
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.uo_tipodoc
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.st_12
this.Control[iCurrent+21]=this.cb_continuar
this.Control[iCurrent+22]=this.dw_detalle
this.Control[iCurrent+23]=this.dw_efectos_marcados
this.Control[iCurrent+24]=this.uo_tiporem
this.Control[iCurrent+25]=this.st_13
this.Control[iCurrent+26]=this.em_anyorem
this.Control[iCurrent+27]=this.dw_remesas
end on

on w_anyade_efectos_remesas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.st_nombre_banco)
destroy(this.em_remesa)
destroy(this.st_fecha)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.p_bandera)
destroy(this.st_16)
destroy(this.st_7)
destroy(this.em_vto_desde)
destroy(this.em_vto_hasta)
destroy(this.st_9)
destroy(this.cb_1)
destroy(this.uo_tipodoc)
destroy(this.gb_1)
destroy(this.st_12)
destroy(this.cb_continuar)
destroy(this.dw_detalle)
destroy(this.dw_efectos_marcados)
destroy(this.uo_tiporem)
destroy(this.st_13)
destroy(this.em_anyorem)
destroy(this.dw_remesas)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_anyade_efectos_remesas
integer x = 2377
integer y = 1352
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_anyade_efectos_remesas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_anyade_efectos_remesas
integer x = 9
integer y = 4
integer width = 2427
integer height = 108
end type

type pb_1 from upb_salir within w_anyade_efectos_remesas
integer x = 3301
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type em_banco from u_em_campo within w_anyade_efectos_remesas
integer x = 5
integer y = 196
integer width = 137
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type st_1 from statictext within w_anyade_efectos_remesas
integer y = 120
integer width = 1513
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Banco "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_anyade_efectos_remesas
integer x = 151
integer y = 200
integer width = 1358
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_remesa from u_em_campo within w_anyade_efectos_remesas
integer x = 1792
integer y = 196
integer width = 338
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
end type

event modificado;call super::modificado;datetime fecha_rem
dec{2}   anyo_rem,rem
string   naciextra,situacion,tiporem

dw_1.reset()

anyo_rem = dec(em_anyorem.text)

if es_nacional = "S" then
	naciextra = "N"
else
	naciextra = "E"
end if

if em_remesa.text <> "" then
	
	rem = dec(em_remesa.text)
	
	setnull(fecha_rem)
	setnull(tipo_doc)
	
	SELECT carremesas.fremesa,
			 carremesas.tipodoc,
			 carremesas.situacion,
			 carremesas.tiporem
	INTO   :fecha_rem,
			 :tipo_doc,
			 :situacion,
			 :tiporem
   FROM  carremesas
	WHERE carremesas.empresa    = :codigo_empresa
	AND	carremesas.anyo		 = :anyo_rem
	AND	carremesas.banco		 = :em_banco.text
	AND   carremesas.naci_extra = :naciextra
	AND	carremesas.remesa		 = :rem USING SQLCA;
	
	IF SQLCA.SQLCode = 100 THEN
		MessageBox("Remesas","No existe la Remesa",Exclamation!)
		em_remesa.text = ""
		f_activar_campo(em_remesa)	
	else
		if es_nacional = "S" then
			if not(situacion = "0" or situacion = "1") then
				MessageBox("Remesas","No se pueden modificar efectos de una remesa "+f_nombre_carsiturem(codigo_empresa,situacion),Exclamation!)
				em_remesa.text = ""
				f_activar_campo(em_remesa)
			end if
		else
			if not(situacion = "0" or situacion = "1" or situacion = "2") then
				MessageBox("Remesas","No se pueden modificar efectos de una remesa "+f_nombre_carsiturem(codigo_empresa,situacion),Exclamation!)
				em_remesa.text = ""
				f_activar_campo(em_remesa)
			end if
		end if
	END IF
	
	uo_tiporem.em_codigo.text = tiporem
	uo_tiporem.em_campo.text  = f_nombre_cartiporem(codigo_empresa,uo_tiporem.em_codigo.text)
	
	if isnull(tipo_doc) then
		tipo_doc = ""
		//st_tipodoc.text = ""
	else
		//st_tipodoc.text = f_nombre_cartipodoc(codigo_empresa,string(tipo_doc))	
	end if
	
	if isnull(fecha_rem) then	
		st_fecha.visible = false	
	else
		st_fecha.visible = true
		st_fecha.text = string(date(fecha_rem))
	end if
	
	dw_1.retrieve(codigo_empresa,integer(em_anyorem.text),em_banco.text,integer(em_remesa.text),es_nacional,situacion_efectos)
		
end if
end event

type st_fecha from statictext within w_anyade_efectos_remesas
integer x = 2135
integer y = 196
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_anyade_efectos_remesas
integer x = 1513
integer y = 120
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Año"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_anyade_efectos_remesas
integer x = 1792
integer y = 120
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 16711680
long backcolor = 15780518
string text = "Nº Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;string naciextra,situaciones[1 to 3]

IF Trim(em_banco.text) = "" THEN f_activar_campo(em_banco)

IF Trim(em_anyorem.text) = "" THEN em_anyorem.SetFocus()

dw_1.reset()
if es_nacional = "S" then
	naciextra = "N"
	situaciones[1] = "0"
	situaciones[2] = "1"
	situaciones[3] = "1"
else
	naciextra = "E"
	situaciones[1] = "0"
	situaciones[2] = "1"
	situaciones[3] = "2"	
end if
dw_remesas.Retrieve(codigo_empresa,em_banco.text,Dec(em_anyorem.text),naciextra,situaciones)
dw_remesas.visible = TRUE
end event

type st_3 from statictext within w_anyade_efectos_remesas
integer x = 2130
integer y = 120
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
string text = "Fecha Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_anyade_efectos_remesas
integer y = 284
integer width = 2779
integer height = 592
string dataobject = "dw_anyade_efectos_remesas"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long   anyo,orden,remesa,anyo_remesa
string banco,vnacional,naciextra
dec    importe,divisas

if row > 0 then
	if f_objeto_datawindow(this) = "borrar" then
		if messagebox("Atención","¿ Desea sacar de la remesa el efecto seleccionado ?",question!,yesno!,2) = 1 then
			anyo        = this.object.anyo[row]
			orden       = this.object.orden[row]
			banco       = this.object.banco[row]
			anyo_remesa = this.object.anyo_remesa[row]
			remesa      = this.object.remesa[row]
			vnacional   = this.object.nacional[row]
			if vnacional = "S" then
				naciextra = "N"
			else
				naciextra = "E"
			end if
			importe     = this.object.importe[row]
			divisas     = this.object.divisas[row]
			update carefectos
			set    banco        = null,
			       remesa       = null,
					 fremesa      = null,
					 situacion    = "0",
					 anyo_remesa  = null,
					 remesa_total = null,
					 tipo_remesa  = null
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo
			and    orden        = :orden;
			
			if sqlca.sqlcode = 0 then
				update carremesas
				set importe = importe -:importe,
				    divisas = divisas -:divisas
				where empresa    = :codigo_empresa
				and   anyo       = :anyo_remesa
				and   banco      = :banco
				and   naci_extra = :naciextra
				and   remesa     = :remesa;
				if sqlca.sqlcode = 0 then
					commit;
					em_remesa.triggerevent("modificado")
				else
					rollback;
					messagebox("Atención","Se ha producido un error al actualizar la remesa.")
				end if
			else
				rollback;
				messagebox("Atención","Se ha producido un error al actualizar el efecto en cartera.")
			end if
		end if
	end if
end if
end event

type p_bandera from picture within w_anyade_efectos_remesas
integer x = 14
integer y = 128
integer width = 73
integer height = 60
boolean bringtotop = true
string picturename = "c:\bmp\nacional.bmp"
boolean focusrectangle = false
end type

type st_16 from statictext within w_anyade_efectos_remesas
integer x = 2798
integer y = 420
integer width = 306
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_anyade_efectos_remesas
integer x = 3104
integer y = 420
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_vto_desde from editmask within w_anyade_efectos_remesas
event modified pbm_enmodified
integer x = 2798
integer y = 488
integer width = 306
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event losefocus;
IF trim(em_vto_desde.text) = "00-00-00"  THEN
	em_vto_desde.text = '01-01-95'
END IF
end event

type em_vto_hasta from editmask within w_anyade_efectos_remesas
integer x = 3104
integer y = 488
integer width = 288
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event losefocus;IF Trim(em_vto_hasta.text) = '00-00-00' OR IsNull(em_vto_desde.text) THEN
	em_vto_hasta.text = '31-12-15'
END IF

end event

event modified;IF DateTime(Date(em_vto_desde.text)) > DateTime(Date(em_vto_hasta.text)) THEN
	MessageBox("Error en fechas","Fecha DESDE Mayor que fecha HASTA",Exclamation!)
	f_activar_campo(em_vto_desde)
END IF

end event

type st_9 from statictext within w_anyade_efectos_remesas
integer x = 2798
integer y = 564
integer width = 594
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tipo Efec. a Remesar"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_anyade_efectos_remesas
integer x = 2798
integer y = 688
integer width = 594
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tipo de Documento"
end type

event clicked;uo_tipodoc.visible = not(uo_tipodoc.visible)

end event

type uo_tipodoc from u_marca_lista within w_anyade_efectos_remesas
event destroy ( )
boolean visible = false
integer x = 2043
integer y = 860
integer width = 1358
integer height = 656
integer taborder = 110
boolean border = false
end type

on uo_tipodoc.destroy
call u_marca_lista::destroy
end on

type gb_1 from groupbox within w_anyade_efectos_remesas
integer x = 2784
integer y = 288
integer width = 622
integer height = 588
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Efectos :"
end type

type st_12 from statictext within w_anyade_efectos_remesas
integer x = 2798
integer y = 340
integer width = 594
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Vencimiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_continuar from commandbutton within w_anyade_efectos_remesas
integer x = 2798
integer y = 784
integer width = 594
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Consultar"
end type

event clicked;
IF em_vto_desde.text = '00-00-00' THEN
	f_activar_campo(em_vto_desde)
END IF

IF em_vto_hasta.text = '00-00-00' THEN
	f_activar_campo(em_vto_hasta)
END IF

//em_maximo.triggerevent(modified!)
//uo_tipo2.visible=false
//

//var_max = Dec(em_maximo.text)

//IF IsNull(var_max) THEN var_max = 0

//IF var_max = 0 THEN
//	st_dif.visible 		 = FALSE
//	em_diferencia.visible = FALSE
//ELSE
//	st_dif.visible 		 = TRUE
//	em_diferencia.visible = TRUE
//END IF

uo_tipodoc.visible = false
em_banco.enabled   = false
em_anyorem.enabled = false
em_remesa.enabled  = false

if dw_efectos_marcados.rowcount() = 0 then
	f_control()
else
	f_refrescar()
end if

end event

type dw_detalle from datawindow within w_anyade_efectos_remesas
integer y = 884
integer width = 3406
integer height = 968
integer taborder = 100
boolean enabled = false
string dataobject = "dw_con_efectos_anyade_remesa"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;
IF f_objeto_datawindow(This) = "e_vto" Then
	SetSort("")
	SetSort("fvto")
	Sort()
	Return
END IF
IF f_objeto_datawindow(This) = "e_importe" Then
	SetSort("")
	SetSort("importe")
	Sort()
	Return
END IF

IF f_objeto_datawindow(This) = "e_cliente" Then
	SetSort("")
	SetSort("genter_razon")
	Sort()
	Return
END IF
IF f_objeto_datawindow(This) = "imprimir" Then
	this.accepttext()
	f_imprimir_datawindow(this)
END IF
IF f_objeto_datawindow(This) = "refrescar" Then	
	f_refrescar()
END IF
IF f_objeto_datawindow(This) = "procesar" Then	
	f_procesar()
END IF
IF f_objeto_datawindow(This) = "salir" Then	
	em_banco.enabled     = true
	em_anyorem.enabled   = true
	em_remesa.enabled    = true
	dw_detalle.visible   = false
	em_vto_desde.enabled = true
	em_vto_hasta.enabled = true
	cb_continuar.enabled = true
	dw_detalle.enabled   = false
	this.reset()
end if

if row=0 then return

decimal var_importe,var_total,var_dif
Integer linea
String controles
long anyo,orden,posicion

linea = row
IF linea = 0 Then Return

controles =  This.GetItemString(linea,"libre")
anyo      =  this.object.anyo[linea]
orden     =  this.object.orden[linea]

IF controles = "S" THEN
  This.SetItem(linea,"libre","N")
  var_importe = this.getitemnumber(linea,"importe")
//  var_total=dec(em_total.text) - var_importe
//  var_dif = var_max + var_total
//  em_total.text=string(var_total)
//  em_diferencia.text=string(var_dif)
  posicion = dw_efectos_marcados.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_efectos_marcados.rowcount())
  if posicion > 0 then
		dw_efectos_marcados.deleterow(posicion)	 
  end if
ELSE
  This.SetItem(linea,"libre","S")
  var_importe=this.getitemnumber(linea,"importe")
//  var_total=dec(em_total.text)+var_importe
//  var_dif=var_max - var_total
//  em_total.text=string(var_total)
//  em_diferencia.text=string(var_dif)
  posicion = dw_efectos_marcados.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_efectos_marcados.rowcount())
  if posicion = 0 then
		posicion = dw_efectos_marcados.insertrow(0)	 
		dw_efectos_marcados.object.anyo[posicion]  = anyo
		dw_efectos_marcados.object.orden[posicion] = orden
  end if  
End If


end event

event rbuttondown;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

type dw_efectos_marcados from datawindow within w_anyade_efectos_remesas
boolean visible = false
integer x = 2455
integer width = 713
integer height = 312
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Efectos marcados"
string dataobject = "dw_efectos_marcados_remesa"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_tiporem from u_em_campo_2 within w_anyade_efectos_remesas
event destroy ( )
integer x = 2519
integer y = 196
integer width = 891
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tiporem.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Tipo de REMESAS"
ue_datawindow ="dw_ayuda_cartiporem"
valor_empresa = TRUE

end event

type st_13 from statictext within w_anyade_efectos_remesas
integer x = 2519
integer y = 120
integer width = 891
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tipo de Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_anyorem from u_em_campo within w_anyade_efectos_remesas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1513
integer y = 196
integer width = 279
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
end type

event modificado;call super::modificado;em_remesa.text = ""
end event

event losefocus;call super::losefocus;IF em_anyorem.text = "" THEN
	f_activar_campo(em_anyorem)
END IF
end event

type dw_remesas from datawindow within w_anyade_efectos_remesas
boolean visible = false
integer x = 645
integer y = 288
integer width = 1490
integer height = 760
boolean bringtotop = true
boolean titlebar = true
string title = "Selección Remesas"
string dataobject = "dw_con_simul_remesas2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;String tipodoc

IF row > 0 THEN
	em_remesa.text   	 = String(dw_remesas.GetItemNumber(row,"remesa"),"######")
	st_fecha.visible 	 = true
	st_fecha.text 		 = String(Date(dw_remesas.GetItemDateTime(dw_remesas.GetRow(),"fremesa")),"dd-mm-yy")
//	tipo_doc				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
//	tipodoc 				 = dw_remesas.GetItemString(dw_remesas.GetRow(),"tipodoc")
// st_tipodoc.text 	 = f_nombre_cartipodoc(codigo_empresa,tipodoc)
	dw_remesas.visible = FALSE
	dw_remesas.Reset()
	
	em_remesa.TriggerEvent("modificado")
	
else
	dw_remesas.visible = FALSE
	dw_remesas.Reset()
END IF
end event

